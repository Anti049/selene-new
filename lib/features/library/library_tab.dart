import 'package:animated_visibility/animated_visibility.dart';
import 'package:auto_route/auto_route.dart';
import 'package:draggable_menu/draggable_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:selene/common/widgets/empty.dart';
import 'package:selene/common/widgets/intent_frame.dart';
import 'package:selene/common/widgets/padded_app_bar.dart';
import 'package:selene/core/constants/animation_constants.dart';
import 'package:selene/core/database/models/work.dart';
import 'package:selene/core/database/providers/library_providers.dart';
import 'package:selene/core/utils/theming.dart';
import 'package:selene/features/banners/models/providers/banner_state_provider.dart';
import 'package:selene/features/library/models/library_state.dart';
import 'package:selene/features/library/presentation/screens/display_options_tab.dart';
import 'package:selene/features/library/presentation/screens/filter_options_tab.dart';
import 'package:selene/features/library/presentation/screens/sort_options_tab.dart';
import 'package:selene/features/library/presentation/screens/tag_options_tab.dart';
import 'package:selene/features/library/providers/library_preferences.dart';
import 'package:selene/features/library/providers/library_state_provider.dart';

@RoutePage()
class LibraryTab extends ConsumerStatefulWidget {
  const LibraryTab({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LibraryTabState();
}

class _LibraryTabState extends ConsumerState<LibraryTab>
    with SingleTickerProviderStateMixin {
  final GlobalKey<RefreshIndicatorState> _refreshKey =
      GlobalKey<RefreshIndicatorState>();
  late final TabController _tabController = TabController(
    length: 3,
    vsync: this,
  );
  final DraggableMenuController _draggableMenuController =
      DraggableMenuController();

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    // Get providers
    final libraryPrefs = ref.watch(libraryPreferencesProvider);
    final libraryState = ref.watch(libraryStateProvider);
    final libraryNotifier = ref.watch(libraryStateProvider.notifier);
    final isTopBannerVisible = ref.watch(isTopBannerAreaCoveredProvider);

    // Compute data
    final isSearchActive = libraryState.maybeWhen(
      data: (libraryState) => libraryState.isSearchActive,
      orElse: () => false,
    );
    final isSelectionActive = libraryState.maybeWhen(
      data: (libraryState) => libraryState.isSelectionActive,
      orElse: () => false,
    );
    final selectedCount = libraryState.maybeWhen(
      data: (libraryState) => libraryState.selectedItems.length,
      orElse: () => 0,
    );
    final itemCount = libraryState.maybeWhen(
      data: (libraryState) => libraryState.items.length,
      orElse: () => 0,
    );
    final showCategoryTabs = libraryPrefs.showCategoryTabs.value;
    final showWorkCount = libraryPrefs.showWorkCount.value;

    // Return widget
    return PaddedAppBar(
      primary: !isTopBannerVisible,
      elevated: isSelectionActive || isSearchActive,
      title:
          isSearchActive
              ? TextField(
                autofocus: true,
                decoration: InputDecoration(
                  hintText: 'Search...',
                  border: InputBorder.none,
                ),
                onChanged: (value) {
                  libraryNotifier.updateSearchQuery(value);
                },
              )
              : isSelectionActive
              ? Text(selectedCount.toString())
              : Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                spacing: 16.0,
                children: [
                  Text('Library'),
                  if (showWorkCount)
                    Chip(
                      label: Text(itemCount.toString()),
                      labelPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                      visualDensity: VisualDensity.compact,
                    ),
                ],
              ),
      actions:
          isSelectionActive
              ? [
                // Select All
                IconButton(
                  icon: const Icon(Symbols.select_all),
                  onPressed: () {
                    libraryNotifier.selectAll();
                  },
                ),
                // Invert Selection
                IconButton(
                  icon: const Icon(Symbols.flip_to_back),
                  onPressed: () {
                    libraryNotifier.invertSelection();
                  },
                ),
              ]
              : [
                if (!isSearchActive)
                  IconButton(
                    icon: const Icon(Symbols.search),
                    onPressed: () {
                      libraryNotifier.startSearching();
                    },
                  ),
                IconButton(
                  icon: Badge(
                    label: Text(libraryPrefs.numOptionsActive.toString()),
                    isLabelVisible: libraryPrefs.anyOptionsActive,
                    child: Icon(
                      Symbols.filter_alt,
                      color:
                          libraryPrefs.anyOptionsActive
                              ? context.scheme.primary
                              : null,
                      fill: libraryPrefs.anyOptionsActive ? 1.0 : 0.0,
                    ),
                  ),
                  onPressed: () {
                    _showOptionsSheet(context);
                  },
                ),
                const SizedBox(),
                IconButton(
                  icon: const Icon(Symbols.refresh),
                  onPressed: () {
                    _refreshKey.currentState?.show();
                  },
                  tooltip: 'Update Library',
                ),
                IconButton(
                  icon: const Icon(Symbols.refresh),
                  onPressed: () {},
                  tooltip: 'Update Categories',
                ),
                IconButton(
                  icon: const Icon(Symbols.shuffle),
                  onPressed: () {},
                  tooltip: 'Open Random Work',
                ),
                const Divider(),
                IconButton(
                  icon: const Icon(Symbols.settings),
                  onPressed: () {},
                  tooltip: 'Library Settings',
                ),
              ],
      leading:
          isSearchActive || isSelectionActive
              ? IconButton(
                icon: const Icon(Symbols.close),
                onPressed: () {
                  if (isSearchActive) {
                    libraryNotifier.stopSearching();
                  } else if (isSelectionActive) {
                    libraryNotifier.clearSelection();
                  }
                },
              )
              : null,
      bottom:
          showCategoryTabs
              ? TabBar(
                controller: _tabController,
                tabs: [
                  Tab(text: 'All'),
                  Tab(text: 'Reading'),
                  Tab(text: 'Completed'),
                ],
              )
              : null,
    );
  }

