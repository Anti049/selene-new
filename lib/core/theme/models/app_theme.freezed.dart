// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_theme.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AppTheme {

 String get id; String get name; ThemeCategory get category;@ColorConverter() Color get primary;@ColorConverter() Color? get secondary;@ColorConverter() Color? get tertiary;@ColorConverter() Color? get error;@ColorConverter() Color? get neutral;@ColorConverter() Color? get neutralVariant; FlexSchemeVariant get variant; bool get isPrebuilt; bool get isEditable;
/// Create a copy of AppTheme
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AppThemeCopyWith<AppTheme> get copyWith => _$AppThemeCopyWithImpl<AppTheme>(this as AppTheme, _$identity);

  /// Serializes this AppTheme to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppTheme&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.category, category) || other.category == category)&&(identical(other.primary, primary) || other.primary == primary)&&(identical(other.secondary, secondary) || other.secondary == secondary)&&(identical(other.tertiary, tertiary) || other.tertiary == tertiary)&&(identical(other.error, error) || other.error == error)&&(identical(other.neutral, neutral) || other.neutral == neutral)&&(identical(other.neutralVariant, neutralVariant) || other.neutralVariant == neutralVariant)&&(identical(other.variant, variant) || other.variant == variant)&&(identical(other.isPrebuilt, isPrebuilt) || other.isPrebuilt == isPrebuilt)&&(identical(other.isEditable, isEditable) || other.isEditable == isEditable));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,category,primary,secondary,tertiary,error,neutral,neutralVariant,variant,isPrebuilt,isEditable);

@override
String toString() {
  return 'AppTheme(id: $id, name: $name, category: $category, primary: $primary, secondary: $secondary, tertiary: $tertiary, error: $error, neutral: $neutral, neutralVariant: $neutralVariant, variant: $variant, isPrebuilt: $isPrebuilt, isEditable: $isEditable)';
}


}

/// @nodoc
abstract mixin class $AppThemeCopyWith<$Res>  {
  factory $AppThemeCopyWith(AppTheme value, $Res Function(AppTheme) _then) = _$AppThemeCopyWithImpl;
@useResult
$Res call({
 String id, String name, ThemeCategory category,@ColorConverter() Color primary,@ColorConverter() Color? secondary,@ColorConverter() Color? tertiary,@ColorConverter() Color? error,@ColorConverter() Color? neutral,@ColorConverter() Color? neutralVariant, FlexSchemeVariant variant, bool isPrebuilt, bool isEditable
});




}
/// @nodoc
class _$AppThemeCopyWithImpl<$Res>
    implements $AppThemeCopyWith<$Res> {
  _$AppThemeCopyWithImpl(this._self, this._then);

  final AppTheme _self;
  final $Res Function(AppTheme) _then;

/// Create a copy of AppTheme
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? category = null,Object? primary = null,Object? secondary = freezed,Object? tertiary = freezed,Object? error = freezed,Object? neutral = freezed,Object? neutralVariant = freezed,Object? variant = null,Object? isPrebuilt = null,Object? isEditable = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as ThemeCategory,primary: null == primary ? _self.primary : primary // ignore: cast_nullable_to_non_nullable
as Color,secondary: freezed == secondary ? _self.secondary : secondary // ignore: cast_nullable_to_non_nullable
as Color?,tertiary: freezed == tertiary ? _self.tertiary : tertiary // ignore: cast_nullable_to_non_nullable
as Color?,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as Color?,neutral: freezed == neutral ? _self.neutral : neutral // ignore: cast_nullable_to_non_nullable
as Color?,neutralVariant: freezed == neutralVariant ? _self.neutralVariant : neutralVariant // ignore: cast_nullable_to_non_nullable
as Color?,variant: null == variant ? _self.variant : variant // ignore: cast_nullable_to_non_nullable
as FlexSchemeVariant,isPrebuilt: null == isPrebuilt ? _self.isPrebuilt : isPrebuilt // ignore: cast_nullable_to_non_nullable
as bool,isEditable: null == isEditable ? _self.isEditable : isEditable // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _AppTheme extends AppTheme {
  const _AppTheme({required this.id, required this.name, this.category = ThemeCategory.custom, @ColorConverter() required this.primary, @ColorConverter() this.secondary, @ColorConverter() this.tertiary, @ColorConverter() this.error, @ColorConverter() this.neutral, @ColorConverter() this.neutralVariant, this.variant = FlexSchemeVariant.tonalSpot, this.isPrebuilt = false, this.isEditable = true}): super._();
  factory _AppTheme.fromJson(Map<String, dynamic> json) => _$AppThemeFromJson(json);

@override final  String id;
@override final  String name;
@override@JsonKey() final  ThemeCategory category;
@override@ColorConverter() final  Color primary;
@override@ColorConverter() final  Color? secondary;
@override@ColorConverter() final  Color? tertiary;
@override@ColorConverter() final  Color? error;
@override@ColorConverter() final  Color? neutral;
@override@ColorConverter() final  Color? neutralVariant;
@override@JsonKey() final  FlexSchemeVariant variant;
@override@JsonKey() final  bool isPrebuilt;
@override@JsonKey() final  bool isEditable;

/// Create a copy of AppTheme
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AppThemeCopyWith<_AppTheme> get copyWith => __$AppThemeCopyWithImpl<_AppTheme>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AppThemeToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AppTheme&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.category, category) || other.category == category)&&(identical(other.primary, primary) || other.primary == primary)&&(identical(other.secondary, secondary) || other.secondary == secondary)&&(identical(other.tertiary, tertiary) || other.tertiary == tertiary)&&(identical(other.error, error) || other.error == error)&&(identical(other.neutral, neutral) || other.neutral == neutral)&&(identical(other.neutralVariant, neutralVariant) || other.neutralVariant == neutralVariant)&&(identical(other.variant, variant) || other.variant == variant)&&(identical(other.isPrebuilt, isPrebuilt) || other.isPrebuilt == isPrebuilt)&&(identical(other.isEditable, isEditable) || other.isEditable == isEditable));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,category,primary,secondary,tertiary,error,neutral,neutralVariant,variant,isPrebuilt,isEditable);

