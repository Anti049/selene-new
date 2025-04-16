import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
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
    setter:
        (prefs, value) =>
            prefs.copyWith(themeMode: value), // Setter logic remains similar
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
  return [
    SearchableSettingItem.group(
      label: 'Theme',
      children: [
        SearchableSettingItem(
          label: 'Theme Mode',
          type: SettingType.segmentedSetting,
          preference: ref.watch(appearancePreferencesProvider).themeMode,
          options: ThemeMode.values,
          route: '/settings/appearance?section=theme',
          breadcrumbs: ['Appearance', 'Theme'],
          keywords: ['theme', 'mode'],
        ),
      ],
    ),
  ];
}