  Widget _buildContent(BuildContext context, LibraryStateModel libraryState) {
    return IntentFrame(
      onRefresh: _onRefresh,
      refreshKey: _refreshKey,
      child: Empty(
        message: 'Library Not Implemented',
        subtitle:
            '${libraryState.workCount} Work${libraryState.workCount != 1 ? 's' : ''} Found',
      ),
    );
  }

  Widget _buildSelectionToolbar(BuildContext context) {
    // Get providers
    final libraryState = ref.watch(libraryStateProvider);
    final worksRepository = ref.watch(worksRepositoryProvider);

    // Return widget
    return AnimatedVisibility(
      visible: libraryState.maybeWhen(
        data: (data) => data.isSearchActive,
        orElse: () => false,
      ),
      enter: slideInVertically(curve: kAnimationCurve),
      enterDuration: kAnimationDuration,
      exit: slideOutVertically(curve: kAnimationCurve),
      exitDuration: kAnimationDuration,
      child: BottomAppBar(
        color: context.scheme.surfaceContainerLow,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: const Icon(Symbols.label),
              tooltip: 'Set Category',
              onPressed: () {
                // Handle Set Category action
              },
            ),
            IconButton(
              icon: const Icon(Symbols.done_all),
              tooltip: 'Mark as Read',
              onPressed: () {
                // Handle Mark as Read action
              },
            ),
            IconButton(
              icon: const Icon(Symbols.remove_done),
              tooltip: 'Mark as Unread',
              onPressed: () {
                // Handle Mark as Unread action
              },
            ),
            IconButton(
              icon: const Icon(Symbols.download),
              tooltip: 'Download',
              onPressed: () {
                // Handle Download action
              },
            ),
            IconButton(
              icon: const Icon(Symbols.delete),
              tooltip: 'Delete',
              onPressed: () async {
                final selectedWorks =
                    libraryState.maybeWhen(
                          data:
                              (data) =>
                                  data.selectedItems
                                      .map((e) => e.itemID)
                                      .toList(),
                          orElse: () => [],
                        )
                        as List<int>;
                for (final workID in selectedWorks) {
                  await worksRepository.deleteWorkById(workID);
                }
                // _refreshKey.currentState?.show();
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showOptionsSheet(BuildContext context) {
    DraggableMenu.open(
      context,
      DraggableMenu(
        curve: kAnimationCurve,
        animationDuration: kAnimationDuration,
        controller: _draggableMenuController,
        ui: ClassicDraggableMenu(color: context.scheme.surfaceContainer),
        levels: [
          DraggableMenuLevel.ratio(ratio: 0.6),
          DraggableMenuLevel.ratio(ratio: 1.0),
        ],
        child: DefaultTabController(
          length: 4,
          child: Column(
            children: [
              TabBar(
                tabs: [
                  Tab(text: 'Filter'),
                  Tab(text: 'Sort'),
                  Tab(text: 'Display'),
                  Tab(text: 'Tags'),
                ],
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    FilterOptionsTab(),
                    SortOptionsTab(),
                    DisplayOptionsTab(),
                    TagOptionsTab(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _onRefresh() async {
    final libraryNotifier = ref.read(libraryStateProvider.notifier);
    await libraryNotifier.refresh();
  }

  @override
  Widget build(BuildContext context) {
    // Get providers
    final libraryState = ref.watch(libraryStateProvider);
    final libraryNotifier = ref.watch(libraryStateProvider.notifier);
    final bool isTopBannerVisible = ref.watch(isTopBannerAreaCoveredProvider);

    // Compute data
    final isSearchActive = libraryState.maybeWhen(
      data: (libraryState) => libraryState.isSearchActive,
      orElse: () => false,
    );
    final isSelectionActive = libraryState.maybeWhen(
      data: (libraryState) => libraryState.isSelectionActive,
      orElse: () => false,
    );

    return PopScope(
      canPop: !isSearchActive && !isSelectionActive,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          if (isSearchActive) {
            libraryNotifier.stopSearching();
          } else if (isSelectionActive) {
            libraryNotifier.clearSelection();
          }
        }
      },
      child: Scaffold(
        primary: !isTopBannerVisible,
        appBar: _buildAppBar(context),
        body: libraryState.when(
          loading: () => Empty(message: 'Loading...'),
          error:
              (error, stackTrace) => IntentFrame(
                onRefresh: _onRefresh,
                refreshKey: _refreshKey,
                child: Empty(
                  message: 'An error occurred!',
                  subtitle: error.toString(),
                ),
              ),
          data: (libraryState) {
            // Check if library is empty
            if (libraryState.items.isEmpty) {
              return IntentFrame(
                onRefresh: _onRefresh,
                refreshKey: _refreshKey,
                child: Empty(message: 'No Works Found'),
              );
            }
            return _buildContent(context, libraryState);
          },
        ),
        floatingActionButton: Column(
          spacing: 8.0,
          mainAxisSize: MainAxisSize.min,
          children: [
            FloatingActionButton(
              child: const Icon(Symbols.add),
              onPressed: () async {
                // TODO: Implement adding a work from either a file or a URL
                // For now, just generate a random work
                final work = WorkModel.generateRandomWork();
                // Add the work to the library
                final worksRepository = ref.read(worksRepositoryProvider);
                await worksRepository.upsertWork(work);
              },
            ),
          ],
        ),
        bottomNavigationBar: _buildSelectionToolbar(context),
      ),
    );
  }
}
