import 'package:auto_route/auto_route.dart';
import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:selene/common/widgets/padded_app_bar.dart';
import 'package:selene/core/utils/theming.dart';
import 'package:selene/features/download_queue/providers/download_queue_provider.dart';

@RoutePage()
class DownloadQueueScreen extends ConsumerWidget {
  DownloadQueueScreen({super.key});

  final menuController = MenuController();
  final uploadDateMenuController = MenuController();
  final chapterTitleMenuController = MenuController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final downloadNotifier = ref.watch(downloadQueueProvider.notifier);
    final downloadQueue = ref.watch(downloadQueueProvider);
    final activeTask = downloadNotifier.getActiveTask();
    return Scaffold(
      appBar: PaddedAppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 8.0,
          children: [
            Flexible(
              child: const Text(
                'Download Queue',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Chip(
              label: Text(downloadQueue.queue.length.toString()),
              labelPadding: const EdgeInsets.symmetric(horizontal: 4.0),
              visualDensity: VisualDensity.compact,
            ),
          ],
        ),
        actions: [
          MenuAnchor(
            controller: menuController,
            menuChildren: [
              // By Upload Date
              SubmenuButton(
                menuChildren: [
                  MenuItemButton(
                    onPressed: () {},
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text('Newest'),
                    ),
                  ),
                  MenuItemButton(
                    onPressed: () {},
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text('Oldest'),
                    ),
                  ),
                ],
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text('Sort by Upload Date'),
                ),
              ),
              // By Chapter Title
              SubmenuButton(
                menuChildren: [
                  MenuItemButton(
                    onPressed: () {},
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text('Ascending'),
                    ),
                  ),
                  MenuItemButton(
                    onPressed: () {},
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text('Descending'),
                    ),
                  ),
                ],
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text('Sort by Chapter Title'),
                ),
              ),
              const Divider(height: 1.0, thickness: 1.0),
              MenuItemButton(
                onPressed: () {
                  // Handle clear queue action
                  // ref.read(downloadQueueProvider.notifier).clearQueue();
                },
                style: MenuItemButton.styleFrom(
                  foregroundColor: context.scheme.error,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text('Clear Queue'),
                ),
              ),
            ],
            child: IconButton(
              icon: Icon(Symbols.more_vert),
              onPressed: () {
                menuController.open();
              },
            ),
          ),
          // IconButton(
          //   icon: Icon(Symbols.close),
          //   onPressed: () {
          //     // Handle close action
          //     // Navigator.of(context).pop();
          //   },
          //   tooltip: 'Cancel All Downloads',
          // ),
        ],
      ),
      body: ReorderableListView(
        children: [
          if (activeTask != null)
            ListTile(
              key: ValueKey(activeTask.taskId),
              title: Text(activeTask.workTitle),
              subtitle: Text(activeTask.chapterTitle),
              isThreeLine: true,
              trailing: IconButton(
                icon: const Icon(Symbols.cancel),
                onPressed: () {
                  // Handle cancel action
                  // ref.read(downloadQueueProvider.notifier).cancelActiveTask();
                },
              ),
            ),
          for (final task in downloadQueue.queue)
            ListTile(
              key: ValueKey(task.taskId),
              title: Text(task.workTitle),
              subtitle: Text(task.chapterTitle),
              isThreeLine: true,
              trailing: IconButton(
                icon: const Icon(Symbols.cancel),
                onPressed: () {
                  // Handle cancel action
                  // ref.read(downloadQueueProvider.notifier).cancelTask(task.taskId);
                },
              ),
            ),
        ],
        onReorder: (oldIndex, newIndex) {
          // Handle reordering logic here
          // if (newIndex > oldIndex) newIndex--;
          // final item = downloadQueue.queue.removeAt(oldIndex);
          // downloadQueue.queue.insert(newIndex, item);
          // ref.read(downloadQueueProvider.notifier).updateQueue(downloadQueue.queue);
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Handle pause/resume action
          ref.read(downloadQueueProvider.notifier).toggleProcessing();
        },
        icon: Icon(
          downloadQueue.isProcessing ? Symbols.pause : Symbols.play_arrow,
          fill: 1.0,
        ),
        label: Text(downloadQueue.isProcessing ? 'Pause' : 'Resume'),
      ),
    );
  }
}
