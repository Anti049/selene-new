import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:selene/core/database/models/preference.dart';
import 'package:selene/core/database/providers/isar_provider.dart';
import 'package:selene/core/database/providers/preferences_stream_provider.dart';
import 'package:selene/core/constants/preference_constants.dart'; // Import constants

part 'download_preferences.g.dart';

class DownloadPreferences {
  final Isar _isar;
  DownloadPreferences(this._isar);

  late final Preference<int> downloadDelaySeconds = Preference<int>(
    isar: _isar,
    defaultValue: kDefaultDownloadDelaySeconds,
    getter:
        (prefs) => prefs.downloadDelaySeconds ?? kDefaultDownloadDelaySeconds,
    setter: (prefs, value) => prefs.copyWith(downloadDelaySeconds: value),
  );
  // Add other download-related preferences here
}

@riverpod
DownloadPreferences downloadPreferences(Ref ref) {
  final isar = ref.watch(isarProvider).requireValue;
  ref.watch(preferencesStreamProvider); // Depend on the stream
  return DownloadPreferences(isar);
}
