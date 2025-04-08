// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'shell_page.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ShellPage {

 String get label; PageRouteInfo get route; IconData get icon;
/// Create a copy of ShellPage
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ShellPageCopyWith<ShellPage> get copyWith => _$ShellPageCopyWithImpl<ShellPage>(this as ShellPage, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ShellPage&&(identical(other.label, label) || other.label == label)&&(identical(other.route, route) || other.route == route)&&(identical(other.icon, icon) || other.icon == icon));
}


@override
int get hashCode => Object.hash(runtimeType,label,route,icon);

@override
String toString() {
  return 'ShellPage(label: $label, route: $route, icon: $icon)';
}


}

/// @nodoc
abstract mixin class $ShellPageCopyWith<$Res>  {
  factory $ShellPageCopyWith(ShellPage value, $Res Function(ShellPage) _then) = _$ShellPageCopyWithImpl;
@useResult
$Res call({
 String label, PageRouteInfo route, IconData icon
});




}
/// @nodoc
class _$ShellPageCopyWithImpl<$Res>
    implements $ShellPageCopyWith<$Res> {
  _$ShellPageCopyWithImpl(this._self, this._then);

  final ShellPage _self;
  final $Res Function(ShellPage) _then;

/// Create a copy of ShellPage
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? label = null,Object? route = null,Object? icon = null,}) {
  return _then(_self.copyWith(
label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,route: null == route ? _self.route : route // ignore: cast_nullable_to_non_nullable
as PageRouteInfo,icon: null == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as IconData,
  ));
}

}


/// @nodoc


class _ShellPage extends ShellPage {
  const _ShellPage({required this.label, required this.route, required this.icon}): super._();
  

@override final  String label;
@override final  PageRouteInfo route;
@override final  IconData icon;

/// Create a copy of ShellPage
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ShellPageCopyWith<_ShellPage> get copyWith => __$ShellPageCopyWithImpl<_ShellPage>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ShellPage&&(identical(other.label, label) || other.label == label)&&(identical(other.route, route) || other.route == route)&&(identical(other.icon, icon) || other.icon == icon));
}


@override
int get hashCode => Object.hash(runtimeType,label,route,icon);

@override
String toString() {
  return 'ShellPage(label: $label, route: $route, icon: $icon)';
}


}

/// @nodoc
abstract mixin class _$ShellPageCopyWith<$Res> implements $ShellPageCopyWith<$Res> {
  factory _$ShellPageCopyWith(_ShellPage value, $Res Function(_ShellPage) _then) = __$ShellPageCopyWithImpl;
@override @useResult
$Res call({
 String label, PageRouteInfo route, IconData icon
});




}
/// @nodoc
class __$ShellPageCopyWithImpl<$Res>
    implements _$ShellPageCopyWith<$Res> {
  __$ShellPageCopyWithImpl(this._self, this._then);

  final _ShellPage _self;
  final $Res Function(_ShellPage) _then;

/// Create a copy of ShellPage
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? label = null,Object? route = null,Object? icon = null,}) {
  return _then(_ShellPage(
label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,route: null == route ? _self.route : route // ignore: cast_nullable_to_non_nullable
as PageRouteInfo,icon: null == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as IconData,
  ));
}


}

// dart format on
