import 'package:flutter/material.dart';
import 'package:selene/core/database/models/preference.dart';
import 'package:selene/features/settings/presentation/widgets/base_setting_widget.dart';

class SliderSettingWidget extends StatelessWidget {
  const SliderSettingWidget({
    super.key,
    required this.label,
    this.icon,
    required this.preference,
    this.min = 0.0,
    this.max = 1.0,
    this.divisions,
    this.enabled = true,
  });

  final String label;
  final IconData? icon;
  final Preference<double> preference;
  final double min;
  final double max;
  final int? divisions;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return BaseSettingWidget(
      title: label,
      icon: icon,
      enabled: enabled,
      subcomponent: Slider(
        value: preference.get(),
        label: preference.get().toStringAsFixed(1),
        min: min,
        max: max,
        divisions: divisions,
        onChanged: enabled ? (value) => preference.set(value) : null,
        padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      ),
    );
  }
}
