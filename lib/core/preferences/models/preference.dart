import 'dart:async';
import 'package:meta/meta.dart';
import 'package:selene/core/preferences/models/preference_storage.dart'; // For @internal

// Define Serializer/Deserializer function types
typedef PreferenceSerializer<T> = String Function(T value);
typedef PreferenceDeserializer<T> = T Function(String rawValue);

class Preference<T> {
  final String key;
  final T defaultValue;
  final PreferenceStorage _storage;
  final PreferenceSerializer<T> _serializer;
  final PreferenceDeserializer<T> _deserializer;

  /// Internal constructor. Use PreferencesRepository to get instances
  @internal
  Preference({
    required this.key,
    required this.defaultValue,
    required PreferenceStorage storage,
    required PreferenceSerializer<T> serializer,
    required PreferenceDeserializer<T> deserializer,
  }) : _storage = storage,
       _serializer = serializer,
       _deserializer = deserializer;
}
