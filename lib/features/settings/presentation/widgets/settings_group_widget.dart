import 'package:change_case/change_case.dart';
import 'package:flutter/material.dart';
import 'package:selene/core/utils/theming.dart';
import 'package:selene/features/settings/models/searchable_setting_item.dart';

class SettingsGroupWidget extends StatelessWidget {
  const SettingsGroupWidget({super.key, required this.setting});

  final SearchableSettingItem setting;

  @override
  Widget build(BuildContext context) {
    // Assert this setting is a group setting
    assert(setting.type == SettingType.groupSetting);
    assert(setting.children != null);

    final id = setting.label.toKebabCase();

    return ListView(
      key: Key(id),
      shrinkWrap: true,
      children: [
        Container(
          alignment: AlignmentDirectional.centerStart,
          padding: const EdgeInsets.only(bottom: 8.0, top: 14.0),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                if (setting.icon != null)
                  Padding(
                    padding: const EdgeInsetsDirectional.only(end: 8.0),
                    child: Icon(
                      setting.icon,
                      color: context.scheme.secondary,
                      size: 16.0,
                    ),
                  ),
                Text(
                  setting.label,
                  style: context.text.bodyMedium?.copyWith(
                    color: context.scheme.secondary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
        ...setting.children!.map((e) => e.buildWidget(context)),
      ],
    );
  }
}
