import 'package:isar/isar.dart';
import 'package:selene/core/constants/preference_constants.dart';
import 'package:selene/core/database/tables/preferences_table.dart';

class Preference<T> {
  final Isar _isar;
  final T defaultValue;
  final T Function(Preferences prefs) _getter;
  final Preferences Function(Preferences prefs, T value) _setter;

  Preference({
    required Isar isar,
    required this.defaultValue,
    required T Function(Preferences prefs) getter,
    required Preferences Function(Preferences prefs, T value) setter,
  }) : _isar = isar,
       _getter = getter,
       _setter = setter;

  // --- Read Operations ---
  Preferences get prefs =>
      _isar.preferences.getSync(kPreferencesID) ?? Preferences();
  T get() => _getter(prefs) ?? defaultValue;
  Stream<T> get stream => _isar.preferences
      .watchObject(kPreferencesID)
      .map((preferences) => _getter(preferences ?? prefs) ?? defaultValue);

  // --- Write Operations ---
  T set(T value) {
    final prefs = this.prefs;
    _isar.writeTxnSync(() {
      _isar.preferences.putSync(_setter(prefs, value));
    });
    return value;
  }

  void reset() {
    set(defaultValue);
  }
}

extension BoolExtensions on Preference<bool> {
  bool toggle() {
    return set(!get());
  }
}

extension EnumExtensions on Preference<Enum> {
  Enum cycle(List<Enum> values) {
    final currentIndex = values.indexOf(get());
    final nextIndex = (currentIndex + 1) % values.length;
    return set(values[nextIndex]);
  }
}
