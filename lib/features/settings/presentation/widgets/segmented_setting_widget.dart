import 'package:change_case/change_case.dart';
import 'package:flutter/material.dart';
import 'package:selene/core/database/models/preference.dart';

class SegmentedSettingWidget extends StatelessWidget {
  const SegmentedSettingWidget({
    super.key,
    required this.values,
    required this.preference,
  });

  final List<Enum> values;
  final Preference<Enum> preference;

  @override
  Widget build(BuildContext context) {
    final selectedValue = preference.get();

    return ListTile(
      title: SegmentedButton(
        segments:
            values.map((e) {
              return ButtonSegment<Enum>(
                value: e,
                label: Text(e.name.toCapitalCase()),
              );
            }).toList(),
        selected: {selectedValue},
        onSelectionChanged: (value) {
          preference.set(value.first);
        },
      ),
    );
  }
}
