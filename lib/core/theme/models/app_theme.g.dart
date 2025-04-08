// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_theme.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AppTheme _$AppThemeFromJson(Map<String, dynamic> json) => _AppTheme(
  id: json['id'] as String,
  name: json['name'] as String,
  category:
      $enumDecodeNullable(_$ThemeCategoryEnumMap, json['category']) ??
      ThemeCategory.custom,
  primary: const ColorConverter().fromJson(json['primary'] as String),
  secondary: _$JsonConverterFromJson<String, Color>(
    json['secondary'],
    const ColorConverter().fromJson,
  ),
  tertiary: _$JsonConverterFromJson<String, Color>(
    json['tertiary'],
    const ColorConverter().fromJson,
  ),
  error: _$JsonConverterFromJson<String, Color>(
    json['error'],
    const ColorConverter().fromJson,
  ),
  neutral: _$JsonConverterFromJson<String, Color>(
    json['neutral'],
    const ColorConverter().fromJson,
  ),
  neutralVariant: _$JsonConverterFromJson<String, Color>(
    json['neutralVariant'],
    const ColorConverter().fromJson,
  ),
  variant:
      $enumDecodeNullable(_$FlexSchemeVariantEnumMap, json['variant']) ??
      FlexSchemeVariant.tonalSpot,
  isPrebuilt: json['isPrebuilt'] as bool? ?? false,
  isEditable: json['isEditable'] as bool? ?? true,
);

Map<String, dynamic> _$AppThemeToJson(_AppTheme instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'category': _$ThemeCategoryEnumMap[instance.category]!,
  'primary': const ColorConverter().toJson(instance.primary),
  'secondary': _$JsonConverterToJson<String, Color>(
    instance.secondary,
    const ColorConverter().toJson,
  ),
  'tertiary': _$JsonConverterToJson<String, Color>(
    instance.tertiary,
    const ColorConverter().toJson,
  ),
  'error': _$JsonConverterToJson<String, Color>(
    instance.error,
    const ColorConverter().toJson,
  ),
  'neutral': _$JsonConverterToJson<String, Color>(
    instance.neutral,
    const ColorConverter().toJson,
  ),
  'neutralVariant': _$JsonConverterToJson<String, Color>(
    instance.neutralVariant,
    const ColorConverter().toJson,
  ),
  'variant': _$FlexSchemeVariantEnumMap[instance.variant]!,
  'isPrebuilt': instance.isPrebuilt,
  'isEditable': instance.isEditable,
};

const _$ThemeCategoryEnumMap = {
  ThemeCategory.system: 'system',
  ThemeCategory.custom: 'custom',
  ThemeCategory.site: 'site',
  ThemeCategory.tachiyomi: 'tachiyomi',
  ThemeCategory.flex: 'flex',
  ThemeCategory.hsr: 'hsr',
};

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) => json == null ? null : fromJson(json as Json);

const _$FlexSchemeVariantEnumMap = {
  FlexSchemeVariant.tonalSpot: 'tonalSpot',
  FlexSchemeVariant.fidelity: 'fidelity',
  FlexSchemeVariant.monochrome: 'monochrome',
  FlexSchemeVariant.neutral: 'neutral',
  FlexSchemeVariant.vibrant: 'vibrant',
  FlexSchemeVariant.expressive: 'expressive',
  FlexSchemeVariant.content: 'content',
  FlexSchemeVariant.rainbow: 'rainbow',
  FlexSchemeVariant.fruitSalad: 'fruitSalad',
  FlexSchemeVariant.material: 'material',
  FlexSchemeVariant.material3Legacy: 'material3Legacy',
  FlexSchemeVariant.soft: 'soft',
  FlexSchemeVariant.vivid: 'vivid',
  FlexSchemeVariant.vividSurfaces: 'vividSurfaces',
  FlexSchemeVariant.highContrast: 'highContrast',
  FlexSchemeVariant.ultraContrast: 'ultraContrast',
  FlexSchemeVariant.jolly: 'jolly',
  FlexSchemeVariant.vividBackground: 'vividBackground',
  FlexSchemeVariant.oneHue: 'oneHue',
  FlexSchemeVariant.candyPop: 'candyPop',
  FlexSchemeVariant.chroma: 'chroma',
};

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) => value == null ? null : toJson(value);
