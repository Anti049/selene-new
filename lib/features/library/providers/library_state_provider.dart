import 'dart:math';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:rxdart/rxdart.dart' hide DebounceExtensions;
import 'package:selene/core/database/mappers/work_mapper.dart';
import 'package:selene/core/database/models/work.dart';
import 'package:selene/core/database/providers/isar_provider.dart';
import 'package:selene/core/database/providers/library_providers.dart';
import 'package:selene/core/logging/logger_provider.dart';
import 'package:selene/core/utils/enums.dart';
import 'package:selene/features/library/models/library_item.dart';
import 'package:selene/features/library/models/library_item_preferences.dart';
import 'package:selene/features/library/models/library_state.dart';
import 'package:selene/features/library/providers/library_preferences.dart';
import 'package:selene/features/more/providers/more_preferences.dart';
import 'package:stream_transform/stream_transform.dart' hide Concatenate;

part 'library_state_provider.g.dart';

@riverpod
class LibraryState extends _$LibraryState {
  final _searchQueryController = BehaviorSubject<String?>.seeded(null);

  @override
  Stream<LibraryStateModel> build() {
    // Get providers
    final libraryPrefs = ref.watch(libraryPreferencesProvider);
    final logger = ref.read(loggerProvider); // Get logger

    ref.onDispose(() => _searchQueryController.close());

    return Rx.combineLatest3(
      _libraryItemsStream(),
      _preferencesStream(),
      _searchQueryController.stream.distinct().debounce(
        const Duration(milliseconds: 300),
      ),
      (libraryItems, preferences, searchQuery) {
        // --- Filtering Logic ---
        // Filter by search query
        final queriedLibraryItems =
            searchQuery != null && searchQuery.isNotEmpty
                ? libraryItems.where((item) {
                  final search = searchQuery.toLowerCase();
                  if (item.work.title.toLowerCase().contains(search)) {
                    return true;
                  }
                  if (item.work.authors.any(
                    (a) => a.name.toLowerCase().contains(search),
                  )) {
                    return true;
                  }
                  // Add other searchable fields (tags, series, etc.)
                  return false;
                }).toList()
                : libraryItems;

        // Filter by preferences (adapt your logic here)
        final filteredLibraryItems =
            queriedLibraryItems.where((item) {
              if (preferences.downloadedOnlyMode ==
                  true /* && !item.isDownloaded*/ ) {
                // return false;
              }
              // Example: Filter Unread (from Library Prefs)
              if (preferences.filterUnread ==
                  true /* && item.unreadCount <= 0*/ ) {
                // return false;
              }
              // Add other filters: filterDownloaded, filterFavorite, filterStarted, etc.
              return true;
            }).toList();
        // --- End Filtering Logic ---

        // Preserve selection state
        final currentSelectedItems = state.valueOrNull?.selectedItems ?? [];
        final validSelectedItems =
            currentSelectedItems
                .where(
                  (selected) => filteredLibraryItems.any(
                    (item) => item.itemID == selected.itemID,
                  ),
                )
                .toList();

        // Determine if any filters are active (including search)
        final hasActiveFilters =
            libraryPrefs.anyOptionsActive ||
            (searchQuery != null && searchQuery.isNotEmpty);

        return LibraryStateModel(
          items: filteredLibraryItems,
          searchQuery: searchQuery,
          selectedItems: validSelectedItems,
          showCategoryTabs: libraryPrefs.showCategoryTabs.value,
          showWorkCount: libraryPrefs.showWorkCount.value,
          showContinueReadingButton: preferences.showContinueReadingButton,
          hasActiveFilters: hasActiveFilters, // Updated filter status
        );
      },
    ).handleError((error, stackTrace) {
      // Add error handling for the combined stream
      logger.e(
        "Error in combined LibraryState stream: $error",
        stackTrace: stackTrace,
      );
      // Re-throw or return a default/error state model
      // For now, rethrowing might be okay if the UI handles AsyncError
      // throw error;
      // Or return a default state:
      return LibraryStateModel(
        items: [],
        searchQuery:
            _searchQueryController.valueOrNull, // Keep search query if possible
        selectedItems: [],
        // Use default preference values or fetch them synchronously if possible
        showCategoryTabs:
            ref.read(libraryPreferencesProvider).showCategoryTabs.value,
        showWorkCount: ref.read(libraryPreferencesProvider).showWorkCount.value,
        showContinueReadingButton:
            ref
                .read(libraryPreferencesProvider)
                .showContinueReadingButton
                .value,
        hasActiveFilters:
            ref.read(libraryPreferencesProvider).anyOptionsActive ||
            (_searchQueryController.valueOrNull?.isNotEmpty ?? false),
      );
    });
  }

