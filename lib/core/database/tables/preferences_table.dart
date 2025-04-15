import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:selene/core/constants/preference_constants.dart';
import 'package:selene/core/utils/enums.dart';

part 'preferences_table.g.dart';

@collection
@Name('Preferences')
class Preferences {
  Id? id;

  // Library
  bool? showCategoryTabs;
  bool? showWorkCount;
  bool? showContinueReadingButton;
  bool? showDownloadedCount;
  bool? showUnreadCount;
  bool? showFavorite;
  // Library -> Filters
  bool? filterDownloaded;
  bool? filterUnread;
  bool? filterFavorites;
  bool? filterStarted;
  bool? filterCompleted;
  bool? filterUpdated;
  // Library -> Sort
  @enumerated
  late SortBy sortBy;
  @enumerated
  late SortOrder sortOrder;
  // Library -> Display
  @enumerated
  late DisplayMode displayMode;
  // More
  bool? downloadedOnlyMode;
  bool? incognitoMode;
  // Settings -> Appearance
  @enumerated
  late ThemeMode themeMode;
  String? themeID;
  double? contrastLevel;
  double? blendLevel;
  bool? einkMode;
  bool? pureBlackMode;

  // Constructor
  Preferences({
    // Library
    this.showCategoryTabs = kDefaultShowCategoryTabs,
    this.showWorkCount = kDefaultShowWorkCount,
    this.showContinueReadingButton = kDefaultShowContinueReadingButton,
    this.showDownloadedCount = kDefaultShowDownloadedCount,
    this.showUnreadCount = kDefaultShowUnreadCount,
    this.showFavorite = kDefaultShowFavorite,
    // Library -> Filters
    this.filterDownloaded = kDefaultFilterDownloaded,
    this.filterUnread = kDefaultFilterUnread,
    this.filterFavorites = kDefaultFilterFavorites,
    this.filterStarted = kDefaultFilterStarted,
    this.filterCompleted = kDefaultFilterCompleted,
    this.filterUpdated = kDefaultFilterUpdated,
    // Library -> Sort
    this.sortBy = kDefaultSortBy,
    this.sortOrder = kDefaultSortOrder,
    // Library -> Display
    this.displayMode = kDefaultDisplayMode,
    // More
    this.downloadedOnlyMode = kDefaultDownloadedOnlyMode,
    this.incognitoMode = kDefaultIncognitoMode,
    // Settings -> Appearance
    this.themeMode = kDefaultThemeMode,
    this.themeID = kDefaultThemeID,
    this.contrastLevel = kDefaultContrastLevel,
    this.blendLevel = kDefaultBlendLevel,
    this.einkMode = kDefaultEinkMode,
    this.pureBlackMode = kDefaultPureBlackMode,
  }) : id = kPreferencesID;

  // CopyWith
  Preferences copyWith({
    // Library
    bool? showCategoryTabs,
    bool? showWorkCount,
    bool? showContinueReadingButton,
    bool? showDownloadedCount,
    bool? showUnreadCount,
    bool? showFavorite,
    // Library -> Filters
    bool? filterDownloaded,
    bool? filterUnread,
    bool? filterFavorites,
    bool? filterStarted,
    bool? filterCompleted,
    bool? filterUpdated,
    // Library -> Sort
    SortBy? sortBy,
    SortOrder? sortOrder,
    // Library -> Display
    DisplayMode? displayMode,
    // More
    bool? downloadedOnlyMode,
    bool? incognitoMode,
    // Settings -> Appearance
    ThemeMode? themeMode,
    String? themeID,
    double? contrastLevel,
    double? blendLevel,
    bool? einkMode,
    bool? pureBlackMode,
  }) {
    return Preferences(
      // Library
      showCategoryTabs: showCategoryTabs ?? this.showCategoryTabs,
      showWorkCount: showWorkCount ?? this.showWorkCount,
      showContinueReadingButton:
          showContinueReadingButton ?? this.showContinueReadingButton,
      showDownloadedCount: showDownloadedCount ?? this.showDownloadedCount,
      showUnreadCount: showUnreadCount ?? this.showUnreadCount,
      showFavorite: showFavorite ?? this.showFavorite,
      // Library -> Filters
      filterDownloaded: filterDownloaded ?? this.filterDownloaded,
      filterUnread: filterUnread ?? this.filterUnread,
      filterFavorites: filterFavorites ?? this.filterFavorites,
      filterStarted: filterStarted ?? this.filterStarted,
      filterCompleted: filterCompleted ?? this.filterCompleted,
      filterUpdated: filterUpdated ?? this.filterUpdated,
      // Library -> Sort
      sortBy: sortBy ?? this.sortBy,
      sortOrder: sortOrder ?? this.sortOrder,
      // Library -> Display
      displayMode: displayMode ?? this.displayMode,
      // More
      downloadedOnlyMode: downloadedOnlyMode ?? this.downloadedOnlyMode,
      incognitoMode: incognitoMode ?? this.incognitoMode,
      // Settings -> Appearance
      themeMode: themeMode ?? this.themeMode,
      themeID: themeID ?? this.themeID,
      contrastLevel: contrastLevel ?? this.contrastLevel,
      blendLevel: blendLevel ?? this.blendLevel,
      einkMode: einkMode ?? this.einkMode,
      pureBlackMode: pureBlackMode ?? this.pureBlackMode,
    );
  }
}
