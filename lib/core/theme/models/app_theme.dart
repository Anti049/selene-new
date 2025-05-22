import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart' hide Theme;
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:selene/core/constants/animation_constants.dart';
import 'package:selene/core/database/tables/app_themes_table.dart';
import 'package:selene/core/utils/converters.dart';

part 'app_theme.freezed.dart';
part 'app_theme.g.dart';

enum ThemeCategory {
  system('System'),
  site('Sites'),
  tachiyomi('Tachiyomi'),
  flex('Flex Color Schemes'),
  hsr('Honkai: Star Rail'),
  custom('Custom');

  const ThemeCategory(this.name);

  final String name;
}

@freezed
abstract class AppTheme with _$AppTheme {
  const AppTheme._();

  const factory AppTheme({
    required String id,
    required String name,
    @Default(ThemeCategory.custom) ThemeCategory category,
    @ColorConverter() required Color primary,
    @ColorConverter() Color? secondary,
    @ColorConverter() Color? tertiary,
    @ColorConverter() Color? error,
    @ColorConverter() Color? neutral,
    @ColorConverter() Color? neutralVariant,
    @Default(FlexSchemeVariant.tonalSpot) FlexSchemeVariant variant,
    @Default(false) bool isPrebuilt,
    @Default(true) bool isEditable,
  }) = _AppTheme;

  factory AppTheme.fromJson(Map<String, dynamic> json) =>
      _$AppThemeFromJson(json);

  IsarTheme toIsar() {
    return IsarTheme()
      ..id = id
      ..name = name
      ..category = category
      ..primary = primary.hex
      ..secondary = secondary?.hex
      ..tertiary = tertiary?.hex
      ..error = error?.hex
      ..neutral = neutral?.hex
      ..neutralVariant = neutralVariant?.hex
      ..variant = variant
      ..isPrebuilt = isPrebuilt
      ..isEditable = isEditable;
  }

  ColorScheme getColorScheme({
    required Brightness brightness,
    required double contrastLevel,
  }) => SeedColorScheme.fromSeeds(
    brightness: brightness,
    primaryKey: primary,
    secondaryKey: secondary,
    tertiaryKey: tertiary,
    errorKey: error,
    neutralKey: neutral,
    neutralVariantKey: neutralVariant,
    variant: variant,
    useExpressiveOnContainerColors: true,
    respectMonochromeSeed: true,
    contrastLevel: contrastLevel,
  );

  ThemeData light({
    double blendLevel = 6.0,
    double contrastLevel = 0.0,
    FlexSchemeVariant? variant,
    String? appFont,
    bool einkMode = false,
  }) {
    contrastLevel = einkMode ? 1.0 : contrastLevel;
    final blend = einkMode ? 0 : blendLevel.toInt();
    final colorScheme = getColorScheme(
      brightness: Brightness.light,
      contrastLevel: contrastLevel,
    );

    return FlexThemeData.light(
      useMaterial3: true,
      colorScheme: colorScheme,
      variant: variant ?? variant,
      surfaceMode: FlexSurfaceMode.level,
      blendLevel: blend,
      appBarStyle: FlexAppBarStyle.scaffoldBackground,
      subThemesData: FlexSubThemesData(
        interactionEffects: true,
        tintedDisabledControls: true,
        textButtonRadius: 4.0,
        filledButtonRadius: 8.0,
        elevatedButtonRadius: 8.0,
        outlinedButtonRadius: 8.0,
        outlinedButtonPressedBorderWidth: 2.0,
        toggleButtonsRadius: 4.0,
        segmentedButtonRadius: 8.0,
        sliderValueIndicatorType: FlexSliderIndicatorType.rectangular,
        inputDecoratorBorderType: FlexInputBorderType.outline,
        inputDecoratorRadius: 8.0,
        fabUseShape: true,
        fabRadius: 8.0,
        chipRadius: 8.0,
        cardRadius: 8.0,
        popupMenuRadius: 4.0,
        alignedDropdown: true,
        tooltipRadius: 4,
        tooltipWaitDuration: kAnimationDuration,
        tooltipSchemeColor: SchemeColor.surfaceContainerHighest,
        tooltipOpacity: null,
        dialogRadius: 8.0,
        timePickerElementRadius: 8.0,
        drawerRadius: 8.0,
        drawerIndicatorRadius: 8.0,
        bottomSheetRadius: 8.0,
        bottomNavigationBarBackgroundSchemeColor:
            einkMode
                ? SchemeColor.surfaceContainerLowest
                : SchemeColor.surfaceContainer,
        searchBarRadius: 8.0,
        searchViewRadius: 8.0,
        navigationBarIndicatorRadius: 8.0,
        navigationRailUseIndicator: true,
        navigationRailIndicatorRadius: 8.0,
        appBarBackgroundSchemeColor:
            einkMode ? SchemeColor.white : SchemeColor.surface,
        bottomAppBarSchemeColor:
            einkMode
                ? SchemeColor.surfaceContainerLowest
                : SchemeColor.surfaceContainer,
        snackBarBackgroundSchemeColor: SchemeColor.inverseSurface,
        snackBarActionSchemeColor: SchemeColor.inversePrimary,
      ),
      useMaterial3ErrorColors: true,
      visualDensity: FlexColorScheme.comfortablePlatformDensity,
      fontFamily: appFont,
    );
  }

