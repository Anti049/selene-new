import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:selene/core/database/models/preference.dart';
import 'package:selene/core/database/providers/preference_service_provider.dart';
import 'package:selene/core/database/services/preference_service.dart';
import 'package:selene/features/settings/models/searchable_setting_item.dart';

part 'appearance_preferences.g.dart';

class AppearancePreferences {
  final PreferenceService _preferenceService;

  AppearancePreferences(this._preferenceService);

  Preference<ThemeMode> get themeMode => _preferenceService.themeMode;
  Preference<String?> get themeID => _preferenceService.themeID;
  Preference<double> get contrastLevel => _preferenceService.contrastLevel;
  Preference<double> get blendLevel => _preferenceService.blendLevel;
  Preference<bool> get einkMode => _preferenceService.einkMode;
  Preference<bool> get pureBlackMode => _preferenceService.pureBlackMode;
}

@riverpod
AppearancePreferences appearancePreferences(Ref ref) {
  ref.watch(preferencesStreamProvider);
  return AppearancePreferences(ref.watch(preferenceServiceProvider));
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
