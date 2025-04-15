import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:selene/common/widgets/shell_page.dart';
import 'package:selene/routing/router.gr.dart';

@RoutePage()
class BrowseTab extends StatelessWidget {
  const BrowseTab({super.key});

  @override
  Widget build(BuildContext context) {
    final tabItems = [
      ShellPage(label: 'Sources', route: SourcesRoute()),
      ShellPage(label: 'Extensions', route: ExtensionsRoute()),
      ShellPage(label: 'Migrate', route: MigrateRoute()),
    ];

    return AutoTabsRouter.tabBar(
      routes: tabItems.map((item) => item.route).toList(),
      builder: (context, child, controller) {
        final router = AutoTabsRouter.of(context);

        return Scaffold(
          appBar: AppBar(
            title: Text('Browse'),
            actions: tabItems[router.activeIndex].actions,
            bottom: TabBar(
              controller: controller,
              tabs: tabItems.map((item) => item.tabDestination).toList(),
            ),
          ),
          body: child,
        );
      },
    );
  }
}
