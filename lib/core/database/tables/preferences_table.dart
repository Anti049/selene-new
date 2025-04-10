import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:selene/core/constants/preference_constants.dart';

part 'preferences_table.g.dart';

@collection
@Name('Preferences')
class Preferences {
  Id? id;

  // Appearance
  @enumerated
  late ThemeMode themeMode;
  String? themeID;
  double? contrastLevel;
  double? blendLevel;
  bool? einkMode;
  bool? pureBlackMode;

  // Constructor
  Preferences({
    this.themeMode = kDefaultThemeMode,
    this.themeID = kDefaultThemeID,
    this.contrastLevel = kDefaultContrastLevel,
    this.blendLevel = kDefaultBlendLevel,
    this.einkMode = kDefaultEinkMode,
    this.pureBlackMode = kDefaultPureBlackMode,
  }) : id = kPreferencesID;

  // CopyWith
  Preferences copyWith({
    ThemeMode? themeMode,
    String? themeID,
    double? contrastLevel,
    double? blendLevel,
    bool? einkMode,
    bool? pureBlackMode,
  }) {
    return Preferences(
      themeMode: themeMode ?? this.themeMode,
      themeID: themeID ?? this.themeID,
      contrastLevel: contrastLevel ?? this.contrastLevel,
      blendLevel: blendLevel ?? this.blendLevel,
      einkMode: einkMode ?? this.einkMode,
      pureBlackMode: pureBlackMode ?? this.pureBlackMode,
    );
  }
}
