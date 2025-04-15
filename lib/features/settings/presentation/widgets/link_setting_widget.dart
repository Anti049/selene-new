import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:selene/core/utils/theming.dart';
import 'package:selene/features/settings/models/searchable_setting_item.dart';

// Recursive helper function
bool doesRouteExist(Iterable<AutoRoute> routes, String? path) {
  for (final route in routes) {
    if (route.path == path) {
      return true;
    }
    if (route.children == null) return false;
    if (doesRouteExist(route.children!.routes, path)) {
      return true;
    }
  }
  return false;
}

class LinkSettingWidget extends StatelessWidget {
  const LinkSettingWidget({super.key, required this.setting});

  final SearchableSettingItem setting;

  @override
  Widget build(BuildContext context) {
    // Assert this setting is a link setting
    assert(setting.type == SettingType.linkSetting);
    assert(setting.route != null || setting.onTapAction != null);

    return ListTile(
      leading: Icon(setting.icon, color: context.scheme.primary),
      title: Text(setting.label),
      subtitle: setting.subtitle != null ? Text(setting.subtitle!) : null,
      onTap: () {
        if (setting.onTapAction != null) {
          setting.onTapAction!();
        } else {
          // Does route exist? Recursively check all routes
          // final routeExists = doesRouteExist(
          //   context.router.routeCollection.routes,
          //   setting.route,
          // );
          // if (!routeExists) {
          //   // If a snackbar is currently showing, dismiss it
          //   ScaffoldMessenger.of(context).clearSnackBars();
          //   // Show snackbar if route does not exist
          //   ScaffoldMessenger.of(context).showSnackBar(
          //     SnackBar(
          //       content: Text('Route "${setting.route}" does not exist.'),
          //       behavior: SnackBarBehavior.floating,
          //     ),
          //   );
          // } else {
          context.router.pushNamed(setting.route!);
          // }
        }
      },
      horizontalTitleGap: 24.0,
    );
  }
}
