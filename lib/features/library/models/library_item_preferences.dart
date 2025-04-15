import 'package:freezed_annotation/freezed_annotation.dart';

part 'library_item_preferences.freezed.dart';

@freezed
class LibraryItemPreferences with _$LibraryItemPreferences {
  const factory LibraryItemPreferences({
    required bool showDownloadCount,
    required bool showUnreadCount,
    required bool showContinueReadingButton,
    required bool showFavorite,
    required bool? filterDownloaded,
    required bool? filterUnread,
    required bool? filterFavorite,
    required bool? filterStarted,
    required bool? filterCompleted,
    required bool? filterUpdated,
    required bool? downloadedOnlyMode,
  }) = _LibraryItemPreferences;
}
