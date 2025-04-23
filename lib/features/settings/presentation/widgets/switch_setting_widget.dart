import 'package:flutter/material.dart';
import 'package:selene/core/database/models/preference.dart';
import 'package:selene/features/settings/presentation/widgets/base_setting_widget.dart';

class SwitchSettingWidget extends StatelessWidget {
  const SwitchSettingWidget({
    super.key,
    required this.label,
    this.subtitle,
    this.icon,
    required this.preference,
    this.enabled = true,
  });

  final String label;
  final String? subtitle;
  final IconData? icon;
  final Preference<bool> preference;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return BaseSettingWidget(
      title: label,
      subtitle: subtitle,
      icon: icon,
      enabled: enabled,
      trailing: Switch(
        value: preference.get(),
        onChanged: (value) => preference.set(value),
      ),
      onTap: (context) => preference.toggle(),
    );
  }
}
