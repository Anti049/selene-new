// General
enum TriState {
  /// Checkbox off
  ///
  /// ⬜
  ///
  /// This is used when the checkbox is fully unchecked, for example when no items are selected.
  disabled,

  /// Checkbox on
  ///
  /// ✅
  ///
  /// This is used when the checkbox is fully checked, for example when all items are selected.
  enabledTrue,

  /// Checkbox partially on
  ///
  /// ❎
  ///
  /// This is used when the checkbox is partially checked, for example when some but not all items are selected.
  enabledFalse;

  TriState next() => switch (this) {
    TriState.disabled => TriState.enabledTrue,
    TriState.enabledTrue => TriState.enabledFalse,
    TriState.enabledFalse => TriState.disabled,
  };

  bool? toBool() => switch (this) {
    TriState.disabled => false,
    TriState.enabledTrue => true,
    TriState.enabledFalse => null,
  };

  static TriState fromBool(bool? value) => switch (value) {
    false => TriState.disabled,
    true => TriState.enabledTrue,
    null => TriState.enabledFalse,
  };
}

// Library -> Sort
enum SortBy {
  alphabetically('Alphabetically'),
  author('Author'),
  totalChapters('Total Chapters'),
  lastRead('Last Read'),
  lastChecked('Last Checked'),
  datePublished('Date Published'),
  lastUpdated('Last Updated'),
  unreadChapters('Unread Chapters'),
  latestChapter('Latest Chapter'),
  dateFetched('Date Fetched'),
  dateAdded('Date Added');

  const SortBy(this.label);
  final String label;
}

enum SortOrder {
  ascending('Ascending'),
  descending('Descending');

  const SortOrder(this.label);
  final String label;
}

// Library -> Display
enum DisplayMode {
  compactGrid('Compact Grid'),
  comfortableGrid('Comfortable Grid'),
  coverOnlyGrid('Cover-Only Grid'),
  list('List'),
  widgetList('Widget List');

  const DisplayMode(this.label);
  final String label;
}
