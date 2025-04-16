// ignore_for_file: invalid_annotation_target
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:isar/isar.dart';
import 'package:selene/core/constants/preference_constants.dart';
import 'package:selene/core/utils/enums.dart';

part 'preferences_table.freezed.dart';
part 'preferences_table.g.dart';

@freezed
@Collection(ignore: {'copyWith'})
@Name('Preferences')
class Preferences with _$Preferences {
  Id get id => kPreferencesID;

  const Preferences._(); // Private constructor for freezed

  const factory Preferences({
    // Library -> General
    @Default(kDefaultShowCategoryTabs) bool? showCategoryTabs,
    @Default(kDefaultShowWorkCount) bool? showWorkCount,
    @Default(kDefaultShowContinueReadingButton) bool? showContinueReadingButton,
    @Default(kDefaultShowDownloadedCount) bool? showDownloadedCount,
    @Default(kDefaultShowUnreadCount) bool? showUnreadCount,
    @Default(kDefaultShowFavorite) bool? showFavorite,
    // Library -> Filters
    @enumerated @Default(kDefaultFilterDownloaded) TriState filterDownloaded,
    @enumerated @Default(kDefaultFilterUnread) TriState filterUnread,
    @enumerated @Default(kDefaultFilterFavorites) TriState filterFavorites,
    @enumerated @Default(kDefaultFilterStarted) TriState filterStarted,
    @enumerated @Default(kDefaultFilterCompleted) TriState filterCompleted,
    @enumerated @Default(kDefaultFilterUpdated) TriState filterUpdated,
    // Library -> Sort
    @enumerated @Default(kDefaultSortBy) SortBy sortBy,
    @enumerated @Default(kDefaultSortOrder) SortOrder sortOrder,
    // Library -> Display
    @enumerated @Default(kDefaultDisplayMode) DisplayMode displayMode,
    @Default(kDefaultGridSize) double? gridSize,
    // Library -> Tags
    @Default(kDefaultShowPublishedDate) bool? showPublishedDate,
    @Default(kDefaultShowCharacterTags) bool? showCharacterTags,
    @Default(kDefaultShowFriendshipTags) bool? showFriendshipTags,
    @Default(kDefaultShowRomanceTags) bool? showRomanceTags,
    @Default(kDefaultShowFreeformTags) bool? showFreeformTags,
    @Default(kDefaultShowDescription) bool? showDescription,
    // More
    @Default(kDefaultDownloadedOnlyMode) bool? downloadedOnlyMode,
    @Default(kDefaultIncognitoMode) bool? incognitoMode,
    // Settings -> Appearance
    @enumerated @Default(kDefaultThemeMode) ThemeMode themeMode,
    @Default(kDefaultThemeID) String? themeID,
    @Default(kDefaultContrastLevel) double? contrastLevel,
    @Default(kDefaultBlendLevel) double? blendLevel,
    @Default(kDefaultEinkMode) bool? einkMode,
    @Default(kDefaultPureBlackMode) bool? pureBlackMode,
  }) = _Preferences;

  factory Preferences.fromJson(Map<String, Object?> json) =>
      _$PreferencesFromJson(json);
}

// @collection
// @Name('Preferences')
// class Preferences {
//   Id? id;

//   // Library
//   bool? showCategoryTabs;
//   bool? showWorkCount;
//   bool? showContinueReadingButton;
//   bool? showDownloadedCount;
//   bool? showUnreadCount;
//   bool? showFavorite;
//   // Library -> Filters
//   @enumerated
//   late TriState filterDownloaded;
//   @enumerated
//   late TriState filterUnread;
//   @enumerated
//   late TriState filterFavorites;
//   @enumerated
//   late TriState filterStarted;
//   @enumerated
//   late TriState filterCompleted;
//   @enumerated
//   late TriState filterUpdated;
//   // Library -> Sort
//   @enumerated
//   late SortBy sortBy;
//   @enumerated
//   late SortOrder sortOrder;
//   // Library -> Display
//   @enumerated
//   late DisplayMode displayMode;
//   double? gridSize;
//   // Library -> Tags
//   bool? showPublishedDate;
//   bool? showCharacterTags;
//   bool? showFriendshipTags;
//   bool? showRomanceTags;
//   bool? showFreeformTags;
//   bool? showDescription;
//   // More
//   bool? downloadedOnlyMode;
//   bool? incognitoMode;
//   // Settings -> Appearance
//   @enumerated
//   late ThemeMode themeMode;
//   String? themeID;
//   double? contrastLevel;
//   double? blendLevel;
//   bool? einkMode;
//   bool? pureBlackMode;

