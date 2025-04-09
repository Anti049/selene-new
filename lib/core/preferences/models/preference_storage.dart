abstract class PreferenceStorage {
  // --- Read Operations ---
  Future<String?> read(String key);
  Stream<String?> watch(String key);
  // --- Write Operations ---
  Future<void> write(String key, String newValue);
  Future<void> delete(String key);
  Future<void> reset();
}
