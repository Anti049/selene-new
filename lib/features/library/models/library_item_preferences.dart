import 'package:freezed_annotation/freezed_annotation.dart';

part 'library_item_preferences.freezed.dart';

@freezed
class LibraryItemPreferences with _$LibraryItemPreferences {
  const LibraryItemPreferences._();

  const factory LibraryItemPreferences({
    required bool? filterDownloaded,
    required bool? filterUnread,
    required bool? filterFavorite,
    required bool? filterStarted,
    required bool? filterCompleted,
    required bool? filterUpdated,
    required bool? downloadedOnlyMode,
  }) = _LibraryItemPreferences;

  bool get hasActiveFilters =>
      filterDownloaded != null ||
      filterUnread != null ||
      filterFavorite != null ||
      filterStarted != null ||
      filterCompleted != null ||
      filterUpdated != null;
}