//   // Constructor
//   Preferences({
//     // Library
//     this.showCategoryTabs = kDefaultShowCategoryTabs,
//     this.showWorkCount = kDefaultShowWorkCount,
//     this.showContinueReadingButton = kDefaultShowContinueReadingButton,
//     this.showDownloadedCount = kDefaultShowDownloadedCount,
//     this.showUnreadCount = kDefaultShowUnreadCount,
//     this.showFavorite = kDefaultShowFavorite,
//     // Library -> Filters
//     this.filterDownloaded = kDefaultFilterDownloaded,
//     this.filterUnread = kDefaultFilterUnread,
//     this.filterFavorites = kDefaultFilterFavorites,
//     this.filterStarted = kDefaultFilterStarted,
//     this.filterCompleted = kDefaultFilterCompleted,
//     this.filterUpdated = kDefaultFilterUpdated,
//     // Library -> Sort
//     this.sortBy = kDefaultSortBy,
//     this.sortOrder = kDefaultSortOrder,
//     // Library -> Display
//     this.displayMode = kDefaultDisplayMode,
//     this.gridSize = kDefaultGridSize,
//     // Library -> Tags
//     this.showPublishedDate = kDefaultShowPublishedDate,
//     this.showCharacterTags = kDefaultShowCharacterTags,
//     this.showFriendshipTags = kDefaultShowFriendshipTags,
//     this.showRomanceTags = kDefaultShowRomanceTags,
//     this.showFreeformTags = kDefaultShowFreeformTags,
//     this.showDescription = kDefaultShowDescription,
//     // More
//     this.downloadedOnlyMode = kDefaultDownloadedOnlyMode,
//     this.incognitoMode = kDefaultIncognitoMode,
//     // Settings -> Appearance
//     this.themeMode = kDefaultThemeMode,
//     this.themeID = kDefaultThemeID,
//     this.contrastLevel = kDefaultContrastLevel,
//     this.blendLevel = kDefaultBlendLevel,
//     this.einkMode = kDefaultEinkMode,
//     this.pureBlackMode = kDefaultPureBlackMode,
//   }) : id = kPreferencesID;

//   // CopyWith
//   Preferences copyWith({
//     // Library
//     bool? showCategoryTabs,
//     bool? showWorkCount,
//     bool? showContinueReadingButton,
//     bool? showDownloadedCount,
//     bool? showUnreadCount,
//     bool? showFavorite,
//     // Library -> Filters
//     TriState? filterDownloaded,
//     TriState? filterUnread,
//     TriState? filterFavorites,
//     TriState? filterStarted,
//     TriState? filterCompleted,
//     TriState? filterUpdated,
//     // Library -> Sort
//     SortBy? sortBy,
//     SortOrder? sortOrder,
//     // Library -> Display
//     DisplayMode? displayMode,
//     double? gridSize,
//     // Library -> Tags
//     bool? showPublishedDate,
//     bool? showCharacterTags,
//     bool? showFriendshipTags,
//     bool? showRomanceTags,
//     bool? showFreeformTags,
//     bool? showDescription,
//     // More
//     bool? downloadedOnlyMode,
//     bool? incognitoMode,
//     // Settings -> Appearance
//     ThemeMode? themeMode,
//     String? themeID,
//     double? contrastLevel,
//     double? blendLevel,
//     bool? einkMode,
//     bool? pureBlackMode,
//   }) {
//     return Preferences(
//       // Library
//       showCategoryTabs: showCategoryTabs ?? this.showCategoryTabs,
//       showWorkCount: showWorkCount ?? this.showWorkCount,
//       showContinueReadingButton:
//           showContinueReadingButton ?? this.showContinueReadingButton,
//       showDownloadedCount: showDownloadedCount ?? this.showDownloadedCount,
//       showUnreadCount: showUnreadCount ?? this.showUnreadCount,
//       showFavorite: showFavorite ?? this.showFavorite,
//       // Library -> Filters
//       filterDownloaded: filterDownloaded ?? this.filterDownloaded,
//       filterUnread: filterUnread ?? this.filterUnread,
//       filterFavorites: filterFavorites ?? this.filterFavorites,
//       filterStarted: filterStarted ?? this.filterStarted,
//       filterCompleted: filterCompleted ?? this.filterCompleted,
//       filterUpdated: filterUpdated ?? this.filterUpdated,
//       // Library -> Sort
//       sortBy: sortBy ?? this.sortBy,
//       sortOrder: sortOrder ?? this.sortOrder,
//       // Library -> Display
//       displayMode: displayMode ?? this.displayMode,
//       gridSize: gridSize ?? this.gridSize,
//       // Library -> Tags
//       showPublishedDate: showPublishedDate ?? this.showPublishedDate,
//       showCharacterTags: showCharacterTags ?? this.showCharacterTags,
//       showFriendshipTags: showFriendshipTags ?? this.showFriendshipTags,
//       showRomanceTags: showRomanceTags ?? this.showRomanceTags,
//       showFreeformTags: showFreeformTags ?? this.showFreeformTags,
//       showDescription: showDescription ?? this.showDescription,
//       // More
//       downloadedOnlyMode: downloadedOnlyMode ?? this.downloadedOnlyMode,
//       incognitoMode: incognitoMode ?? this.incognitoMode,
//       // Settings -> Appearance
//       themeMode: themeMode ?? this.themeMode,
//       themeID: themeID ?? this.themeID,
//       contrastLevel: contrastLevel ?? this.contrastLevel,
//       blendLevel: blendLevel ?? this.blendLevel,
//       einkMode: einkMode ?? this.einkMode,
//       pureBlackMode: pureBlackMode ?? this.pureBlackMode,
//     );
//   }
// }
