import 'dart:math';

import 'package:dartx/dartx.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:rxdart/rxdart.dart';
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

part 'library_state_provider.g.dart';

@Riverpod(keepAlive: true)
class LibraryState extends _$LibraryState {
  @override
  Stream<LibraryStateModel> build() {
    // Get providers
    final sortBy = ref.watch(
      libraryPreferencesProvider.select((prefs) => prefs.sortBy.get()),
    );
    final sortOrder = ref.watch(
      libraryPreferencesProvider.select((prefs) => prefs.sortOrder.get()),
    );

    return Rx.combineLatestList([
      _libraryItemsStream(sortBy, sortOrder),
      _preferencesStream(),
      _searchQueryStream().distinct().debounceTime(
        const Duration(milliseconds: 300),
      ),
    ]).asyncMap((data) async {
      final libraryItems = data[0] as List<LibraryItem>;
      final filterPrefs = data[1] as LibraryItemPreferences;
      final searchQuery = data[2] as String?;
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
            if (filterPrefs.downloadedOnlyMode ==
                true /* && !item.isDownloaded*/ ) {
              // return false;
            }
            // Example: Filter Unread (from Library Prefs)
            if (filterPrefs.filterUnread ==
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

      final hasActiveFilters = filterPrefs.hasActiveFilters;
      final hasActiveSearch = searchQuery.isNotNullOrEmpty;

      return LibraryStateModel(
        items: filteredLibraryItems,
        searchQuery: searchQuery,
        selectedItems: validSelectedItems,
        hasActiveFilters: hasActiveFilters || hasActiveSearch,
      );
    });
  }

  // Get library items stream by watching the repository
  Stream<List<LibraryItem>> _libraryItemsStream(
    SortBy sortBy,
    SortOrder sortOrder,
  ) {
    // Get preferences needed for sorting
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
    try {
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
            final mutableWorks = List<WorkModel>.from(workModels);
            // (Sorting logic remains the same as your previous version)
            mutableWorks.sort((a, b) {
              switch (sortBy) {
                case SortBy.alphabetically:
                  return a.title.compareTo(b.title);
                case SortBy.author:
                  final authorsA =
                      a.authors.map((e) => e.name).toList()..sort();
                  final authorsB =
                      b.authors.map((e) => e.name).toList()..sort();
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
    } catch (e, stack) {
      logger.e("Error in _libraryItemsStream: $e", stackTrace: stack);
      // Handle error (e.g., return an empty stream or rethrow)
      return Stream.value([]); // Return empty list on error
    }
  }

  // Get preferences stream
  Stream<LibraryItemPreferences> _preferencesStream() {
    // Get ONLY filtering preferences
    final libraryPrefs = ref.watch(libraryPreferencesProvider);
    final morePrefs = ref.watch(morePreferencesProvider);

    // Combine streams for filtering preferences ONLY
    return Rx.combineLatestList([
      libraryPrefs.filterDownloaded.stream.startWith(
        libraryPrefs.filterDownloaded.get(),
      ), // 0
      libraryPrefs.filterUnread.stream.startWith(
        libraryPrefs.filterUnread.get(),
      ), // 1
      libraryPrefs.filterFavorites.stream.startWith(
        libraryPrefs.filterFavorites.get(),
      ), // 2
      libraryPrefs.filterStarted.stream.startWith(
        libraryPrefs.filterStarted.get(),
      ), // 3
      libraryPrefs.filterCompleted.stream.startWith(
        libraryPrefs.filterCompleted.get(),
      ), // 4
      libraryPrefs.filterUpdated.stream.startWith(
        libraryPrefs.filterUpdated.get(),
      ), // 5
      morePrefs.downloadedOnlyMode.stream.startWith(
        morePrefs.downloadedOnlyMode.get(),
      ), // 6
    ]).map(
      (values) {
        return LibraryItemPreferences(
          filterDownloaded: (values[0] as TriState).toBool(),
          filterUnread: (values[1] as TriState).toBool(),
          filterFavorite: (values[2] as TriState).toBool(),
          filterStarted: (values[3] as TriState).toBool(),
          filterCompleted: (values[4] as TriState).toBool(),
          filterUpdated: (values[5] as TriState).toBool(),
          downloadedOnlyMode: values[6] as bool?,
        );
      },
    ).distinct(); // Keep distinct to avoid unnecessary updates if prefs object is identical
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
  Stream<String?> _searchQueryStream() async* {
    yield state.valueOrNull?.searchQuery; // Keep the original simpler version
  }

  void search(String? query) async {
    final previousState = state.valueOrNull;
    if (previousState != null) {
      final newState = previousState.copyWith(searchQuery: query);
      state = await AsyncValue.guard(() async => newState);
    }
  }

  void startSearching() {
    search('');
    refresh(); // Ensure the state is refreshed to show search results
  }

  void stopSearching() {
    search(null);
    refresh(); // Ensure the state is refreshed to show search results
  }

  void updateSearchQuery(String query) {
    search(query);
    refresh(); // Ensure the state is refreshed to show search results
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
