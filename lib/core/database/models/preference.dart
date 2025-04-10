import 'package:isar/isar.dart';
import 'package:selene/core/constants/preference_constants.dart';
import 'package:selene/core/database/tables/preferences_table.dart';

class Preference<T> {
  final Isar _isar;
  final T _defaultValue;
  final T Function(Preferences prefs) _getter;
  final Preferences Function(Preferences prefs, T value) _setter;

  Preference({
    required Isar isar,
    required T defaultValue,
    required T Function(Preferences prefs) getter,
    required Preferences Function(Preferences prefs, T value) setter,
  }) : _isar = isar,
       _defaultValue = defaultValue,
       _getter = getter,
       _setter = setter;

  // --- Read Operations ---
  Preferences get prefs =>
      _isar.preferences.getSync(kPreferencesID) ?? Preferences();
  T get value => _getter(prefs) ?? _defaultValue;
  Stream<T> get stream => _isar.preferences
      .watchObject(kPreferencesID)
      .map((preferences) => _getter(preferences ?? prefs) ?? _defaultValue);

  // --- Write Operations ---
  void setValue(T value) {
    final prefs = this.prefs;
    _isar.writeTxnSync(() {
      _isar.preferences.putSync(_setter(prefs, value));
    });
  }
}

extension EnumExtensions on Preference<Enum> {
  Enum cycle(List<Enum> values) {
    final currentIndex = values.indexOf(value);
    final nextIndex = (currentIndex + 1) % values.length;
    setValue(values[nextIndex]);
    return values[nextIndex];
  }
}
