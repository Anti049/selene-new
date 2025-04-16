import 'package:change_case/change_case.dart';
import 'package:flutter/material.dart';
import 'package:selene/core/database/models/preference.dart';
import 'package:selene/features/settings/models/searchable_setting_item.dart';

class SegmentedSettingWidget extends StatelessWidget {
  const SegmentedSettingWidget({super.key, required this.setting});

  final SearchableSettingItem setting;

  @override
  Widget build(BuildContext context) {
    // Assert this setting is a segmented setting
    assert(setting.type == SettingType.segmentedSetting);
    assert(setting.preference != null);
    assert(setting.preference is Preference<Enum>);
    assert(setting.options != null);

    // Get possible values
    final possibleValues = setting.options ?? [];
    final selectedValue = setting.preference!.get();

    return ListTile(
      title: SegmentedButton(
        segments:
            possibleValues.map((e) {
              return ButtonSegment<Enum>(
                value: e,
                label: Text(e.name.toCapitalCase()),
              );
            }).toList(),
        selected: {selectedValue},
        onSelectionChanged: (value) {
          setting.preference!.set(value.first);
        },
      ),
    );
  }
}
