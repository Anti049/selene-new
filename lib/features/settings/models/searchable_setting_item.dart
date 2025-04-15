import 'package:change_case/change_case.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:selene/core/database/models/preference.dart';
import 'package:selene/features/settings/presentation/widgets/link_setting_widget.dart';
import 'package:selene/features/settings/presentation/widgets/segmented_setting_widget.dart';
import 'package:selene/features/settings/presentation/widgets/settings_group_widget.dart';
import 'package:selene/features/settings/presentation/widgets/switch_setting_widget.dart';

part 'searchable_setting_item.freezed.dart';

enum SettingType {
  switchSetting,
  sliderSetting,
  segmentedSetting,
  dropdownSetting,
  textSetting,
  buttonSetting,
  linkSetting,
  widgetSetting,
  dividerSetting,
  groupSetting,
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
    Function()? onTapAction,
    List<Enum>? options,
    List<SearchableSettingItem>? children,
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
        return SwitchSettingWidget(setting: this);
      // case SettingType.sliderSetting:
      //   return SliderSettingWidget(setting: this);
      case SettingType.segmentedSetting:
        return SegmentedSettingWidget(setting: this);
      // case SettingType.dropdownSetting:
      //   return DropdownSettingWidget(setting: this);
      // case SettingType.textSetting:
      //   return TextSettingWidget(setting: this);
      // case SettingType.buttonSetting:
      //   return ButtonSettingWidget(setting: this);
      case SettingType.linkSetting:
        return LinkSettingWidget(setting: this);
      case SettingType.widgetSetting:
        return widget ?? const SizedBox.shrink();
      case SettingType.dividerSetting:
        return const Divider();
      case SettingType.groupSetting:
        return SettingsGroupWidget(setting: this);
      default:
        throw Exception('Unknown setting type: $type');
    }
  }

  String get settingID => label.toKebabCase();
}
