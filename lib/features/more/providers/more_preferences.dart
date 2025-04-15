import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:selene/core/database/models/preference.dart';
import 'package:selene/core/database/providers/preference_service_provider.dart';
import 'package:selene/core/database/services/preference_service.dart';

part 'more_preferences.g.dart';

class MorePreferences {
  final PreferenceService _preferenceService;

  MorePreferences(this._preferenceService);

  Preference<bool> get downloadedOnlyMode =>
      _preferenceService.downloadedOnlyMode;
  Preference<bool> get incognitoMode => _preferenceService.incognitoMode;
}

@riverpod
MorePreferences morePreferences(Ref ref) {
  ref.watch(preferencesStreamProvider);
  return MorePreferences(ref.watch(preferenceServiceProvider));
}
