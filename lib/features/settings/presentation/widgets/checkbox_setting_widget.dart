import 'package:flutter/material.dart';
import 'package:selene/core/database/models/preference.dart';
import 'package:selene/core/utils/enums.dart';
import 'package:selene/core/utils/theming.dart';
import 'package:selene/features/settings/presentation/widgets/base_setting_widget.dart';

enum CheckboxPosition { leading, trailing }

class CheckboxSettingWidget extends StatelessWidget {
  const CheckboxSettingWidget({
    super.key,
    required this.label,
    this.subtitle,
    this.icon,
    required this.preference,
    this.checkboxPosition = CheckboxPosition.leading,
    this.enabled = true,
    this.dense = false,
  });

  final String label;
  final String? subtitle;
  final IconData? icon;
  final Preference preference;
  final CheckboxPosition checkboxPosition;
  final bool enabled;
  final bool dense;

  bool? get value {
    if (preference is Preference<bool>) {
      return (preference as Preference<bool>).get();
    }
    if (preference is Preference<TriState>) {
      return (preference as Preference<TriState>).get().toBool();
    }
    throw Exception(
      'Invalid preference type for checkbox setting: ${preference.runtimeType}',
    );
  }

  void updateValue(bool? newValue) {
    if (preference is Preference<bool>) {
      (preference as Preference<bool>).set(newValue ?? false);
    } else if (preference is Preference<TriState>) {
      (preference as Preference<TriState>).set(TriState.fromBool(newValue));
    } else {
      throw Exception(
        'Invalid preference type for checkbox setting: ${preference.runtimeType}',
      );
    }
  }

  Color? getColor(BuildContext context) {
    dynamic value = preference.get();
    Type T = preference.runtimeType;
    if (T == Preference<bool>) {
      value = value as bool?;
    } else if (T == Preference<TriState>) {
      value = (value as TriState?)?.toBool();
    }
    return switch (value as bool?) {
      false => null,
      true => context.scheme.primary,
      null => context.scheme.error,
    };
  }

  void cycleValue() {
    if (preference is Preference<bool>) {
      (preference as Preference<bool>).toggle();
    } else if (preference is Preference<TriState>) {
      (preference as Preference<TriState>).cycle(TriState.values);
    } else {
      throw Exception('Cycle operation is only valid for TriState preferences');
    }
  }

  Widget _buildCheckbox(BuildContext context) {
    return Checkbox(
      value: value,
      onChanged: enabled ? updateValue : null,
      tristate: preference is Preference<TriState>,
      activeColor: getColor(context),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Assert this setting is a checkbox setting
    assert(
      preference is Preference<bool> || preference is Preference<TriState>,
    );

    return BaseSettingWidget(
      title: label,
      subtitle: subtitle,
      icon: icon,
      leading:
          checkboxPosition == CheckboxPosition.leading
              ? _buildCheckbox(context)
              : null,
      trailing:
          checkboxPosition == CheckboxPosition.trailing
              ? _buildCheckbox(context)
              : null,
      enabled: enabled,
      dense: dense,
      onTap: cycleValue,
    );
  }
}
