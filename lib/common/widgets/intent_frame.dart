import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Intents
class RefreshFrameIntent extends Intent {
  const RefreshFrameIntent() : super();
}

class EscapeFrameIntent extends Intent {
  const EscapeFrameIntent() : super();
}

class IntentFrame extends StatelessWidget {
  const IntentFrame({
    super.key,
    this.onRefresh,
    this.refreshKey,
    this.onEscape,
    required this.child,
  });

  final Future<void> Function()? onRefresh;
  final GlobalKey<RefreshIndicatorState>? refreshKey;
  final VoidCallback? onEscape;
  final Widget child;

  bool get refreshEnabled => onRefresh != null && refreshKey != null;

  @override
  Widget build(BuildContext context) {
    final scrollableTypes = [
      ScrollView,
      ListView,
      GridView,
      CustomScrollView,
      PageView,
      Scrollbar,
    ];
    final childType = child.runtimeType.toString();
    final isChildScrollable =
        child is Scrollable ||
        scrollableTypes.any((type) => childType.contains(type.toString()));

    return LayoutBuilder(
      builder: (context, constraints) {
        return Actions(
          actions: {
            RefreshFrameIntent: CallbackAction<RefreshFrameIntent>(
              onInvoke: (intent) async {
                if (!refreshEnabled) {
                  return null;
                }
                refreshKey?.currentState?.show();
                await onRefresh!();
                return null;
              },
            ),
            EscapeFrameIntent: CallbackAction<EscapeFrameIntent>(
              onInvoke: (intent) {
                onEscape?.call();
                return null;
              },
            ),
          },
          child: Shortcuts(
            shortcuts: {
              SingleActivator(LogicalKeyboardKey.escape):
                  const EscapeFrameIntent(),
              SingleActivator(LogicalKeyboardKey.f5):
                  const RefreshFrameIntent(),
            },
            child: RefreshIndicator(
              key: refreshKey ?? GlobalKey<RefreshIndicatorState>(),
              notificationPredicate: (_) => onRefresh != null,
              onRefresh: () async => onRefresh?.call(),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                  minWidth: constraints.maxWidth,
                ),
                child:
                    false // isChildScrollable
                        ? child // TODO: Handle scrollable types properly, e.g. ListView, GridView etc.
                        : SingleChildScrollView(
                          physics: const AlwaysScrollableScrollPhysics(),
                          child: ConstrainedBox(
                            constraints: BoxConstraints(
                              minHeight: constraints.maxHeight,
                              minWidth: constraints.maxWidth,
                            ),
                            child: child,
                          ),
                        ),
              ),
            ),
          ),
        );
      },
    );
  }
}
