import 'package:freezed_annotation/freezed_annotation.dart';

part 'reader_state.freezed.dart';

@freezed
class ReaderStateModel with _$ReaderStateModel {
  const ReaderStateModel._();

  const factory ReaderStateModel({
    required int workID,
    required int totalPages,
    @Default(0) int currentPage,
    @Default(-1) int currentChapter,
    @Default(0.0) double scrollOffset,
    @Default(false) bool showControls,
  }) = _ReaderStateModel;

  int get effectiveChapterIndex {
    if (currentPage < 2) return -1;
    return currentPage - 2; // Adjust for title page and TOC
  }
}
