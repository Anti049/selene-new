import 'package:flutter/material.dart';
import 'package:selene/core/utils/theming.dart';
import 'package:selene/features/settings/models/searchable_setting_item.dart';

class ButtonSettingWidget extends StatelessWidget {
  const ButtonSettingWidget({super.key, required this.setting});

  final SearchableSettingItem setting;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(setting.label),
      subtitle: setting.subtitle != null ? Text(setting.subtitle!) : null,
      leading: Icon(setting.icon, color: context.scheme.primary),
      onTap: setting.onTapAction,
    );
  }
}
