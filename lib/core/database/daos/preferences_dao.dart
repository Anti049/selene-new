import 'package:drift/drift.dart';
import 'package:selene/core/database/database.dart';
import 'package:selene/core/database/tables/app_preferences_table.dart';

part 'preferences_dao.g.dart';

@DriftAccessor(tables: [AppPreferences])
class PreferencesDao extends DatabaseAccessor<AppDatabase>
    with _$PreferencesDaoMixin {
  PreferencesDao(super.db);

  // --- Read Operations ---

  /// Get a preference by its key.
  Future<String?> getPreference(String key) async {
    final row =
        await (select(appPreferences)
          ..where((tbl) => tbl.key.equals(key))).getSingleOrNull();
    return row?.value;
  }

  /// Watch a preference by its key.
  Stream<String?> watchPreference(String key) {
    return (select(appPreferences)..where(
      (tbl) => tbl.key.equals(key),
    )).watchSingleOrNull().map((row) => row?.value);
  }

  /// Get all preferences as a map (useful for migration).
  Future<Map<String, String>> getAllPreferences() async {
    final rows = await select(appPreferences).get();
    return {for (var row in rows) row.key: row.value};
  }

  // --- Write Operations ---

  /// Insert or update a preference based on its key.
  Future<void> upsertPreference(String key, String value) {
    final companion = AppPreferencesCompanion(
      key: Value(key),
      value: Value(value),
    );
    return into(appPreferences).insertOnConflictUpdate(companion);
  }

  /// Delete a preference by its key.
  Future<int> deletePreference(String key) {
    return (delete(appPreferences)..where((tbl) => tbl.key.equals(key))).go();
  }

  /// Delete all preferences.
  Future<int> deleteAllPreferences() {
    return delete(appPreferences).go();
  }
}
