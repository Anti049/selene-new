import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:selene/common/widgets/themed_logo.dart';
import 'package:selene/features/more/providers/more_preferences.dart';
import 'package:selene/features/settings/presentation/widgets/link_setting_widget.dart';
import 'package:selene/features/settings/presentation/widgets/switch_setting_widget.dart';

@RoutePage()
class MoreTab extends ConsumerWidget {
  const MoreTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 24.0),
              child: ThemedLogo(),
            ),
            const Divider(),
          ],
        ),
        SwitchSettingWidget(
          label: 'Downloaded Only',
          subtitle: 'Show only downloaded items',
          icon: Symbols.cloud_off,
          preference: ref.watch(morePreferencesProvider).downloadedOnlyMode,
        ),
        SwitchSettingWidget(
          label: 'Incognito Mode',
          subtitle: 'Pause reading history',
          icon: CupertinoIcons.eyeglasses,
          preference: ref.watch(morePreferencesProvider).incognitoMode,
        ),
        const Divider(),
        LinkSettingWidget(
          label: 'Download Queue',
          icon: Symbols.download,
          route: '/settings/downloads/download-queue',
          enabled: false,
        ),
        LinkSettingWidget(
          label: 'Categories',
          icon: Symbols.label,
          route: '/settings/library/categories',
          enabled: false,
        ),
        LinkSettingWidget(
          label: 'Statistics',
          icon: Symbols.query_stats,
          route: '/statistics',
          enabled: false,
        ),
        LinkSettingWidget(
          label: 'Data & Storage',
          icon: Symbols.storage,
          route: '/settings/data-storage',
          enabled: false,
        ),
        const Divider(),
        LinkSettingWidget(
          label: 'Settings',
          icon: Symbols.settings,
          route: '/settings',
        ),
        LinkSettingWidget(
          label: 'About',
          icon: Symbols.info,
          route: '/about',
          enabled: false,
        ),
        LinkSettingWidget(
          label: 'Help',
          icon: Symbols.help,
          route: '/help',
          enabled: false,
        ),
      ],
    );
  }
}
