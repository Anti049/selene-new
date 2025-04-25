import 'package:freezed_annotation/freezed_annotation.dart';
import 'download_task.dart'; // Import your DownloadTask model

part 'download_queue_state.freezed.dart';

@freezed
class DownloadQueueState with _$DownloadQueueState {
  const factory DownloadQueueState({
    @Default([]) List<DownloadTask> queue,
    String? activeDownloadTaskId, // ID of the task currently downloading
    @Default(false)
    bool isProcessing, // Is the manager actively processing the queue?
    @Default(0)
    int completedCount, // Optional: track completed downloads in session
    @Default(0) int errorCount, // Optional: track errors in session
  }) = _DownloadQueueState;
}
