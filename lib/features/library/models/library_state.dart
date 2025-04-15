import 'package:dartx/dartx.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:selene/features/library/models/library_item.dart';

part 'library_state.freezed.dart';

@freezed
class LibraryStateModel with _$LibraryStateModel {
  const LibraryStateModel._();

  const factory LibraryStateModel({
    @Default([]) List<LibraryItem> items,
    String? searchQuery,
    @Default([]) List<LibraryItem> selectedItems,
    @Default(false) bool showCategoryTabs,
    @Default(false) bool showWorkCount,
    @Default(false) bool showContinueReadingButton,
    @Default(false) bool hasActiveFilters,
  }) = _LibraryStateModel;

  int get workCount => items.length;
  int get selectedCount => selectedItems.length;
  bool get isEmpty =>
      items.isEmpty && searchQuery.isNullOrEmpty && !hasActiveFilters;
  bool get isSearchActive => searchQuery != null;
  bool get isSelectionActive => selectedItems.isNotEmpty;
  bool isSelected(LibraryItem item) => selectedItems.contains(item);
  bool get isFiltered => hasActiveFilters || searchQuery.isNotNullOrEmpty;
}
