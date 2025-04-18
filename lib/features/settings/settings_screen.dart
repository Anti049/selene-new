import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:selene/core/utils/theming.dart';
import 'package:selene/features/banners/models/providers/banner_state_provider.dart';
import 'package:selene/features/settings/presentation/widgets/link_setting_widget.dart';
import 'package:selene/features/settings/providers/settings_providers.dart';

@RoutePage()
class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  late final SearchController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = SearchController();
    _searchController.addListener(_updateSearchQuery);
  }

  void _updateSearchQuery() {
    final query = ref.read(settingsSearchQueryProvider);
    final notifier = ref.read(settingsSearchQueryProvider.notifier);
    if (query != _searchController.text) {
      notifier.setQuery(_searchController.text);
    }
  }

  @override
  void dispose() {
    _searchController.removeListener(_updateSearchQuery);
    _searchController.dispose();
    super.dispose();
  }

  SearchAnchor _searchButton(BuildContext context) {
    return SearchAnchor(
      searchController: _searchController,
      isFullScreen: true,
      viewBackgroundColor: context.scheme.surfaceContainerLow,
      viewHintText: 'Search Settings',
      builder: (context, controller) {
        return IconButton(
          icon: const Icon(Symbols.search),
          tooltip: 'Search Settings',
          onPressed: () {
            controller.clear();
            controller.openView();
          },
        );
      },
      suggestionsBuilder: (context, controller) {
        final filteredSettings = ref.watch(filteredSettingsProvider);

        // Handle empty states
        if (controller.text.isEmpty) {
          // Optionally show history or suggestions even when empty
          return [
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Center(child: Text("Type to search settings")),
            ),
          ];
        }
        if (filteredSettings.isEmpty) {
          return [
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Center(
                child: Text("No results found for ${controller.text}"),
              ),
            ),
          ];
        }

        return filteredSettings.map((setting) {
          return ListTile(
            title: Text(setting.label),
            subtitle:
                setting.breadcrumbs.isNotEmpty
                    ? Text(setting.breadcrumbs.join(' > '))
                    : null,
            onTap: () {
              // 1. Hide keyboard (optional, but good UX)
              FocusScope.of(context).unfocus();

              // 2. Close the search view FIRST
              // Pass the selected label back to the anchor (optional)
              controller.clear();
              controller.closeView(setting.label);

              // 3. Navigate AFTER initiating the close
              // No need for addPostFrameCallback here, try direct navigation.
              if (setting.route != null) {
                // Ensure context is still valid before navigating
                if (context.mounted) {
                  // final settingID = setting.settingID;
                  // final paramRoute = '${setting.route!}?id=$settingID';
                  context.router.pushNamed(setting.route!);
                }
              }
            },
          );
        }).toList();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // Get providers
    final bool isTopBannerVisible = ref.watch(isTopBannerAreaCoveredProvider);

    // Build the settings screen
    return Scaffold(
      primary: !isTopBannerVisible,
      appBar: AppBar(
        primary: !isTopBannerVisible,
        title: const Text('Settings'),
        actions: [_searchButton(context)],
      ),
      body: ListView(
        children: [
          LinkSettingWidget(
            label: 'Appearance',
            subtitle: 'Theme, font, language, and more',
            icon: Symbols.palette,
            route: '/settings/appearance',
          ),
          LinkSettingWidget(
            label: 'Library',
            subtitle: 'Categories, global updates, chapter swipe',
            icon: Symbols.book,
            route: '/settings/library',
            enabled: false,
          ),
          LinkSettingWidget(
            label: 'Accounts',
            subtitle: 'Manage accounts, login/logout, and sync',
            icon: Symbols.group,
            route: '/settings/accounts',
            enabled: false,
          ),
          LinkSettingWidget(
            label: 'Reader',
            subtitle: 'Reader settings, page transitions, and more',
            icon: Symbols.chrome_reader_mode,
            route: '/settings/reader',
            enabled: false,
          ),
          LinkSettingWidget(
            label: 'Downloads',
            subtitle: 'Download settings, queue, history',
            icon: Symbols.file_download,
            route: '/settings/downloads',
            enabled: false,
          ),
          LinkSettingWidget(
            label: 'Tracking',
            subtitle: 'Tracking settings, history, statistics',
            icon: Symbols.sync,
            route: '/settings/tracking',
            enabled: false,
          ),
          LinkSettingWidget(
            label: 'Browse',
            subtitle: 'Browse settings, sources, extensions',
            icon: Symbols.explore,
            route: '/settings/browse',
            enabled: false,
          ),
          LinkSettingWidget(
            label: 'Notifications',
            subtitle: 'Notification settings, sounds, and more',
            icon: Symbols.notifications,
            route: '/settings/notifications',
            enabled: false,
          ),
          LinkSettingWidget(
            label: 'Data & Storage',
            subtitle: 'Manage data, storage, and cache settings',
            icon: Symbols.storage,
            route: '/settings/data-storage',
            enabled: false,
          ),
          LinkSettingWidget(
            label: 'Security & Privacy',
            subtitle: 'Security settings, incognito mode, and more',
            icon: Symbols.security,
            route: '/settings/security',
            enabled: false,
          ),
          LinkSettingWidget(
            label: 'Advanced',
            subtitle: 'Developer options, experimental features',
            icon: Symbols.developer_mode,
            route: '/settings/advanced',
            enabled: false,
          ),
          LinkSettingWidget(
            label: 'About',
            subtitle: 'Selene Stable 0.1.0',
            icon: Symbols.info,
            route: '/about',
            enabled: false,
          ),
        ],
      ),
    );
  }
}