  // Get library items stream by watching the repository
  Stream<List<LibraryItem>> _libraryItemsStream() {
    // Get preferences needed for sorting
    final libraryPrefs = ref.watch(libraryPreferencesProvider);
    final worksRepository = ref.watch(worksRepositoryProvider);
    // Watch Isar instance readiness
    final isarAsyncValue = ref.watch(isarProvider);
    final logger = ref.read(loggerProvider);

    // Get Isar instance when available
    final isar = isarAsyncValue.valueOrNull;
    if (isar == null) {
      // If Isar isn't ready, return an empty stream or handle loading state
      // The main build() method's combineLatest will wait anyway
      return Stream.value([]);
    }

    // Watch the works from the repository
    return worksRepository
        .watchAllWorksRaw()
        .asyncMap((worksTable) async {
          // Map DB objects to WorkModel
          List<WorkModel> workModels = [];
          try {
            // Use a read transaction for consistency during mapping
            workModels = await isar.txn(() async {
              return await Future.wait(
                worksTable.map(WorkMapper.mapToModel).toList(),
              );
            });
            // Alternative without explicit txn (if mapToModel is self-contained)
            // workModels = await Future.wait(worksTable.map(WorkMapper.mapToModel).toList());
          } catch (e, stack) {
            logger.e(
              "Error mapping WorksTable to WorkModel in stream: $e",
              stackTrace: stack,
            );
            return <LibraryItem>[]; // Return empty list on error
          }

          // --- Sorting Logic (on List<WorkModel>) ---
          final sortBy = libraryPrefs.sortBy.value;
          final sortOrder = libraryPrefs.sortOrder.value;
          final mutableWorks = List<WorkModel>.from(workModels);
          // (Sorting logic remains the same as your previous version)
          mutableWorks.sort((a, b) {
            switch (sortBy) {
              case SortBy.alphabetically:
                return a.title.compareTo(b.title);
              case SortBy.author:
                final authorsA = a.authors.map((e) => e.name).toList()..sort();
                final authorsB = b.authors.map((e) => e.name).toList()..sort();
                return authorsA.join(', ').compareTo(authorsB.join(', '));
              case SortBy.totalChapters:
                return a.chapters.length.compareTo(b.chapters.length);
              case SortBy.datePublished: // Typo fixed
                if (a.datePublished == null && b.datePublished == null) {
                  return 0;
                }
                if (a.datePublished == null) return 1; // Nulls last
                if (b.datePublished == null) return -1;
                return a.datePublished!.compareTo(b.datePublished!);
              case SortBy.lastUpdated:
                if (a.dateUpdated == null && b.dateUpdated == null) return 0;
                if (a.dateUpdated == null) return 1; // Nulls last
                if (b.dateUpdated == null) return -1;
                return a.dateUpdated!.compareTo(b.dateUpdated!);
              case SortBy.latestChapter:
                final lastChapterA =
                    a.chapters.isNotEmpty
                        ? a.chapters.last.datePublished
                        : null;
                final lastChapterB =
                    b.chapters.isNotEmpty
                        ? b.chapters.last.datePublished
                        : null;
                if (lastChapterA == null && lastChapterB == null) return 0;
                if (lastChapterA == null) return 1; // Nulls last
                if (lastChapterB == null) return -1;
                return lastChapterA.compareTo(lastChapterB);
              default:
                return 0;
            }
          });
          List<WorkModel> sortedWorks = mutableWorks;
          if (sortOrder == SortOrder.descending) {
            sortedWorks = sortedWorks.reversed.toList();
          }
          // --- End Sorting Logic ---

          // --- Mapping Logic (WorkModel -> LibraryItem) ---
          return sortedWorks
              .map((work) {
                final itemId = work.id;
                if (itemId == null) {
                  // This should ideally not happen after successful mapping
                  logger.e(
                    "Error: Mapped WorkModel has null ID: ${work.title}",
                  );
                  return null;
                }
                return LibraryItem(
                  itemID: itemId,
                  work: work, // work is now a fully mapped WorkModel
                  // TODO: Populate downloadCount, unreadCount etc. if needed
                  // These might require additional logic or data sources
                );
              })
              .whereType<LibraryItem>()
              .toList(); // Filter out potential nulls
          // --- End Mapping Logic ---
        })
        .handleError((error, stackTrace) {
          logger.e(
            "Error in _libraryItemsStream asyncMap: $error",
            stackTrace: stackTrace,
          );
          // Emit an empty list or rethrow, depending on desired error handling
          return <LibraryItem>[];
        });
  }

