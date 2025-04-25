import 'package:freezed_annotation/freezed_annotation.dart';

part 'download_task.freezed.dart';

enum DownloadStatus { queued, downloading, completed, error, paused }

@freezed
class DownloadTask with _$DownloadTask {
  const factory DownloadTask({
    required String
    taskId, // Unique ID for the task (e.g., chapter URL or generated UUID)
    required int workId,
    required String workTitle,
    required int chapterId,
    required String chapterTitle,
    @Default(DownloadStatus.queued) DownloadStatus status,
    @Default(0.0) double progress,
    String? errorMessage,
  }) = _DownloadTask;
}
