import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:selene/common/widgets/themed_logo.dart';
import 'package:selene/features/more/providers/more_preferences.dart';
import 'package:selene/features/settings/models/searchable_setting_item.dart';

@RoutePage()
class MoreTab extends ConsumerWidget {
  const MoreTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final moreSettings = [
      SearchableSettingItem.widget(
        widget: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 24.0),
              child: ThemedLogo(),
            ),
            const Divider(),
          ],
        ),
      ),
      SearchableSettingItem(
        label: 'Downloaded Only',
        subtitle: 'Show only downloaded items',
        icon: Symbols.cloud_off,
        type: SettingType.switchSetting,
        preference: ref.watch(morePreferencesProvider).downloadedOnlyMode,
      ),
      SearchableSettingItem(
        label: 'Incognito Mode',
        subtitle: 'Pause reading history',
        icon: CupertinoIcons.eyeglasses,
        type: SettingType.switchSetting,
        preference: ref.watch(morePreferencesProvider).incognitoMode,
      ),
      SearchableSettingItem.divider(),
      SearchableSettingItem(
        label: 'Download Queue',
        icon: Symbols.download,
        type: SettingType.linkSetting,
        route: '/settings/downloads/download-queue',
      ),
      SearchableSettingItem(
        label: 'Categories',
        icon: Symbols.label,
        type: SettingType.linkSetting,
        route: '/settings/library/categories',
      ),
      SearchableSettingItem(
        label: 'Statistics',
        icon: Symbols.query_stats,
        type: SettingType.linkSetting,
        route: '/statistics',
      ),
      SearchableSettingItem(
        label: 'Data & Storage',
        icon: Symbols.storage,
        type: SettingType.linkSetting,
        route: '/settings/data-storage',
      ),
      SearchableSettingItem.divider(),
      SearchableSettingItem(
        label: 'Settings',
        icon: Symbols.settings,
        type: SettingType.linkSetting,
        route: '/settings',
      ),
      SearchableSettingItem(
        label: 'About',
        icon: Symbols.info,
        type: SettingType.linkSetting,
        route: '/about',
      ),
      SearchableSettingItem(
        label: 'Help',
        icon: Symbols.help,
        type: SettingType.linkSetting,
        route: '/help',
      ),
    ];

    return ListView(
      children:
          moreSettings.map((setting) => setting.buildWidget(context)).toList(),
    );
  }
}
