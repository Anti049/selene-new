// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i7;
import 'package:selene/features/browse/browse_tab.dart' as _i1;
import 'package:selene/features/history/history_tab.dart' as _i2;
import 'package:selene/features/library/library_tab.dart' as _i3;
import 'package:selene/features/more/more_tab.dart' as _i5;
import 'package:selene/features/shell/main_shell.dart' as _i4;
import 'package:selene/features/updates/updates_tab.dart' as _i6;

/// generated route for
/// [_i1.BrowseTab]
class BrowseRoute extends _i7.PageRouteInfo<void> {
  const BrowseRoute({List<_i7.PageRouteInfo>? children})
      : super(
          BrowseRoute.name,
          initialChildren: children,
        );

  static const String name = 'BrowseRoute';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      return const _i1.BrowseTab();
    },
  );
}

/// generated route for
/// [_i2.HistoryTab]
class HistoryRoute extends _i7.PageRouteInfo<void> {
  const HistoryRoute({List<_i7.PageRouteInfo>? children})
      : super(
          HistoryRoute.name,
          initialChildren: children,
        );

  static const String name = 'HistoryRoute';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      return const _i2.HistoryTab();
    },
  );
}

/// generated route for
/// [_i3.LibraryTab]
class LibraryRoute extends _i7.PageRouteInfo<void> {
  const LibraryRoute({List<_i7.PageRouteInfo>? children})
      : super(
          LibraryRoute.name,
          initialChildren: children,
        );

  static const String name = 'LibraryRoute';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      return const _i3.LibraryTab();
    },
  );
}

/// generated route for
/// [_i4.MainScreen]
class MainRoute extends _i7.PageRouteInfo<void> {
  const MainRoute({List<_i7.PageRouteInfo>? children})
      : super(
          MainRoute.name,
          initialChildren: children,
        );

  static const String name = 'MainRoute';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      return const _i4.MainScreen();
    },
  );
}

/// generated route for
/// [_i5.MoreTab]
class MoreRoute extends _i7.PageRouteInfo<void> {
  const MoreRoute({List<_i7.PageRouteInfo>? children})
      : super(
          MoreRoute.name,
          initialChildren: children,
        );

  static const String name = 'MoreRoute';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      return const _i5.MoreTab();
    },
  );
}

/// generated route for
/// [_i6.UpdatesTab]
class UpdatesRoute extends _i7.PageRouteInfo<void> {
  const UpdatesRoute({List<_i7.PageRouteInfo>? children})
      : super(
          UpdatesRoute.name,
          initialChildren: children,
        );

  static const String name = 'UpdatesRoute';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      return const _i6.UpdatesTab();
    },
  );
}
