import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:selene/core/utils/theming.dart';
import 'package:selene/features/shell/domain/models/shell_page.dart';
import 'package:selene/routing/router.gr.dart';

@RoutePage()
class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const navigationItems = [
      ShellPage(
        label: 'Library',
        route: LibraryRoute(),
        icon: Symbols.collections_bookmark,
      ),
      ShellPage(
        label: 'Updates',
        route: UpdatesRoute(),
        icon: Symbols.release_alert,
      ),
      ShellPage(label: 'History', route: HistoryRoute(), icon: Symbols.history),
      ShellPage(label: 'Browse', route: BrowseRoute(), icon: Symbols.explore),
      ShellPage(label: 'More', route: MoreRoute(), icon: Symbols.more_horiz),
    ];

    return AutoTabsRouter(
      routes: navigationItems.map((item) => item.route).toList(),
      builder: (context, child) {
        final router = AutoTabsRouter.of(context);

        return Scaffold(
          body: child,
          bottomNavigationBar: NavigationBar(
            backgroundColor:
                context.theme.bottomNavigationBarTheme.backgroundColor,
            selectedIndex: router.activeIndex,
            onDestinationSelected: router.setActiveIndex,
            destinations: [
              ...navigationItems.map((item) => item.barDestination),
            ],
          ),
        );
      },
    );
  }
}
