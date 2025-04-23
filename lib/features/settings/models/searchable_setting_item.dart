import 'package:change_case/change_case.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:selene/core/database/models/preference.dart';
import 'package:selene/features/settings/presentation/widgets/button_setting_widget.dart';
import 'package:selene/features/settings/presentation/widgets/checkbox_setting_widget.dart';
import 'package:selene/features/settings/presentation/widgets/link_setting_widget.dart';
import 'package:selene/features/settings/presentation/widgets/segmented_setting_widget.dart';
import 'package:selene/features/settings/presentation/widgets/settings_group_widget.dart';
import 'package:selene/features/settings/presentation/widgets/slider_setting_widget.dart';
import 'package:selene/features/settings/presentation/widgets/switch_setting_widget.dart';

part 'searchable_setting_item.freezed.dart';

enum SettingType {
  switchSetting,
  checkboxSetting,
  sliderSetting,
  segmentedSetting,
  dropdownSetting,
  textSetting,
  buttonSetting,
  linkSetting,
  widgetSetting,
  dividerSetting,
  groupSetting,
  fileSetting, // Not used yet
  folderSetting,
}

@freezed
class SearchableSettingItem with _$SearchableSettingItem {
  const SearchableSettingItem._();

  const factory SearchableSettingItem({
    required String label,
    String? subtitle,
    IconData? icon,
    @Default(SettingType.textSetting) SettingType type,
    @Default([]) List<String> keywords,
    @Default([]) List<String> breadcrumbs,
    Preference? preference,
    Widget? widget,
    String? route,
    Function(BuildContext)? onTapAction,
    List<Enum>? options,
    List<SearchableSettingItem>? children,
    @Default(true) bool enabled,
    @Default(false) bool dense,
    @Default(0.0) double min,
    @Default(1.0) double max,
    int? divisions,
  }) = _SearchableSettingItem;

  factory SearchableSettingItem.link({
    required String label,
    String? subtitle,
    IconData? icon,
    required String route,
  }) => SearchableSettingItem(
    label: label,
    subtitle: subtitle,
    icon: icon,
    type: SettingType.linkSetting,
    route: route,
  );

  factory SearchableSettingItem.widget({required Widget widget}) =>
      SearchableSettingItem(
        label: 'widget',
        type: SettingType.widgetSetting,
        widget: widget,
      );

  factory SearchableSettingItem.divider() => const SearchableSettingItem(
    label: 'divider',
    type: SettingType.dividerSetting,
  );

  factory SearchableSettingItem.group({
    required String label,
    required List<SearchableSettingItem> children,
  }) => SearchableSettingItem(
    label: label,
    type: SettingType.groupSetting,
    children: children,
  );

  Widget buildWidget(BuildContext context) {
    switch (type) {
      case SettingType.switchSetting:
        return SwitchSettingWidget(
          label: label,
          subtitle: subtitle,
          icon: icon,
          preference: preference as Preference<bool>,
          enabled: enabled,
        );
      case SettingType.checkboxSetting:
        return CheckboxSettingWidget(
          label: label,
          subtitle: subtitle,
          icon: icon,
          preference: preference!,
          checkboxPosition: CheckboxPosition.leading,
          enabled: enabled,
          dense: dense,
        );
      case SettingType.sliderSetting:
        return SliderSettingWidget(
          label: label,
          icon: icon,
          preference: preference as Preference<double>,
          min: min,
          max: max,
          divisions: divisions,
          enabled: enabled,
        );
      case SettingType.segmentedSetting:
        return SegmentedSettingWidget(
          values: options ?? const [],
          preference: preference as Preference<Enum>,
        );
      // case SettingType.dropdownSetting:
      //   return DropdownSettingWidget(setting: this);
      // case SettingType.textSetting:
      //   return TextSettingWidget(setting: this);
      case SettingType.buttonSetting:
        return ButtonSettingWidget(
          label: label,
          subtitle: subtitle,
          icon: icon,
          onTap: onTapAction ?? (context) {},
        );
      case SettingType.linkSetting:
        return LinkSettingWidget(
          label: label,
          subtitle: subtitle,
          icon: icon,
          route: route ?? '',
        );
      case SettingType.widgetSetting:
        return widget ?? const SizedBox.shrink();
      case SettingType.dividerSetting:
        return const Divider();
      case SettingType.groupSetting:
        return SettingsGroupWidget(
          label: label,
          icon: icon,
          children: children ?? const [],
        );
      default:
        throw Exception('Unknown setting type: $type');
    }
  }

  String get settingID => label.toKebabCase();
}
