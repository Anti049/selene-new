import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:selene/core/utils/theming.dart';
import 'package:selene/features/library/providers/library_preferences.dart';
import 'package:selene/features/settings/presentation/widgets/checkbox_setting_widget.dart';

@RoutePage()
class FilterOptionsTab extends ConsumerWidget {
  const FilterOptionsTab({super.key});

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
        CheckboxSettingWidget(
          label: 'Downloaded',
          preference: libraryPrefs.filterDownloaded,
        ),
        CheckboxSettingWidget(
          label: 'Unread',
          preference: libraryPrefs.filterUnread,
        ),
        CheckboxSettingWidget(
          label: 'Favorited',
          preference: libraryPrefs.filterFavorites,
        ),
        CheckboxSettingWidget(
          label: 'Started',
          preference: libraryPrefs.filterStarted,
        ),
        CheckboxSettingWidget(
          label: 'Completed',
          preference: libraryPrefs.filterCompleted,
        ),
        CheckboxSettingWidget(
          label: 'Updated',
          preference: libraryPrefs.filterUpdated,
        ),
        SizedBox(height: context.mediaQuery.systemGestureInsets.bottom),
      ],
    );
  }
}
