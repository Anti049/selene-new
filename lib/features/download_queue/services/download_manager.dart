// Example: features/downloads/services/download_manager.dart
import 'dart:async';
import 'package:dartx/dartx.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:selene/core/database/models/chapter.dart';
import 'package:selene/core/database/providers/library_providers.dart';
import 'package:selene/data/remote/work_service_registry.dart';
import 'package:selene/core/logging/logger_provider.dart';
import 'package:selene/features/download_queue/models/download_task.dart';
import 'package:selene/features/notifications/services/notification_service.dart';
import 'package:selene/features/settings/screens/downloads/providers/download_preferences.dart';
import '../providers/download_queue_provider.dart';
// import 'notification_service.dart'; // Import notification service
// Import download delay preference provider

part 'download_manager.g.dart';

@Riverpod(keepAlive: true) // Keep alive
DownloadManager downloadManager(Ref ref) {
  return DownloadManager(ref);
}

class DownloadManager {
  final Ref _ref;
  bool _isCurrentlyDownloading = false; // Prevent concurrent downloads
  Timer? _delayTimer;

  DownloadManager(this._ref);

  Future<void> processQueue() async {
    if (_isCurrentlyDownloading) return; // Already processing

    final queueState = _ref.read(downloadQueueProvider);
    DownloadTask? taskToDownload;

    // Prioritize the active task if it exists and is in downloading state
    if (queueState.activeDownloadTaskId != null) {
      // Need a way to get the active task details. Assuming _getTaskById exists in notifier
      // This interaction needs careful design to avoid state inconsistencies.
      // Let's assume for now we get the next from the queue if active is null OR active is not 'downloading'
      // Fetch active task details (implementation depends on state structure)
      DownloadTask? activeTask = queueState.queue.firstOrNullWhere(
        (t) => t.taskId == queueState.activeDownloadTaskId,
      );
      if (activeTask?.status == DownloadStatus.downloading) {
        taskToDownload = activeTask; // Resume or confirm active download
      }
      // Simplified: If there's an active ID, assume it's being handled, unless queue has items.
      // This logic might need refinement based on how interruptions/resumptions are handled.
    }

    // If no active task is 'downloading', find the next 'queued' task
    if (taskToDownload == null && queueState.queue.isNotEmpty) {
      taskToDownload = queueState.queue.firstOrNullWhere(
        (t) => t.status == DownloadStatus.queued,
      );
    }

    if (taskToDownload == null) {
      _ref.read(downloadQueueProvider.notifier).setProcessing(false);
      clearNotificationIfNeeded(); // Clear notification if queue is done
      return; // No queued tasks left
    }

    _isCurrentlyDownloading = true;
    _ref.read(downloadQueueProvider.notifier).setProcessing(true);
    // Signal the notifier that this task is starting
    _ref
        .read(downloadQueueProvider.notifier)
        .taskStarted(taskToDownload.taskId);

    try {
      // --- Show/Update Notification ---
      _ref
          .read(notificationServiceProvider)
          .showDownloadNotification(
            taskId: taskToDownload.taskId,
            workTitle: taskToDownload.workTitle,
            chapterTitle: taskToDownload.chapterTitle,
            progress: 0,
            total: 100, // Or actual total if known, otherwise use indeterminate
            status: "Downloading...",
            queueLength:
                _ref.read(downloadQueueProvider).queue.length +
                1, // +1 for active
          );

      // Fetch ChapterModel if needed (assuming task only has IDs)
      final chapterRepo = _ref.read(chapterRepositoryProvider);
      ChapterModel? chapter = await chapterRepo.getChapterByID(
        taskToDownload.chapterId,
      );

      if (chapter == null) {
        throw Exception("Chapter not found in repository.");
      }

      // Get the correct WorkService
      final workServiceRegistry = _ref.read(workServiceRegistryProvider);
      final service = workServiceRegistry.getServiceByURL(chapter.sourceURL);

      if (service == null) {
        throw Exception(
          "No compatible download service found for chapter URL.",
        );
      }

      // Perform the download
      final downloadedChapter = await service.downloadChapter(
        chapter,
        onProgress: ({int? progress, int? total, String? message}) {
          final currentProgress =
              (progress != null && total != null && total > 0)
                  ? (progress / total)
                  : taskToDownload!
                      .progress; // Use last known progress if indeterminate
          _ref
              .read(downloadQueueProvider.notifier)
              .updateTaskStatus(
                taskToDownload!.taskId,
                DownloadStatus.downloading,
                progress: currentProgress,
              );
          // Update Notification Progress
          _ref
              .read(notificationServiceProvider)
              .showDownloadNotification(
                taskId: taskToDownload.taskId,
                workTitle: taskToDownload.workTitle,
                chapterTitle: taskToDownload.chapterTitle,
                progress: (currentProgress * 100).toInt(),
                total: 100,
                status: message ?? "Downloading...",
                queueLength: _ref.read(downloadQueueProvider).queue.length + 1,
              );
        },
      );

      if (downloadedChapter?.content != null &&
          downloadedChapter!.content!.isNotEmpty) {
        // Save the downloaded chapter back to the repository
        await chapterRepo.upsertChapter(downloadedChapter);
        // Signal completion to notifier
        _ref
            .read(downloadQueueProvider.notifier)
            .taskFinished(taskToDownload.taskId, true);
      } else {
        throw Exception("Downloaded chapter content was empty or null.");
      }
    } catch (e, stackTrace) {
      _ref
          .read(loggerProvider)
          .e(
            'Download failed for chapter ${taskToDownload.chapterId}',
            error: e,
            stackTrace: stackTrace,
          );
      // Signal error to notifier
      _ref
          .read(downloadQueueProvider.notifier)
          .taskFinished(taskToDownload.taskId, false, error: e.toString());

      // Update notification to show error for this task (optional)
      _ref
          .read(notificationServiceProvider)
          .showDownloadNotification(
            taskId: taskToDownload.taskId,
            workTitle: taskToDownload.workTitle,
            chapterTitle: taskToDownload.chapterTitle,
            progress: 0,
            total: 100,
            status: "Error: ${e.toString()}", // Show error briefly
            queueLength:
                _ref
                    .read(downloadQueueProvider)
                    .queue
                    .length, // Queue length decreased
          );
    } finally {
      _isCurrentlyDownloading = false;

      // --- Apply Delay and Trigger Next ---
      final delaySeconds =
          _ref.read(downloadPreferencesProvider).downloadDelaySeconds.get();
      if (_ref.read(downloadQueueProvider).queue.isNotEmpty) {
        _delayTimer?.cancel(); // Cancel any existing timer
        _delayTimer = Timer(Duration(seconds: delaySeconds), () {
          processQueue(); // Process the next item after delay
        });
      } else {
        // No more items, clear processing state and maybe notification
        _ref.read(downloadQueueProvider.notifier).setProcessing(false);
        clearNotificationIfNeeded();
      }
    }
  }

  Future<void> pauseQueue() async {
    if (_isCurrentlyDownloading) {
      _ref.read(downloadQueueProvider.notifier).setProcessing(false);
      _isCurrentlyDownloading = false;
      _delayTimer?.cancel(); // Cancel any pending delay timer
      // Optionally clear notification
      clearNotificationIfNeeded();
    }
  }

  Future<void> resumeQueue() async {
    if (!_isCurrentlyDownloading) {
      _ref.read(downloadQueueProvider.notifier).setProcessing(true);
      processQueue(); // Start processing the queue
    }
  }

  Future<void> clearQueue() async {
    _ref.read(downloadQueueProvider.notifier).clearQueue();
    _isCurrentlyDownloading = false;
    _delayTimer?.cancel(); // Cancel any pending delay timer
    // Clear notification if needed
    clearNotificationIfNeeded();
  }

  void clearNotificationIfNeeded() {
    final queueState = _ref.read(downloadQueueProvider);
    if (queueState.queue.isEmpty && queueState.activeDownloadTaskId == null) {
      _ref.read(notificationServiceProvider).cancelDownloadNotification();
    }
  }

  // Cancel any pending delay timer when the app closes or manager is disposed
  void dispose() {
    _delayTimer?.cancel();
  }
}
