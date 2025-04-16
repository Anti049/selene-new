import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:selene/core/constants/preference_constants.dart';
import 'package:selene/core/database/models/preference.dart';
import 'package:selene/core/database/providers/isar_provider.dart';
import 'package:selene/core/database/providers/preferences_stream_provider.dart';
import 'package:selene/core/utils/enums.dart';

part 'library_preferences.g.dart';

class LibraryPreferences {
  final Isar _isar; // Store Isar instance

  LibraryPreferences(this._isar); // Constructor takes Isar

  // --- Library Preferences ---
  // Library ->  General
  late final Preference<bool> showCategoryTabs = Preference<bool>(
    isar: _isar, // Pass Isar instance
    defaultValue:
        kDefaultShowCategoryTabs, // Default value for showCategoryTabs
    getter:
        (prefs) =>
            prefs.showCategoryTabs ?? kDefaultShowCategoryTabs, // Getter logic
    setter:
        (prefs, value) =>
            prefs.copyWith(showCategoryTabs: value), // Setter logic
  );
  late final Preference<bool> showWorkCount = Preference<bool>(
    isar: _isar,
    defaultValue: kDefaultShowWorkCount,
    getter: (prefs) => prefs.showWorkCount ?? kDefaultShowWorkCount,
    setter: (prefs, value) => prefs.copyWith(showWorkCount: value),
  );
  late final Preference<bool> showContinueReadingButton = Preference<bool>(
    isar: _isar,
    defaultValue: kDefaultShowContinueReadingButton,
    getter:
        (prefs) =>
            prefs.showContinueReadingButton ??
            kDefaultShowContinueReadingButton,
    setter: (prefs, value) => prefs.copyWith(showContinueReadingButton: value),
  );
  late final Preference<bool> showDownloadedCount = Preference<bool>(
    isar: _isar,
    defaultValue: kDefaultShowDownloadedCount,
    getter: (prefs) => prefs.showDownloadedCount ?? kDefaultShowDownloadedCount,
    setter: (prefs, value) => prefs.copyWith(showDownloadedCount: value),
  );
  late final Preference<bool> showUnreadCount = Preference<bool>(
    isar: _isar,
    defaultValue: kDefaultShowUnreadCount,
    getter: (prefs) => prefs.showUnreadCount ?? kDefaultShowUnreadCount,
    setter: (prefs, value) => prefs.copyWith(showUnreadCount: value),
  );
  late final Preference<bool> showFavorite = Preference<bool>(
    isar: _isar,
    defaultValue: kDefaultShowFavorite,
    getter: (prefs) => prefs.showFavorite ?? kDefaultShowFavorite,
    setter: (prefs, value) => prefs.copyWith(showFavorite: value),
  );
  // Library -> Filters
  late final Preference<TriState> filterDownloaded = Preference<TriState>(
    isar: _isar,
    defaultValue: kDefaultFilterDownloaded,
    getter: (prefs) => prefs.filterDownloaded,
    setter: (prefs, value) => prefs.copyWith(filterDownloaded: value),
  );
  late final Preference<TriState> filterUnread = Preference<TriState>(
    isar: _isar,
    defaultValue: kDefaultFilterUnread,
    getter: (prefs) => prefs.filterUnread,
    setter: (prefs, value) => prefs.copyWith(filterUnread: value),
  );
  late final Preference<TriState> filterFavorites = Preference<TriState>(
    isar: _isar,
    defaultValue: kDefaultFilterFavorites,
    getter: (prefs) => prefs.filterFavorites,
    setter: (prefs, value) => prefs.copyWith(filterFavorites: value),
  );
  late final Preference<TriState> filterStarted = Preference<TriState>(
    isar: _isar,
    defaultValue: kDefaultFilterStarted,
    getter: (prefs) => prefs.filterStarted,
    setter: (prefs, value) => prefs.copyWith(filterStarted: value),
  );
  late final Preference<TriState> filterCompleted = Preference<TriState>(
    isar: _isar,
    defaultValue: kDefaultFilterCompleted,
    getter: (prefs) => prefs.filterCompleted,
    setter: (prefs, value) => prefs.copyWith(filterCompleted: value),
  );
  late final Preference<TriState> filterUpdated = Preference<TriState>(
    isar: _isar,
    defaultValue: kDefaultFilterUpdated,
    getter: (prefs) => prefs.filterUpdated,
    setter: (prefs, value) => prefs.copyWith(filterUpdated: value),
  );
  // Library -> Sort
  late final Preference<SortBy> sortBy = Preference<SortBy>(
    isar: _isar,
    defaultValue: kDefaultSortBy,
    getter: (prefs) => prefs.sortBy,
    setter: (prefs, value) => prefs.copyWith(sortBy: value),
  );
  late final Preference<SortOrder> sortOrder = Preference<SortOrder>(
    isar: _isar,
    defaultValue: kDefaultSortOrder,
    getter: (prefs) => prefs.sortOrder,
    setter: (prefs, value) => prefs.copyWith(sortOrder: value),
  );
  // Library -> Display
  late final Preference<DisplayMode> displayMode = Preference<DisplayMode>(
    isar: _isar,
    defaultValue: kDefaultDisplayMode,
    getter: (prefs) => prefs.displayMode,
    setter: (prefs, value) => prefs.copyWith(displayMode: value),
  );
  late final Preference<double> gridSize = Preference<double>(
    isar: _isar,
    defaultValue: kDefaultGridSize,
    getter: (prefs) => prefs.gridSize ?? kDefaultGridSize,
    setter: (prefs, value) => prefs.copyWith(gridSize: value),
  );
  // Library -> Tags
  late final Preference<bool> showPublishedDate = Preference<bool>(
    isar: _isar,
    defaultValue: kDefaultShowPublishedDate,
    getter: (prefs) => prefs.showPublishedDate ?? kDefaultShowPublishedDate,
    setter: (prefs, value) => prefs.copyWith(showPublishedDate: value),
  );
  late final Preference<bool> showCharacterTags = Preference<bool>(
    isar: _isar,
    defaultValue: kDefaultShowCharacterTags,
    getter: (prefs) => prefs.showCharacterTags ?? kDefaultShowCharacterTags,
    setter: (prefs, value) => prefs.copyWith(showCharacterTags: value),
  );
  late final Preference<bool> showFriendshipTags = Preference<bool>(
    isar: _isar,
    defaultValue: kDefaultShowFriendshipTags,
    getter: (prefs) => prefs.showFriendshipTags ?? kDefaultShowFriendshipTags,
    setter: (prefs, value) => prefs.copyWith(showFriendshipTags: value),
  );
  late final Preference<bool> showRomanceTags = Preference<bool>(
    isar: _isar,
    defaultValue: kDefaultShowRomanceTags,
    getter: (prefs) => prefs.showRomanceTags ?? kDefaultShowRomanceTags,
    setter: (prefs, value) => prefs.copyWith(showRomanceTags: value),
  );
  late final Preference<bool> showFreeformTags = Preference<bool>(
    isar: _isar,
    defaultValue: kDefaultShowFreeformTags,
    getter: (prefs) => prefs.showFreeformTags ?? kDefaultShowFreeformTags,
    setter: (prefs, value) => prefs.copyWith(showFreeformTags: value),
  );
  late final Preference<bool> showDescription = Preference<bool>(
    isar: _isar,
    defaultValue: kDefaultShowDescription,
    getter: (prefs) => prefs.showDescription ?? kDefaultShowDescription,
    setter: (prefs, value) => prefs.copyWith(showDescription: value),
  );

