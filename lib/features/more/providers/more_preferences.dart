import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:selene/core/constants/preference_constants.dart';
import 'package:selene/core/database/models/preference.dart';
import 'package:selene/core/database/providers/isar_provider.dart';
import 'package:selene/core/database/providers/preferences_stream_provider.dart';

part 'more_preferences.g.dart';

class MorePreferences {
  final Isar _isar; // Store Isar instance

  MorePreferences(this._isar); // Constructor takes Isar

  // Instantiate Preference<T> directly here

  late final Preference<bool> downloadedOnlyMode = Preference<bool>(
    isar: _isar, // Pass Isar instance
    defaultValue:
        kDefaultDownloadedOnlyMode, // Default value for downloadedOnlyMode
    getter: (prefs) => prefs.downloadedOnlyMode ?? false, // Getter logic
    setter:
        (prefs, value) =>
            prefs.copyWith(downloadedOnlyMode: value), // Setter logic
  );
  late final Preference<bool> incognitoMode = Preference<bool>(
    isar: _isar,
    defaultValue: kDefaultIncognitoMode, // Default value for incognitoMode
    getter: (prefs) => prefs.incognitoMode ?? false, // Getter logic
    setter:
        (prefs, value) => prefs.copyWith(incognitoMode: value), // Setter logic
  );
}

@riverpod
MorePreferences morePreferences(Ref ref) {
  // Get Isar instance directly when available
  final isar = ref.watch(isarProvider).requireValue;
  // Watch the overall preferences stream to trigger rebuilds if any pref changes
  ref.watch(preferencesStreamProvider);
  // Pass the Isar instance to the class constructor
  return MorePreferences(isar);
}
