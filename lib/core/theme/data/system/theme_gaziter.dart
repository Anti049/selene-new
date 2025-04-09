import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:selene/core/theme/models/app_theme.dart';

final themeGaziter = AppTheme(
  id: 'gaziter',
  name: 'Gaziter',
  category: ThemeCategory.system,
  primary: Color(0xFF48F7BD),
  secondary: Color(0xFFC193FF),
  tertiary: Color(0xFF54A5B6),
  error: Color(0xFFFF5555),
  neutral: Color(0xFF04485F),
  variant: FlexSchemeVariant.vibrant,
  isPrebuilt: true,
  isEditable: false,
);
