import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:selene/core/constants/preference_constants.dart';
import 'package:selene/core/database/models/preference.dart';
import 'package:selene/core/database/tables/preferences_table.dart';

class PreferenceService {
  final Isar _isar;

  PreferenceService(this._isar);

  // --- Preference Accessors ---
  late final Preference<ThemeMode> themeMode = Preference<ThemeMode>(
    isar: _isar,
    defaultValue: ThemeMode.system,
    getter: (prefs) => prefs.themeMode,
    setter: (prefs, value) => prefs.copyWith(themeMode: value),
  );

  late final Preference<String?> themeID = Preference<String?>(
    isar: _isar,
    defaultValue: null,
    getter: (prefs) => prefs.themeID,
    setter: (prefs, value) => prefs.copyWith(themeID: value),
  );

  late final Preference<double> contrastLevel = Preference<double>(
    isar: _isar,
    defaultValue: 0.0,
    getter: (prefs) => prefs.contrastLevel ?? kDefaultContrastLevel,
    setter: (prefs, value) => prefs.copyWith(contrastLevel: value),
  );

  late final Preference<double> blendLevel = Preference<double>(
    isar: _isar,
    defaultValue: 6.0,
    getter: (prefs) => prefs.blendLevel ?? kDefaultBlendLevel,
    setter: (prefs, value) => prefs.copyWith(blendLevel: value),
  );

  late final Preference<bool> einkMode = Preference<bool>(
    isar: _isar,
    defaultValue: false,
    getter: (prefs) => prefs.einkMode ?? kDefaultEinkMode,
    setter: (prefs, value) => prefs.copyWith(einkMode: value),
  );

  late final Preference<bool> pureBlackMode = Preference<bool>(
    isar: _isar,
    defaultValue: false,
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
