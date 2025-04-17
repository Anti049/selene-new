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
import 'package:selene/core/database/models/preference.dart';
import 'package:selene/core/database/models/work.dart';
import 'package:selene/core/database/providers/library_providers.dart';
import 'package:selene/core/utils/enums.dart';
import 'package:selene/core/utils/theming.dart';
import 'package:selene/features/banners/models/providers/banner_state_provider.dart';
import 'package:selene/features/library/models/library_item.dart';
import 'package:selene/features/library/models/library_state.dart';
import 'package:selene/features/library/presentation/screens/display_options_tab.dart';
import 'package:selene/features/library/presentation/screens/filter_options_tab.dart';
import 'package:selene/features/library/presentation/screens/sort_options_tab.dart';
import 'package:selene/features/library/presentation/screens/tag_options_tab.dart';
import 'package:selene/features/library/presentation/widgets/library_component_item.dart';
import 'package:selene/features/library/providers/library_preferences.dart';
import 'package:selene/features/library/providers/library_state_provider.dart';
import 'package:selene/routing/router.gr.dart';

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
  final _scrollController = ScrollController();
  final DraggableMenuController _draggableMenuController =
      DraggableMenuController();

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    // Get providers
    final showCategoryTabs = ref.watch(
      libraryPreferencesProvider.select(
        (prefs) => prefs.showCategoryTabs.get(),
      ),
    );
    final showWorkCount = ref.watch(
      libraryPreferencesProvider.select((prefs) => prefs.showWorkCount.get()),
    );
    final numOptionsActive = ref.watch(
      libraryPreferencesProvider.select((prefs) => prefs.numOptionsActive),
    );
    final libraryState = ref.watch(libraryStateProvider);
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
                  ref
                      .read(libraryStateProvider.notifier)
                      .updateSearchQuery(value);
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
                    ref.read(libraryStateProvider.notifier).selectAll();
                  },
                ),
                // Invert Selection
                IconButton(
                  icon: const Icon(Symbols.flip_to_back),
                  onPressed: () {
                    ref.read(libraryStateProvider.notifier).invertSelection();
                  },
                ),
              ]
              : [
                if (!isSearchActive)
                  IconButton(
                    icon: const Icon(Symbols.search),
                    onPressed: () {
                      ref.read(libraryStateProvider.notifier).startSearching();
                    },
                  ),
                IconButton(
                  icon: Badge(
                    label: Text(numOptionsActive.toString()),
                    isLabelVisible: numOptionsActive > 0,
                    child: Icon(
                      Symbols.filter_alt,
                      color:
                          numOptionsActive > 0 ? context.scheme.primary : null,
                      fill: numOptionsActive > 0 ? 1.0 : 0.0,
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
                    ref.read(libraryStateProvider.notifier).refresh();
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
                  final libraryNotifier = ref.read(
                    libraryStateProvider.notifier,
                  );
                  if (isSearchActive) {
                    libraryNotifier.stopSearching();
                  } else if (isSelectionActive) {
                    libraryNotifier.clearSelection();
                  }
                },
              )
              : null,
      bottom: showCategoryTabs ? _buildCategoryTabs(context) : null,
    );
  }

  PreferredSizeWidget _buildCategoryTabs(BuildContext context) {
    return TabBar(
      controller: _tabController,
      tabs: [Tab(text: 'All'), Tab(text: 'Reading'), Tab(text: 'Completed')],
    );
  }

  Widget _buildContent(BuildContext context, LibraryStateModel libraryState) {
    // Get providers
    final displayMode = ref.watch(
      libraryPreferencesProvider.select((prefs) => prefs.displayMode.get()),
    );

    return RawScrollbar(
      controller: _scrollController,
      interactive: true,
      thickness: 8.0,
      radius: const Radius.circular(4.0),
      trackVisibility: true,
      padding: const EdgeInsets.only(bottom: 80.0, top: 4.0, right: 4.0),
      thumbColor: context.scheme.primary,
      child: switch (displayMode) {
        DisplayMode.widgetList => _buildComponentListContent(
          context,
          libraryState,
        ),
        _ => IntentFrame(
          onRefresh: () => ref.read(libraryStateProvider.notifier).refresh(),
          refreshKey: _refreshKey,
          child: Empty(
            message: '${displayMode.label} Not Implemented',
            subtitle:
                '${libraryState.workCount} Work${libraryState.workCount != 1 ? 's' : ''} Found',
          ),
        ),
      },
    );
  }

  Widget _buildComponentListContent(
    BuildContext context,
    LibraryStateModel libraryState,
  ) {
    // Get providers
    final libraryNotifier = ref.watch(libraryStateProvider.notifier);

    // Return widget
    return RefreshIndicator(
      onRefresh: () => libraryNotifier.refresh(),
      key: _refreshKey,
      child: ListView(
        padding: EdgeInsets.symmetric(vertical: 4.0),
        controller: _scrollController,
        children: [
          for (final item in libraryState.items)
            LibraryComponentItem(
              work: item.work,
              isSelected: libraryState.isSelected(item),
              onTap: (workID) {
                if (libraryState.isSelectionActive) {
                  // Handle tap on work when selection is active
                  libraryNotifier.toggleSelection(item);
                } else {
                  // Handle normal tap on work
                  if (item.work.id != null) {
                    context.router.push(WorkDetailsRoute(work: item.work));
                  }
                }
              },
              onLongPress: (workID) {
                if (libraryState.isSelectionActive) {
                  // Start selection mode if not already active
                  libraryNotifier.toggleRangeSelection(item);
                } else {
                  // Toggle selection for the work
                  libraryNotifier.toggleSelection(item);
                }
              },
            ),
          // SizedBox for clearing the FAB area
          SizedBox(height: 80.0),
        ],
      ),
    );
  }

  Widget _buildSelectionToolbar(
    BuildContext context,
    List<LibraryItem> selectedItems,
  ) {
    // Get providers
    final worksRepository = ref.watch(worksRepositoryProvider);

    // Return widget
    return AnimatedVisibility(
      visible: selectedItems.isNotEmpty,
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
                    selectedItems.map((e) => e.itemID).toList();
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
    // Get providers
    final libraryPrefs = ref.read(libraryPreferencesProvider);
    // Open the draggable menu with options
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
              Row(
                children: [
                  Expanded(
                    child: TabBar(
                      dividerColor: Colors.transparent,
                      tabs: [
                        Tab(text: 'Filter'),
                        Tab(text: 'Sort'),
                        Tab(text: 'Display'),
                        Tab(text: 'Tags'),
                      ],
                    ),
                  ),
                  MenuAnchor(
                    alignmentOffset: const Offset(-100, 0),
                    builder: (context, controller, child) {
                      return IconButton(
                        icon: const Icon(Symbols.more_vert),
                        onPressed: () {
                          if (controller.isOpen) {
                            controller.close();
                          } else {
                            controller.open();
                          }
                        },
                      );
                    },
                    menuChildren: [
                      MenuItemButton(
                        child: Row(
                          spacing: 12.0,
                          children: [
                            const Icon(Symbols.filter_list),
                            const Text('Reset Filters'),
                          ],
                        ),
                        onPressed: () {
                          libraryPrefs.resetLibraryFilters();
                        },
                      ),
                      MenuItemButton(
                        child: Row(
                          spacing: 12.0,
                          children: [
                            const Icon(Symbols.swap_vert),
                            const Text('Reset Sort'),
                          ],
                        ),
                        onPressed: () {
                          libraryPrefs.resetLibrarySort();
                        },
                      ),
                      MenuItemButton(
                        child: Row(
                          spacing: 12.0,
                          children: [
                            const Icon(Symbols.browse),
                            const Text('Reset Display'),
                          ],
                        ),
                        onPressed: () {
                          libraryPrefs.resetLibraryDisplay();
                        },
                      ),
                      const Divider(height: 1.0),
                      MenuItemButton(
                        style: TextButton.styleFrom(
                          overlayColor: context.scheme.error.withValues(
                            alpha: 0.1,
                          ),
                          foregroundColor: context.scheme.error,
                        ),
                        child: const Text('Reset ALL Preferences'),
                        onPressed: () {
                          libraryPrefs.resetAllLibraryPreferences();
                        },
                      ),
                    ],
                  ),
                  const SizedBox(width: 4.0),
                ],
              ),
              const Divider(height: 1.0),
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

  Widget _buildFloatingActionButtons(
    BuildContext context,
    bool showContinueButton,
  ) {
    // Get prefs provider once
    final libraryPrefs = ref.read(libraryPreferencesProvider);
    final worksRepo = ref.read(worksRepositoryProvider); // Use read for actions

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end, // Align to end
      spacing: 8.0,
      children: [
        FloatingActionButton(
          heroTag: 'fab_continue_reading', // Unique HeroTag
          tooltip:
              'Toggle Continue Reading Button Visibility', // Example tooltip
          foregroundColor: context.scheme.onTertiaryContainer,
          backgroundColor: context.scheme.tertiaryContainer,
          splashColor: context.scheme.onTertiaryContainer.withValues(
            alpha: 0.1,
          ),
          onPressed: () {
            // Toggle the specific preference using read
            libraryPrefs.showWorkCount.toggle();
          },
          child: const Icon(Symbols.play_arrow),
        ),
        FloatingActionButton(
          heroTag: 'fab_cycle_display', // Unique HeroTag
          tooltip: 'Cycle Display Mode',
          foregroundColor: context.scheme.onSecondaryContainer,
          backgroundColor: context.scheme.secondaryContainer,
          splashColor: context.scheme.onSecondaryContainer.withValues(
            alpha: 0.1,
          ),
          onPressed: () {
            // Cycle display mode using read
            libraryPrefs.displayMode.cycle(DisplayMode.values);
          },
          child: const Icon(Symbols.view_list), // Changed icon example
        ),
        FloatingActionButton(
          heroTag: 'fab_add_work', // Unique HeroTag
          tooltip: 'Add Random Work',
          onPressed: () async {
            final work = WorkModel.generateRandomWork();
            await worksRepo.upsertWork(work);
            // Optionally trigger a refresh if needed, though the stream should update
            // ref.read(libraryStateProvider.notifier).refresh();
          },
          child: const Icon(Symbols.add),
        ),
      ],
    );
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
          final notifier = ref.read(libraryStateProvider.notifier);
          if (isSearchActive) {
            notifier.stopSearching();
          } else if (isSelectionActive) {
            notifier.clearSelection();
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
                onRefresh: () => libraryNotifier.refresh(),
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
                onRefresh: () => libraryNotifier.refresh(),
                refreshKey: _refreshKey,
                child: Empty(message: 'No Works Found'),
              );
            }
            return _buildContent(context, libraryState);
          },
        ),
        floatingActionButton: _buildFloatingActionButtons(
          context,
          ref.watch(
            libraryPreferencesProvider.select(
              (prefs) => prefs.showContinueReadingButton.get(),
            ),
          ),
        ),
        bottomNavigationBar: _buildSelectionToolbar(
          context,
          libraryState.maybeWhen(
            data: (libraryState) => libraryState.selectedItems,
            orElse: () => [],
          ),
        ),
      ),
    );
  }
}
