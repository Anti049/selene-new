import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:selene/core/utils/theming.dart';

class BaseSettingWidget extends StatelessWidget {
  const BaseSettingWidget({
    super.key,
    this.title,
    this.subtitle,
    this.subcomponent,
    this.leading,
    this.trailing,
    this.icon,
    this.onTap,
    this.enabled = true,
    this.dense = false,
    this.disabledMessage,
  });

  final String? title;
  final String? subtitle;
  final Widget? subcomponent;
  final Widget? leading;
  final Widget? trailing;
  final IconData? icon;
  final Function(BuildContext)? onTap;
  final bool enabled;
  final bool dense;
  final String? disabledMessage;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title:
          title.isNotNullOrBlank
              ? Text(
                title!,
                style: context.text.bodyLarge?.copyWith(
                  color: context.scheme.onSurface.withValues(
                    alpha: enabled ? 1.0 : 0.38,
                  ),
                ),
              )
              : null,
      subtitle:
          subtitle.isNotNullOrBlank
              ? Text(
                subtitle!,
                style: context.text.bodySmall?.copyWith(
                  color: context.scheme.onSurfaceVariant.withValues(
                    alpha: enabled ? 0.75 : 0.38,
                  ),
                ),
              )
              : subcomponent,
      leading:
          leading ??
          (icon != null
              ? Icon(
                icon,
                color:
                    enabled
                        ? context.scheme.primary
                        : context.scheme.onSurfaceVariant,
              )
              : null),
      trailing: trailing,
      onTap:
          enabled
              ? () => onTap?.call(context)
              : disabledMessage.isNotNullOrBlank
              ? () {
                if (disabledMessage != null) {
                  ScaffoldMessenger.of(context).removeCurrentSnackBar();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(disabledMessage!),
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                }
              }
              : null,
      horizontalTitleGap: switch (leading) {
        null => icon != null ? 24.0 : 0.0,
        _ => 16.0,
      },
      dense: dense,
    );
  }
}
