import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:selene/core/database/models/preference.dart';
import 'package:selene/core/utils/enums.dart';
import 'package:selene/core/utils/theming.dart';
import 'package:selene/features/library/providers/library_preferences.dart';
import 'package:selene/features/settings/presentation/widgets/button_setting_widget.dart';

@RoutePage()
class SortOptionsTab extends ConsumerWidget {
  const SortOptionsTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Get provider
    final libraryPrefs = ref.watch(libraryPreferencesProvider);

    // Return ListView
    return ListView(
      controller: ScrollController(),
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.zero,
      children: [
        ...SortBy.values.map((sortBy) {
          return ButtonSettingWidget(
            label: sortBy.label,
            icon:
                libraryPrefs.sortBy.get() == sortBy
                    ? libraryPrefs.sortOrder.get() == SortOrder.ascending
                        ? Symbols.arrow_upward
                        : Symbols.arrow_downward
                    : null,
            onTap: () {
              if (libraryPrefs.sortBy.get() == sortBy) {
                libraryPrefs.sortOrder.cycle(SortOrder.values);
              } else {
                libraryPrefs.sortBy.set(sortBy);
                libraryPrefs.sortOrder.set(SortOrder.ascending);
              }
            },
          );
        }),
        SizedBox(height: context.mediaQuery.systemGestureInsets.bottom),
      ],
    );
  }
}
