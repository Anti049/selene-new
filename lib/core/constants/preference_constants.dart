// Preferences ID
import 'package:flutter/material.dart';
import 'package:selene/core/utils/enums.dart';

const kPreferencesID = 227;

// Default values for preferences
// - Library
const kDefaultShowCategoryTabs = false;
const kDefaultShowWorkCount = false;
const kDefaultShowContinueReadingButton = true;
const kDefaultShowDownloadedCount = false;
const kDefaultShowUnreadCount = false;
const kDefaultShowFavorite = false;
// - Library -> Filters
const kDefaultFilterDownloaded = false;
const kDefaultFilterUnread = false;
const kDefaultFilterFavorites = false;
const kDefaultFilterStarted = false;
const kDefaultFilterCompleted = false;
const kDefaultFilterUpdated = false;
// - Library -> Sort
const kDefaultSortBy = SortBy.alphabetically;
const kDefaultSortOrder = SortOrder.ascending;
// - Library -> Display
const kDefaultDisplayMode = DisplayMode.widgetList;
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
