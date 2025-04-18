import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:selene/features/settings/presentation/widgets/base_setting_widget.dart';

class LinkSettingWidget extends StatelessWidget {
  const LinkSettingWidget({
    super.key,
    required this.label,
    this.subtitle,
    this.icon,
    required this.route,
    this.enabled = true,
  });

  final String label;
  final String? subtitle;
  final IconData? icon;
  final String route;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return BaseSettingWidget(
      title: label,
      subtitle: subtitle,
      icon: icon,
      onTap: () {
        context.router.pushNamed(route);
      },
      enabled: enabled,
      disabledMessage: 'The route "$route" is not available.',
    );
  }
}
