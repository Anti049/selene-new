import 'package:flutter/material.dart';
import 'package:selene/features/settings/presentation/widgets/base_setting_widget.dart';

class ButtonSettingWidget extends StatelessWidget {
  const ButtonSettingWidget({
    super.key,
    required this.label,
    this.subtitle,
    this.icon,
    required this.onTap,
    this.enabled = true,
  });

  final String label;
  final String? subtitle;
  final IconData? icon;
  final Function(BuildContext) onTap;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return BaseSettingWidget(
      title: label,
      subtitle: subtitle,
      icon: icon,
      onTap: onTap,
      enabled: enabled,
    );
  }
}
