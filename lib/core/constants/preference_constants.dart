// Preferences ID
import 'package:flutter/material.dart';
import 'package:selene/core/utils/enums.dart';

const kPreferencesID = 227;

// Default values for preferences
// - Library -> General
const kDefaultShowCategoryTabs = false;
const kDefaultShowWorkCount = false;
const kDefaultShowContinueReadingButton = true;
const kDefaultShowDownloadedCount = false;
const kDefaultShowUnreadCount = false;
const kDefaultShowFavorite = false;
// - Library -> Filters
const kDefaultFilterDownloaded = TriState.disabled;
const kDefaultFilterUnread = TriState.disabled;
const kDefaultFilterFavorites = TriState.disabled;
const kDefaultFilterStarted = TriState.disabled;
const kDefaultFilterCompleted = TriState.disabled;
const kDefaultFilterUpdated = TriState.disabled;
// - Library -> Sort
const kDefaultSortBy = SortBy.alphabetically;
const kDefaultSortOrder = SortOrder.ascending;
// - Library -> Display
const kDefaultDisplayMode = DisplayMode.widgetList;
const kDefaultGridSize = 0.0;
// - Library -> Tags
const kDefaultShowPublishedDate = true;
const kDefaultShowCharacterTags = true;
const kDefaultShowFriendshipTags = true;
const kDefaultShowRomanceTags = true;
const kDefaultShowFreeformTags = true;
const kDefaultShowDescription = true;
// - More
const kDefaultDownloadedOnlyMode = false;
const kDefaultIncognitoMode = false;
// - Settings -> Appearance
const kDefaultThemeMode = ThemeMode.system;
const kDefaultThemeID = 'system';
const kDefaultContrastLevel = 0.0;
const kDefaultBlendLevel = 6.0;
const kDefaultEinkMode = false;
const kDefaultPureBlackMode = false;
// - Settings -> Library
// - Settings -> Accounts
// - Settings -> Reader
// - Settings -> Downloads
// - Settings -> Tracking
// - Settings -> Browse
// - Settings -> Notifications
// - Settings -> Data & Storage
const kDefaultLibraryFolder = '';
const kDefaultImportFolders = <String>[];
// - Settings -> Security & Privacy
// - Settings -> Advanced
