import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:selene/core/database/models/preference.dart';
import 'package:selene/core/database/providers/preference_service_provider.dart';
import 'package:selene/core/database/services/preference_service.dart';
import 'package:selene/core/utils/enums.dart';

part 'library_preferences.g.dart';

class LibraryPreferences {
  final PreferenceService _preferenceService;

  LibraryPreferences(this._preferenceService);

  // Library -> Filters
  Preference<bool> get filterDownloaded => _preferenceService.filterDownloaded;
  Preference<bool> get filterUnread => _preferenceService.filterUnread;
  Preference<bool> get filterFavorites => _preferenceService.filterFavorites;
  Preference<bool> get filterStarted => _preferenceService.filterStarted;
  Preference<bool> get filterCompleted => _preferenceService.filterCompleted;
  Preference<bool> get filterUpdated => _preferenceService.filterUpdated;
  // Library -> Sort
  Preference<SortBy> get sortBy => _preferenceService.sortBy;
  Preference<SortOrder> get sortOrder => _preferenceService.sortOrder;
  // Library -> Display
  Preference<DisplayMode> get displayMode => _preferenceService.displayMode;
  Preference<bool> get showCategoryTabs => _preferenceService.showCategoryTabs;
  Preference<bool> get showWorkCount => _preferenceService.showWorkCount;
  Preference<bool> get showContinueReadingButton =>
      _preferenceService.showContinueReadingButton;
  Preference<bool> get showDownloadedCount =>
      _preferenceService.showDownloadedCount;
  Preference<bool> get showUnreadCount => _preferenceService.showUnreadCount;
  Preference<bool> get showFavorite => _preferenceService.showFavorite;

  // --- Utility Functions ---
  void _resetLibraryPreferences(List<Preference> preferences) {
    for (final preference in preferences) {
      preference.reset();
    }
  }

  int _countActivePreferences(List<Preference> preferences) =>
      preferences.where((pref) => pref.value != pref.defaultValue).length;

  int get numOptionsActive => _countActivePreferences([
    filterDownloaded,
    filterUnread,
    filterFavorites,
    filterStarted,
    filterCompleted,
    filterUpdated,
    sortBy,
    sortOrder,
    displayMode,
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
  ref.watch(preferencesStreamProvider);
  return LibraryPreferences(ref.watch(preferenceServiceProvider));
}