  // --- Utility Functions ---
  void _resetLibraryPreferences(List<Preference> preferences) {
    for (final preference in preferences) {
      preference.reset();
    }
  }

  int _countActivePreferences(List<Preference> preferences) =>
      preferences.where((pref) => pref.get() != pref.defaultValue).length;

  int get numOptionsActive => _countActivePreferences([
    filterDownloaded,
    filterUnread,
    filterFavorites,
    filterStarted,
    filterCompleted,
    filterUpdated,
    sortBy,
    sortOrder,
  ]);
  bool get anyOptionsActive => numOptionsActive > 0;
  // - Library -> Filters
  void resetLibraryFilters() {
    _resetLibraryPreferences([
      filterDownloaded,
      filterUnread,
      filterFavorites,
      filterStarted,
      filterCompleted,
      filterUpdated,
    ]);
  }

  // - Library -> Sort
  void resetLibrarySort() {
    _resetLibraryPreferences([sortBy, sortOrder]);
  }

  // - Library -> Display
  void resetLibraryDisplay() {
    _resetLibraryPreferences([displayMode]);
  }
}

@riverpod
LibraryPreferences libraryPreferences(Ref ref) {
  // Get Isar instance directly when available
  final isar = ref.watch(isarProvider).requireValue;
  // Watch the overall preferences stream to trigger rebuilds if any pref changes
  ref.watch(preferencesStreamProvider);
  // Pass the Isar instance to the class constructor
  return LibraryPreferences(isar);
}
