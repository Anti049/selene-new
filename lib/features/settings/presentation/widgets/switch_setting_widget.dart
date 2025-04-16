import 'package:flutter/material.dart';
import 'package:selene/core/database/models/preference.dart';
import 'package:selene/core/utils/theming.dart';
import 'package:selene/features/settings/models/searchable_setting_item.dart';

class SwitchSettingWidget extends StatelessWidget {
  const SwitchSettingWidget({super.key, required this.setting});

  final SearchableSettingItem setting;

  @override
  Widget build(BuildContext context) {
    // Assert this setting is a switch setting
    assert(setting.type == SettingType.switchSetting);
    assert(setting.preference != null);
    assert(setting.preference is Preference<bool>);

    final preference = setting.preference as Preference<bool>;

    return ListTile(
      leading: Icon(setting.icon, color: context.scheme.primary),
      title: Text(setting.label),
      subtitle: setting.subtitle != null ? Text(setting.subtitle!) : null,
      trailing: Switch(
        value: preference.get(),
        onChanged: (value) => preference.toggle(),
      ),
      onTap: () => preference.toggle(),
      horizontalTitleGap: 24.0,
    );
  }
}
