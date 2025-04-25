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
    // Settings -> Library
    // Settings -> Accounts
    // Settings -> Reader
    // Settings -> Downloads
    @Default(kDefaultDownloadDelaySeconds) int? downloadDelaySeconds,
    // Settings -> Tracking
    // Settings -> Browse
    // Settings -> Notifications
    // Settings -> Data & Storage
    @Default(kDefaultLibraryFolder) String libraryFolder,
    @Default(kDefaultImportFolders) List<String> importFolders,
    // Settings -> Security & Privacy
    // Settings -> Advanced
  }) = _Preferences;

  factory Preferences.fromJson(Map<String, Object?> json) =>
      _$PreferencesFromJson(json);
}
