import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:selene/core/theme/models/app_theme.dart';

final themeMonochrome = AppTheme(
  id: 'monochrome',
  name: 'Monochrome',
  category: ThemeCategory.system,
  primary: Color(0xFFFFFFFF),
  variant: FlexSchemeVariant.monochrome,
  isPrebuilt: true,
  isEditable: false,
);
