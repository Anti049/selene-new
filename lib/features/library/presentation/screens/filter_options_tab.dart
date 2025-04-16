import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:selene/features/library/providers/library_preferences.dart';
import 'package:selene/features/settings/models/searchable_setting_item.dart';

@RoutePage()
class FilterOptionsTab extends ConsumerWidget {
  const FilterOptionsTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Get provider
    final libraryPrefs = ref.watch(libraryPreferencesProvider);

    // Compute settings
    final settings = [
      SearchableSettingItem(
        label: 'Downloaded',
        type: SettingType.checkboxSetting,
        preference: libraryPrefs.filterDownloaded,
      ),
      SearchableSettingItem(
        label: 'Unread',
        type: SettingType.checkboxSetting,
        preference: libraryPrefs.filterUnread,
      ),
      SearchableSettingItem(
        label: 'Favorited',
        type: SettingType.checkboxSetting,
        preference: libraryPrefs.filterFavorites,
      ),
      SearchableSettingItem(
        label: 'Started',
        type: SettingType.checkboxSetting,
        preference: libraryPrefs.filterStarted,
      ),
      SearchableSettingItem(
        label: 'Completed',
        type: SettingType.checkboxSetting,
        preference: libraryPrefs.filterCompleted,
      ),
      SearchableSettingItem(
        label: 'Updated',
        type: SettingType.checkboxSetting,
        preference: libraryPrefs.filterUpdated,
      ),
    ];

    // Return ListView
    return ListView(
      controller: ScrollController(),
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.zero,
      children:
          settings.map((setting) => setting.buildWidget(context)).toList(),
    );
  }
}