@override
String toString() {
  return 'AppTheme(id: $id, name: $name, category: $category, primary: $primary, secondary: $secondary, tertiary: $tertiary, error: $error, neutral: $neutral, neutralVariant: $neutralVariant, variant: $variant, isPrebuilt: $isPrebuilt, isEditable: $isEditable)';
}


}

/// @nodoc
abstract mixin class _$AppThemeCopyWith<$Res> implements $AppThemeCopyWith<$Res> {
  factory _$AppThemeCopyWith(_AppTheme value, $Res Function(_AppTheme) _then) = __$AppThemeCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, ThemeCategory category,@ColorConverter() Color primary,@ColorConverter() Color? secondary,@ColorConverter() Color? tertiary,@ColorConverter() Color? error,@ColorConverter() Color? neutral,@ColorConverter() Color? neutralVariant, FlexSchemeVariant variant, bool isPrebuilt, bool isEditable
});




}
/// @nodoc
class __$AppThemeCopyWithImpl<$Res>
    implements _$AppThemeCopyWith<$Res> {
  __$AppThemeCopyWithImpl(this._self, this._then);

  final _AppTheme _self;
  final $Res Function(_AppTheme) _then;

/// Create a copy of AppTheme
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? category = null,Object? primary = null,Object? secondary = freezed,Object? tertiary = freezed,Object? error = freezed,Object? neutral = freezed,Object? neutralVariant = freezed,Object? variant = null,Object? isPrebuilt = null,Object? isEditable = null,}) {
  return _then(_AppTheme(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as ThemeCategory,primary: null == primary ? _self.primary : primary // ignore: cast_nullable_to_non_nullable
as Color,secondary: freezed == secondary ? _self.secondary : secondary // ignore: cast_nullable_to_non_nullable
as Color?,tertiary: freezed == tertiary ? _self.tertiary : tertiary // ignore: cast_nullable_to_non_nullable
as Color?,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as Color?,neutral: freezed == neutral ? _self.neutral : neutral // ignore: cast_nullable_to_non_nullable
as Color?,neutralVariant: freezed == neutralVariant ? _self.neutralVariant : neutralVariant // ignore: cast_nullable_to_non_nullable
as Color?,variant: null == variant ? _self.variant : variant // ignore: cast_nullable_to_non_nullable
as FlexSchemeVariant,isPrebuilt: null == isPrebuilt ? _self.isPrebuilt : isPrebuilt // ignore: cast_nullable_to_non_nullable
as bool,isEditable: null == isEditable ? _self.isEditable : isEditable // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
