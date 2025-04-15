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
