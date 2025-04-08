import 'package:drift/drift.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

/// A utility class for converting [Color] to and from [String].
///
/// Used for both Drift and Freezed.
class ColorConverter extends JsonConverter<Color, String>
    implements TypeConverter<Color, String> {
  const ColorConverter();

  @override
  Color fromJson(String json) => json.toColor;

  @override
  String toJson(Color color) => color.hex;

  @override
  Color fromSql(String fromDb) => fromDb.toColor;

  @override
  String toSql(Color value) => value.hex;
}

class ColorStringConverter extends TypeConverter<Color, String> {
  const ColorStringConverter();

  @override
  Color fromSql(String fromDb) => fromDb.toColor;

  @override
  String toSql(Color value) => value.hex;
}
