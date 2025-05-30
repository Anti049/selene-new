import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

/// A utility class for converting [Color] to and from [String].
///
/// Used for both Drift and Freezed.
class ColorConverter extends JsonConverter<Color, String> {
  const ColorConverter();

  @override
  Color fromJson(String json) => json.toColor;

  @override
  String toJson(Color color) => color.hex;
}
