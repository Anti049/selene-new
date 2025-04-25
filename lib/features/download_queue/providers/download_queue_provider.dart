// Example: features/downloads/providers/download_queue_provider.dart
import 'package:dartx/dartx.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:selene/features/download_queue/models/download_queue_state.dart';
import 'package:selene/features/download_queue/models/download_task.dart';
import 'package:selene/features/download_queue/services/download_manager.dart';

part 'download_queue_provider.g.dart';

@Riverpod(keepAlive: true) // Keep state alive across the app
class DownloadQueue extends _$DownloadQueue {
  @override
  DownloadQueueState build() {
    // Initialize or load persisted state if necessary
    return const DownloadQueueState();
  }

  void addTask(DownloadTask task) {
    if (state.queue.any((t) => t.taskId == task.taskId) ||
        state.activeDownloadTaskId == task.taskId) {
      // Avoid adding duplicates
      return;
    }
    state = state.copyWith(queue: [...state.queue, task]);
    _triggerProcessing(); // Start processing if not already active
  }

  void clearQueue() {
    state = const DownloadQueueState(); // Reset to initial state
    ref.read(downloadManagerProvider).clearNotificationIfNeeded();
  }

  void updateTaskStatus(
    String taskId,
    DownloadStatus status, {
    double? progress,
    String? error,
  }) {
    if (taskId == state.activeDownloadTaskId) {
      final activeTask = _getTaskById(taskId);
      if (activeTask != null) {
        // final updatedTask = activeTask.copyWith(
        //   status: status,
        //   progress:
        //       progress ??
        //       activeTask
        //           .progress, // Keep old progress if new one isn't provided
        //   errorMessage: error,
        // );
        // Update the state immutably
        state = state.copyWith(
          // No need to update the queue list if it's the active task
          // queue: state.queue.map((t) => t.taskId == taskId ? updatedTask : t).toList(),
          activeDownloadTaskId:
              status == DownloadStatus.downloading
                  ? taskId
                  : state.activeDownloadTaskId,
          // Update other relevant fields based on status
        );
      }
    } else {
      // Update task in the queue list
      state = state.copyWith(
        queue:
            state.queue.map((t) {
              if (t.taskId == taskId) {
                return t.copyWith(
                  status: status,
                  progress: progress ?? t.progress,
                  errorMessage: error,
                );
              }
              return t;
            }).toList(),
      );
    }
  }

  void _moveToNext() {
    final currentActiveId = state.activeDownloadTaskId;
    DownloadTask? completedOrErrorTask;

    // Find the task that just finished (or errored)
    final completedIndex = state.queue.indexWhere(
      (t) => t.taskId == currentActiveId,
    );
    if (completedIndex != -1) {
      completedOrErrorTask = state.queue[completedIndex];
    }

    // Remove the completed/errored task from the queue *if* it exists there
    // It might only exist as activeDownloadTaskId if the queue was processed fast
    final newQueue =
        state.queue.where((t) => t.taskId != currentActiveId).toList();

    DownloadTask? nextTask;
    if (newQueue.isNotEmpty) {
      nextTask = newQueue.firstOrNullWhere(
        (t) => t.status == DownloadStatus.queued, // Find the next queued task
      );
    }

    state = state.copyWith(
      queue: newQueue, // Update queue by removing the processed task
      activeDownloadTaskId:
          nextTask?.taskId, // Set next task as active, or null if none
      isProcessing: nextTask != null, // Keep processing if there's a next task
      completedCount:
          completedOrErrorTask?.status == DownloadStatus.completed
              ? state.completedCount + 1
              : state.completedCount,
      errorCount:
          completedOrErrorTask?.status == DownloadStatus.error
              ? state.errorCount + 1
              : state.errorCount,
    );

    if (nextTask != null) {
      _triggerProcessing(); // Trigger processing for the new active task
    } else {
      // Optionally call notification service to clear notification
      ref.read(downloadManagerProvider).clearNotificationIfNeeded();
    }
  }

  DownloadTask? _getTaskById(String taskId) {
    if (state.activeDownloadTaskId == taskId) {
      // How to get the active task details? Need DownloadManager interaction or store active task details in state
      // For now, search the original queue - ASSUMES task details don't change drastically
      final taskInQueue = state.queue.firstOrNullWhere(
        (t) => t.taskId == taskId,
      );
      // This is a temporary workaround. Ideally, active task details should be managed better.
      if (taskInQueue != null) return taskInQueue;
      // If not in queue, it might have been the *only* task, handle appropriately
      // This part needs refinement based on how active task details are stored/accessed.
    }
    return state.queue.firstOrNullWhere((t) => t.taskId == taskId);
  }

  void _triggerProcessing() {
    // Use ref.read to access DownloadManager without creating dependency cycle
    // Ensures processing starts only if needed and not already running
    Future.microtask(() => ref.read(downloadManagerProvider).processQueue());
  }

  DownloadTask? getActiveTask() {
    // Return the active task details if available
    if (state.activeDownloadTaskId != null) {
      return _getTaskById(state.activeDownloadTaskId!);
    }
    return null; // No active task
  }

  // Allow DownloadManager to signal completion/error
  void taskFinished(String taskId, bool success, {String? error}) {
    final status = success ? DownloadStatus.completed : DownloadStatus.error;
    updateTaskStatus(
      taskId,
      status,
      progress: success ? 1.0 : null,
      error: error,
    );
    _moveToNext();
  }

  void taskStarted(String taskId) {
    // Mark the task as downloading and make it the active one
    final taskIndex = state.queue.indexWhere((t) => t.taskId == taskId);
    if (taskIndex != -1) {
      // final taskToStart = state.queue[taskIndex];
      // Update state immutably
      state = state.copyWith(
        queue: List.from(state.queue)
          ..removeAt(taskIndex), // Remove from queue list
        activeDownloadTaskId: taskId, // Set as active
        isProcessing: true,
        // Optionally update the task status immediately to downloading
        // This depends on whether updateTaskStatus is called right after by DownloadManager
      );
      // Explicitly update status AFTER moving it to active, if needed by UI
      updateTaskStatus(taskId, DownloadStatus.downloading, progress: 0.0);
    }
  }

  void setProcessing(bool processing) {
    state = state.copyWith(isProcessing: processing);
  }

  void toggleProcessing() {
    state = state.copyWith(isProcessing: !state.isProcessing);
    final downloadManager = ref.read(downloadManagerProvider);
    if (state.isProcessing) {
      downloadManager.resumeQueue();
    } else {
      downloadManager.pauseQueue();
    }
  }
}
