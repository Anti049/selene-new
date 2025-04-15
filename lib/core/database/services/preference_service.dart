import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:selene/core/constants/preference_constants.dart';
import 'package:selene/core/database/models/preference.dart';
import 'package:selene/core/database/tables/preferences_table.dart';
import 'package:selene/core/utils/enums.dart';

class PreferenceService {
  final Isar _isar;

  PreferenceService(this._isar);

  // --- Preference Accessors ---
  // - Library
  late final Preference<bool> showCategoryTabs = Preference<bool>(
    isar: _isar,
    defaultValue: true,
    getter: (prefs) => prefs.showCategoryTabs ?? kDefaultShowCategoryTabs,
    setter: (prefs, value) => prefs.copyWith(showCategoryTabs: value),
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
  // - Library -> Filters
  late final Preference<bool> filterDownloaded = Preference<bool>(
    isar: _isar,
    defaultValue: kDefaultFilterDownloaded,
    getter: (prefs) => prefs.filterDownloaded ?? kDefaultFilterDownloaded,
    setter: (prefs, value) => prefs.copyWith(filterDownloaded: value),
  );
  late final Preference<bool> filterUnread = Preference<bool>(
    isar: _isar,
    defaultValue: kDefaultFilterUnread,
    getter: (prefs) => prefs.filterUnread ?? kDefaultFilterUnread,
    setter: (prefs, value) => prefs.copyWith(filterUnread: value),
  );
  late final Preference<bool> filterFavorites = Preference<bool>(
    isar: _isar,
    defaultValue: kDefaultFilterFavorites,
    getter: (prefs) => prefs.filterFavorites ?? kDefaultFilterFavorites,
    setter: (prefs, value) => prefs.copyWith(filterFavorites: value),
  );
  late final Preference<bool> filterStarted = Preference<bool>(
    isar: _isar,
    defaultValue: kDefaultFilterStarted,
    getter: (prefs) => prefs.filterStarted ?? kDefaultFilterStarted,
    setter: (prefs, value) => prefs.copyWith(filterStarted: value),
  );
  late final Preference<bool> filterCompleted = Preference<bool>(
    isar: _isar,
    defaultValue: kDefaultFilterCompleted,
    getter: (prefs) => prefs.filterCompleted ?? kDefaultFilterCompleted,
    setter: (prefs, value) => prefs.copyWith(filterCompleted: value),
  );
  late final Preference<bool> filterUpdated = Preference<bool>(
    isar: _isar,
    defaultValue: kDefaultFilterUpdated,
    getter: (prefs) => prefs.filterUpdated ?? kDefaultFilterUpdated,
    setter: (prefs, value) => prefs.copyWith(filterUpdated: value),
  );
  // - Library -> Sort
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
  // - Library -> Display
  late final Preference<DisplayMode> displayMode = Preference<DisplayMode>(
    isar: _isar,
    defaultValue: kDefaultDisplayMode,
    getter: (prefs) => prefs.displayMode,
    setter: (prefs, value) => prefs.copyWith(displayMode: value),
  );
  // - More
  late final Preference<bool> downloadedOnlyMode = Preference<bool>(
    isar: _isar,
    defaultValue: kDefaultDownloadedOnlyMode,
    getter: (prefs) => prefs.downloadedOnlyMode ?? kDefaultDownloadedOnlyMode,
    setter: (prefs, value) => prefs.copyWith(downloadedOnlyMode: value),
  );
  late final Preference<bool> incognitoMode = Preference<bool>(
    isar: _isar,
    defaultValue: kDefaultIncognitoMode,
    getter: (prefs) => prefs.incognitoMode ?? kDefaultIncognitoMode,
    setter: (prefs, value) => prefs.copyWith(incognitoMode: value),
  );
  // - Settings -> Appearance
  late final Preference<ThemeMode> themeMode = Preference<ThemeMode>(
    isar: _isar,
    defaultValue: kDefaultThemeMode,
    getter: (prefs) => prefs.themeMode,
    setter: (prefs, value) => prefs.copyWith(themeMode: value),
  );

  late final Preference<String?> themeID = Preference<String?>(
    isar: _isar,
    defaultValue: kDefaultThemeID,
    getter: (prefs) => prefs.themeID,
    setter: (prefs, value) => prefs.copyWith(themeID: value),
  );

  late final Preference<double> contrastLevel = Preference<double>(
    isar: _isar,
    defaultValue: kDefaultContrastLevel,
    getter: (prefs) => prefs.contrastLevel ?? kDefaultContrastLevel,
    setter: (prefs, value) => prefs.copyWith(contrastLevel: value),
  );

  late final Preference<double> blendLevel = Preference<double>(
    isar: _isar,
    defaultValue: kDefaultBlendLevel,
    getter: (prefs) => prefs.blendLevel ?? kDefaultBlendLevel,
    setter: (prefs, value) => prefs.copyWith(blendLevel: value),
  );

  late final Preference<bool> einkMode = Preference<bool>(
    isar: _isar,
    defaultValue: kDefaultEinkMode,
    getter: (prefs) => prefs.einkMode ?? kDefaultEinkMode,
    setter: (prefs, value) => prefs.copyWith(einkMode: value),
  );

  late final Preference<bool> pureBlackMode = Preference<bool>(
    isar: _isar,
    defaultValue: kDefaultPureBlackMode,
    getter: (prefs) => prefs.pureBlackMode ?? kDefaultPureBlackMode,
    setter: (prefs, value) => prefs.copyWith(pureBlackMode: value),
  );

  // --- Utility Functions ---
  Map<String, String> compareTo(Preferences? other) {
    // If other is null, return empty map
    if (other == null) return {};
    // Initialize map to store differences
    final differences = <String, String>{};
    // Iterate through all preferences and compare values
    if (showCategoryTabs.value != other.showCategoryTabs) {
      differences['showCategoryTabs'] =
          'Changed from ${showCategoryTabs.value} to ${other.showCategoryTabs}';
    }
    if (showWorkCount.value != other.showWorkCount) {
      differences['showWorkCount'] =
          'Changed from ${showWorkCount.value} to ${other.showWorkCount}';
    }
    if (showContinueReadingButton.value != other.showContinueReadingButton) {
      differences['showContinueReadingButton'] =
          'Changed from ${showContinueReadingButton.value} to ${other.showContinueReadingButton}';
    }
    if (themeMode.value != other.themeMode) {
      differences['themeMode'] =
          'Changed from ${themeMode.value} to ${other.themeMode}';
    }
    if (themeID.value != other.themeID) {
      differences['themeID'] =
          'Changed from ${themeID.value} to ${other.themeID}';
    }
    if (contrastLevel.value != other.contrastLevel) {
      differences['contrastLevel'] =
          'Changed from ${contrastLevel.value} to ${other.contrastLevel}';
    }
    if (blendLevel.value != other.blendLevel) {
      differences['blendLevel'] =
          'Changed from ${blendLevel.value} to ${other.blendLevel}';
    }
    if (einkMode.value != other.einkMode) {
      differences['einkMode'] =
          'Changed from ${einkMode.value} to ${other.einkMode}';
    }
    if (pureBlackMode.value != other.pureBlackMode) {
      differences['pureBlackMode'] =
          'Changed from ${pureBlackMode.value} to ${other.pureBlackMode}';
    }
    // Return the map of differences
    return differences;
  }
}