  // Get preferences stream
  Stream<LibraryItemPreferences> _preferencesStream() {
    // Get preferences
    final libraryPrefs = ref.watch(libraryPreferencesProvider);
    final morePrefs = ref.watch(morePreferencesProvider);

    // Combine streams
    return Rx.combineLatest(
      [
        libraryPrefs.showDownloadedCount.stream.startWith(
          libraryPrefs.showDownloadedCount.value,
        ), // 0
        libraryPrefs.showUnreadCount.stream.startWith(
          libraryPrefs.showUnreadCount.value,
        ), // 1
        libraryPrefs.showContinueReadingButton.stream.startWith(
          libraryPrefs.showContinueReadingButton.value,
        ), // 2
        libraryPrefs.showFavorite.stream.startWith(
          libraryPrefs.showFavorite.value,
        ), // 3
        libraryPrefs.filterDownloaded.stream.startWith(
          libraryPrefs.filterDownloaded.value,
        ), // 4
        libraryPrefs.filterUnread.stream.startWith(
          libraryPrefs.filterUnread.value,
        ), // 5
        libraryPrefs.filterFavorites.stream.startWith(
          libraryPrefs.filterFavorites.value,
        ), // 6
        libraryPrefs.filterStarted.stream.startWith(
          libraryPrefs.filterStarted.value,
        ), // 7
        libraryPrefs.filterCompleted.stream.startWith(
          libraryPrefs.filterCompleted.value,
        ), // 8
        libraryPrefs.filterUpdated.stream.startWith(
          libraryPrefs.filterUpdated.value,
        ), // 9
        morePrefs.downloadedOnlyMode.stream.startWith(
          morePrefs.downloadedOnlyMode.value,
        ), // 10
      ],
      (values) {
        return LibraryItemPreferences(
          showDownloadCount: values[0],
          showUnreadCount: values[1],
          showContinueReadingButton: values[2],
          showFavorite: values[3],
          filterDownloaded: values[4],
          filterUnread: values[5],
          filterFavorite: values[6],
          filterStarted: values[7],
          filterCompleted: values[8],
          filterUpdated: values[9],
          downloadedOnlyMode: values[10],
        );
      },
    );
  }

  // --- General Utilities ---
  // (Keep this helper from the previous good suggestion)
  void _updateState(
    LibraryStateModel Function(LibraryStateModel current) updater,
  ) {
    // Only update if the current state is data
    if (state is AsyncData<LibraryStateModel>) {
      final currentState = state.value!;
      final newState = updater(currentState);
      // Update the state with the new model wrapped in AsyncData
      state = AsyncData(newState);
    } else if (state is AsyncError) {
      // Optionally handle updates even if the last state was an error
      // Might need to create a new LibraryStateModel from scratch or defaults
      final logger = ref.read(loggerProvider);
      logger.w("Attempting to update state while in error state.");
      // Example: Create a default state and apply the update
      // final defaultState = LibraryStateModel(); // Create your default
      // final newState = updater(defaultState);
      // state = AsyncData(newState);
    }
  }

  Future<void> refresh() async {
    ref.invalidateSelf();
    await future;
  }

  // --- Search Utilities ---
  // Start searching
  void startSearching() async {
    _searchQueryController.add('');
  }

  // Stop searching
  void stopSearching() async {
    _searchQueryController.add(null);
  }

  // Update search query
  void updateSearchQuery(String query) async {
    _searchQueryController.add(query);
  }

  // --- Selection Utilities ---
  void clearSelection() async {
    _updateState((state) => state.copyWith(selectedItems: []));
  }

  void selectAll() async {
    _updateState((state) => state.copyWith(selectedItems: state.items));
  }

  void invertSelection() async {
    _updateState((current) {
      final currentSelectionIds =
          current.selectedItems.map((e) => e.itemID).toSet();
      final invertedSelection =
          current.items
              .where((item) => !currentSelectionIds.contains(item.itemID))
              .toList();
      return current.copyWith(selectedItems: invertedSelection);
    });
  }

  void toggleSelection(LibraryItem item) async {
    _updateState((current) {
      final currentSelection = current.selectedItems;
      final isSelected = currentSelection.any((i) => i.itemID == item.itemID);
      final newSelection =
          isSelected
              ? currentSelection.where((i) => i.itemID != item.itemID).toList()
              : [...currentSelection, item];
      return current.copyWith(selectedItems: newSelection);
    });
  }

  /// Selects all works between and including the given work and the last pressed work
  void toggleRangeSelection(LibraryItem item) async {
    _updateState((current) {
      final items = current.items;
      final selectedItems = List<LibraryItem>.from(current.selectedItems);
      final lastSelected = selectedItems.isNotEmpty ? selectedItems.last : null;

      final currentIndex = items.indexWhere((i) => i.itemID == item.itemID);
      final lastIndex =
          lastSelected != null
              ? items.indexWhere((i) => i.itemID == lastSelected.itemID)
              : currentIndex;

      if (currentIndex == -1) return current; // Item not found

      final start = min(currentIndex, lastIndex);
      final end = max(currentIndex, lastIndex);

      final Set<int> currentSelectionIds =
          selectedItems.map((e) => e.itemID).toSet();
      final List<LibraryItem> itemsToAdd = [];

      for (int i = start; i <= end; i++) {
        // Check bounds and if not already selected
        if (i >= 0 &&
            i < items.length &&
            !currentSelectionIds.contains(items[i].itemID)) {
          itemsToAdd.add(items[i]);
        }
      }
      // Only update if there are items to add to avoid unnecessary rebuilds
      if (itemsToAdd.isNotEmpty) {
        return current.copyWith(
          selectedItems: [...selectedItems, ...itemsToAdd],
        );
      } else {
        // If the tapped item was already selected and no range was added,
        // maybe just toggle the single item? Or do nothing.
        // For now, just return current state if no new items added.
        return current;
      }
    });
  }
}
