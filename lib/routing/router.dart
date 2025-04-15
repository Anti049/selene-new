import 'package:auto_route/auto_route.dart';
import 'package:selene/routing/router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Shell|Screen|Page|Tab,Route')
class AppRouter extends RootStackRouter {
  @override
  RouteType get defaultRouteType => const RouteType.material();

  @override
  List<AutoRoute> get routes => [
    // Main shell route
    AutoRoute(
      initial: true,
      path: '/',
      page: MainRoute.page,
      children: [
        AutoRoute(
          path: 'library',
          page: LibraryRoute.page,
          children: [
            AutoRoute(path: 'filter', page: FilterOptionsRoute.page),
            AutoRoute(path: 'sort', page: SortOptionsRoute.page),
            AutoRoute(path: 'display', page: DisplayOptionsRoute.page),
            AutoRoute(path: 'tag', page: TagOptionsRoute.page),
          ],
        ),
        AutoRoute(path: 'updates', page: UpdatesRoute.page),
        AutoRoute(path: 'history', page: HistoryRoute.page),
        AutoRoute(
          path: 'browse',
          page: BrowseRoute.page,
          children: [
            AutoRoute(path: 'sources', page: SourcesRoute.page),
            AutoRoute(path: 'extensions', page: ExtensionsRoute.page),
            AutoRoute(path: 'migrate', page: MigrateRoute.page),
          ],
        ),
        AutoRoute(path: 'more', page: MoreRoute.page),
      ],
    ),
    AutoRoute(path: '/settings', page: SettingsRoute.page),
    AutoRoute(path: '/settings/appearance', page: AppearanceRoute.page),
  ];
}
