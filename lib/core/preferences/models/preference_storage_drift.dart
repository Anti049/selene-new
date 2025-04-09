import 'package:selene/core/database/daos/preferences_dao.dart';
import 'package:selene/core/preferences/models/preference_storage.dart';

class DriftPreferenceSotrage implements PreferenceStorage {
  final PreferencesDao _preferencesDao;

  DriftPreferenceSotrage(this._preferencesDao);

  // --- Read Operations ---
  @override
  Future<String?> read(String key) {
    return _preferencesDao.getPreference(key);
  }

  @override
  Stream<String?> watch(String key) {
    return _preferencesDao.watchPreference(key);
  }

  // --- Write Operations ---
  @override
  Future<void> write(String key, String newValue) {
    return _preferencesDao.upsertPreference(key, newValue);
  }

  @override
  Future<void> delete(String key) {
    return _preferencesDao.deletePreference(key);
  }

  @override
  Future<void> reset() {
    return _preferencesDao.deleteAllPreferences();
  }
}