  ThemeData dark({
    double blendLevel = 6.0,
    double contrastLevel = 0.0,
    FlexSchemeVariant? variant,
    String? appFont,
    bool usePureBlack = false,
    bool einkMode = false,
  }) {
    contrastLevel = einkMode ? 1.0 : contrastLevel;
    final blend = einkMode ? 0 : blendLevel.toInt();

    // Create color scheme
    final colorScheme = getColorScheme(
      brightness: Brightness.dark,
      contrastLevel: contrastLevel,
    );

    return FlexThemeData.dark(
      useMaterial3: true,
      colorScheme: colorScheme,
      variant: variant ?? variant,
      surfaceMode: FlexSurfaceMode.level,
      blendLevel: blend,
      darkIsTrueBlack: usePureBlack || einkMode,
      appBarStyle: FlexAppBarStyle.scaffoldBackground,
      subThemesData: FlexSubThemesData(
        interactionEffects: true,
        tintedDisabledControls: true,
        textButtonRadius: 4.0,
        filledButtonRadius: 8.0,
        elevatedButtonRadius: 8.0,
        outlinedButtonRadius: 8.0,
        outlinedButtonPressedBorderWidth: 2.0,
        toggleButtonsRadius: 4.0,
        segmentedButtonRadius: 8.0,
        sliderValueIndicatorType: FlexSliderIndicatorType.rectangular,
        inputDecoratorBorderType: FlexInputBorderType.outline,
        inputDecoratorRadius: 8.0,
        fabUseShape: true,
        fabRadius: 8.0,
        chipRadius: 8.0,
        cardRadius: 8.0,
        popupMenuRadius: 4.0,
        alignedDropdown: true,
        tooltipRadius: 4,
        tooltipWaitDuration: kAnimationDuration,
        tooltipSchemeColor: SchemeColor.surfaceContainerHighest,
        tooltipOpacity: null,
        dialogRadius: 8.0,
        timePickerElementRadius: 8.0,
        drawerRadius: 8.0,
        drawerIndicatorRadius: 8.0,
        bottomSheetRadius: 8.0,
        bottomNavigationBarBackgroundSchemeColor:
            usePureBlack || einkMode
                ? SchemeColor.surfaceContainerLowest
                : SchemeColor.surfaceContainer,
        searchBarRadius: 8.0,
        searchViewRadius: 8.0,
        navigationBarIndicatorRadius: 8.0,
        navigationRailUseIndicator: true,
        navigationRailIndicatorRadius: 8.0,
        appBarBackgroundSchemeColor:
            usePureBlack || einkMode
                ? SchemeColor.black
                : SchemeColor.surfaceContainer,
        bottomAppBarSchemeColor:
            usePureBlack || einkMode
                ? SchemeColor.surfaceContainerLowest
                : SchemeColor.surfaceContainer,
        snackBarBackgroundSchemeColor: SchemeColor.inverseSurface,
        snackBarActionSchemeColor: SchemeColor.inversePrimary,
        menuPadding: EdgeInsets.zero,
      ),
      useMaterial3ErrorColors: true,
      visualDensity: FlexColorScheme.comfortablePlatformDensity,
      fontFamily: appFont,
    );
  }
}
