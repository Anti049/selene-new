import 'package:change_case/change_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:selene/core/constants/preference_constants.dart';
import 'package:selene/core/database/models/preference.dart';
import 'package:selene/core/database/providers/isar_provider.dart';
import 'package:selene/core/database/providers/preferences_stream_provider.dart';
import 'package:selene/features/settings/models/searchable_setting_item.dart';

part 'appearance_preferences.g.dart';

class AppearancePreferences {
  final Isar _isar; // Store Isar instance

  AppearancePreferences(this._isar); // Constructor takes Isar

  // Instantiate Preference<T> directly here
  late final Preference<ThemeMode> themeMode = Preference<ThemeMode>(
    isar: _isar, // Pass Isar instance
    defaultValue: kDefaultThemeMode,
    getter: (prefs) => prefs.themeMode, // Getter logic remains similar
    setter: (prefs, value) => prefs.copyWith(themeMode: value), // Setter logic remains similar
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
    getter: (prefs) => prefs.contrastLevel,
    setter: (prefs, value) => prefs.copyWith(contrastLevel: value),
  );

  late final Preference<double> blendLevel = Preference<double>(
    isar: _isar,
    defaultValue: kDefaultBlendLevel,
    getter: (prefs) => prefs.blendLevel,
    setter: (prefs, value) => prefs.copyWith(blendLevel: value),
  );

  late final Preference<bool> einkMode = Preference<bool>(
    isar: _isar,
    defaultValue: kDefaultEinkMode,
    getter: (prefs) => prefs.einkMode,
    setter: (prefs, value) => prefs.copyWith(einkMode: value),
  );

  late final Preference<bool> pureBlackMode = Preference<bool>(
    isar: _isar,
    defaultValue: kDefaultPureBlackMode,
    getter: (prefs) => prefs.pureBlackMode,
    setter: (prefs, value) => prefs.copyWith(pureBlackMode: value),
  );
}

@riverpod
AppearancePreferences appearancePreferences(Ref ref) {
  // Get Isar instance directly when available
  final isar = ref.watch(isarProvider).requireValue;
  // Watch the overall preferences stream to trigger rebuilds if any pref changes
  ref.watch(preferencesStreamProvider);
  // Pass the Isar instance to the class constructor
  return AppearancePreferences(isar);
}

@riverpod
List<SearchableSettingItem> appearanceSettings(Ref ref) {
  final route = '/settings/appearance';
  final appearancePrefs = ref.watch(appearancePreferencesProvider);
  return [
    SearchableSettingItem.group(
      label: 'Theme',
      children: [
        SearchableSettingItem(
          label: 'Theme Mode',
          type: SettingType.segmentedSetting,
          preference: appearancePrefs.themeMode,
          options: ThemeMode.values,
          route: route,
          breadcrumbs: ['Appearance', 'Theme'],
          keywords: ['theme', 'mode'],
        ),
        SearchableSettingItem(
          label: 'Theme Selection',
          subtitle: appearancePrefs.themeID.get()?.toTitleCase() ?? 'System',
          type: SettingType.linkSetting,
          icon: Symbols.palette,
          route: '$route/theme-selection',
          breadcrumbs: ['Appearance', 'Theme'],
          keywords: ['theme', 'selection'],
        ),
        SearchableSettingItem(
          label: 'Contrast Level',
          type: SettingType.sliderSetting,
          preference: appearancePrefs.contrastLevel,
          min: -1.0,
          max: 1.0,
          divisions: 4,
          route: route,
          breadcrumbs: ['Appearance', 'Theme'],
          keywords: ['contrast', 'level'],
          enabled: !appearancePrefs.einkMode.get(),
        ),
        SearchableSettingItem(
          label: 'E-Ink Mode',
          subtitle: 'Use eink mode for better readability',
          icon: Symbols.filter_b_and_w,
          type: SettingType.switchSetting,
          preference: appearancePrefs.einkMode,
          route: route,
          breadcrumbs: ['Appearance', 'Theme'],
          keywords: ['eink', 'mode'],
        ),
        SearchableSettingItem(
          label: 'Pure Black Mode',
          subtitle: 'Use pure black background for dark mode',
          icon: Symbols.contrast,
          type: SettingType.switchSetting,
          preference: appearancePrefs.pureBlackMode,
          route: route,
          breadcrumbs: ['Appearance', 'Theme'],
          keywords: ['pure', 'black', 'mode'],
          enabled:
              !appearancePrefs.einkMode.get() && appearancePrefs.themeMode.get() != ThemeMode.light,
        ),
      ],
    ),
  ];
}
