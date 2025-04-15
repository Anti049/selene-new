import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:selene/core/database/models/work.dart';

part 'library_item.freezed.dart';

@freezed
class LibraryItem with _$LibraryItem {
  const factory LibraryItem({
    required int itemID,
    required WorkModel work,
    @Default(-1) int downloadCount,
    @Default(-1) int unreadCount,
    @Default(0) int lastReadPage,
    @Default(false) bool isFavorite,
  }) = _LibraryItem;
}
