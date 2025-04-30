import 'package:animated_visibility/animated_visibility.dart';
import 'package:auto_route/auto_route.dart';
import 'package:dartx/dartx.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:selene/common/widgets/padded_app_bar.dart';
import 'package:selene/core/constants/animation_constants.dart';
import 'package:selene/core/database/models/work.dart';
import 'package:selene/core/utils/theming.dart';
import 'package:selene/features/banners/providers/fullscreen_provider.dart';
import 'package:selene/features/library/presentation/widgets/tag_chip.dart';
import 'package:selene/features/reader/presentation/widgets/hyperlink.dart';
import 'package:selene/features/reader/presentation/widgets/scrollable_page_view.dart';

@RoutePage()
class ReaderScreen extends ConsumerStatefulWidget {
  const ReaderScreen({super.key, required this.work, this.readProgress});

  final WorkModel work;
  final String? readProgress;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ReaderScreenState();
}

class _ReaderScreenState extends ConsumerState<ReaderScreen>
    with AutoRouteAwareStateMixin<ReaderScreen> {
  late PageController _pageController;
  int _currentPage = 0;
  bool _showControls = false;
  late EasyRefreshController _refreshController;
  double _chapterProgress = 0.0;

  @override
  void initState() {
    super.initState();
    // TODO: Load last read page from DB for widget.work.id
    // int initialPage = loadLastReadPage(widget.work.id); // Implement this
    _currentPage = 0; // +2 for title and info pages
    _pageController = PageController(initialPage: _currentPage);
    _refreshController = EasyRefreshController(
      controlFinishRefresh: true,
      controlFinishLoad: true,
    );
  }

  @override
  void dispose() {
    _refreshController.dispose();
    _pageController.dispose();
    // ... other dispose logic
    super.dispose();
  }

  @override
  void didPush() {
    Future(() => ref.read(fullscreenProvider.notifier).set(true));
  }

  @override
  void didPop() {
    Future(() => ref.read(fullscreenProvider.notifier).set(false));
  }

  void toggleControls() {
    setState(() {
      _showControls = !_showControls;
    });
    _notify();
  }

  void setControls(bool show) {
    setState(() {
      _showControls = show;
    });
    _notify();
  }

  void _notify() {
    // if (_showControls) {
    //   SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    // } else {
    //   SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    // }
  }

  void _updateReadProgress(int pageIndex) {
    setState(() {
      _currentPage = pageIndex;
    });
    // TODO: Debounce this call if needed
    // saveLastReadPage(
    //   widget.work.id,
    //   pageIndex,
    // ); // Implement this using WorksRepository
  }

  // Build Title page
  Widget _buildTitlePage(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Hyperlink(
            widget.work.title,
            link: widget.work.sourceURL,
            style: context.text.headlineLarge,
          ),
          const SizedBox(height: 16.0),
          Text('by', style: context.text.bodyLarge),
          const SizedBox(height: 8.0),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              for (var author in widget.work.authors)
                Hyperlink(
                  author.name,
                  link: author.sourceURL,
                  style: context.text.headlineSmall?.copyWith(
                    color: context.scheme.primary,
                  ),
                ),
            ],
          ),
          SizedBox(height: 128.0),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Fandoms:', style: context.text.titleLarge),
              const SizedBox(height: 8.0),
              for (var fandom in widget.work.fandoms)
                Hyperlink(
                  fandom.name,
                  // link: fandom.sourceURL,
                  style: context.text.headlineSmall?.copyWith(
                    color: context.scheme.primary,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoPage(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 8.0,
        children: [
          Text(
            'Information',
            style: context.text.headlineMedium,
            textAlign: TextAlign.center,
          ),
          const Divider(),
          if (widget.work.summary != null &&
              widget.work.summary!.isNotEmpty) ...[
            Text('Summary', style: context.text.titleLarge),
            HtmlWidget(widget.work.summary!),
            const Divider(),
          ],
          if (widget.work.tags.isNotEmpty) ...[
            Text('Tags', style: context.text.titleLarge),
            Wrap(
              spacing: 4.0,
              runSpacing: 4.0,
              children:
                  widget.work.tags.map((tag) => TagChip(tag: tag)).toList(),
            ),
            const SizedBox(height: 16),
          ],
          // Add other details like word count, status, dates etc. here
          ListTile(
            leading: Icon(Symbols.book),
            title: Text('Word Count: ${widget.work.wordCount ?? 'N/A'}'),
          ),
          ListTile(
            leading: Icon(Symbols.timelapse),
            title: Text('Status: ${widget.work.status.label}'),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildChapterPages(BuildContext context) {
    return widget.work.chapters.mapIndexed((index, chapter) {
      return Padding(
        key: PageStorageKey(
          'chapter_${chapter.id}',
        ), // Preserve scroll position
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: 24.0,
          children: [
            // Chapter title, centered
            if (chapter.title.isNotEmpty)
              Text(
                chapter.title,
                style: context.text.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            // Chapter summary
            if (chapter.summary != null && chapter.summary!.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Divider(),
                  Text(
                    'Summary',
                    style: context.text.titleLarge?.copyWith(
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const Divider(),
                  HtmlWidget(
                    chapter.summary!,
                    textStyle: context.text.bodyLarge?.copyWith(
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            // Start notes
            if (chapter.startNotes != null && chapter.startNotes!.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Divider(),
                  Text(
                    'Start Notes',
                    style: context.text.titleLarge?.copyWith(
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const Divider(),
                  HtmlWidget(
                    chapter.startNotes!,
                    textStyle: context.text.bodyLarge?.copyWith(
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            const Divider(),
            // Chapter content
            HtmlWidget(
              chapter.content ?? '<p>Chapter content not available.</p>',
              textStyle: context.text.bodyLarge,
              customWidgetBuilder: (element) {
                if (element.localName == 'p' &&
                    (element.text.trim().startsWith('---') ||
                        element.text.trim().startsWith('==='))) {
                  // Check if it's just the dashes, adjust condition as needed
                  if (element.text.trim().replaceAll('-', '').isEmpty ||
                      element.text.trim().replaceAll('=', '').isEmpty) {
                    return Divider(
                      height: 1,
                      thickness: 1,
                      color: context.scheme.onSurface,
                    );
                  }
                }
                return null; // Let the package handle other elements
              },
            ),
            // End notes
            if (chapter.endNotes != null && chapter.endNotes!.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Divider(),
                  Text(
                    'End Notes',
                    style: context.text.titleLarge?.copyWith(
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const Divider(),
                  HtmlWidget(
                    chapter.endNotes!,
                    textStyle: context.text.bodyLarge?.copyWith(
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
          ],
        ),
      );
    }).toList();
  }

  String getSubtitle() {
    return switch (_currentPage) {
      0 => 'Title Page',
      1 => 'Information Page',
      _ =>
        'Chapter ${_currentPage - 1}: ${widget.work.chapters[_currentPage - 2].title}',
    };
  }

  void _onScrollOffsetChanged(double offset, double total) {
    setState(() {
      _chapterProgress = offset / total;
    });
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      // _buildTitlePage(context), // Title page
      // _buildInfoPage(context), // Info page
      ..._buildChapterPages(context), // Chapter pages
    ];
    return Scaffold(
      appBar: PaddedAppBar(
        title: Text(widget.work.title),
        subtitle: getSubtitle(),
        elevated: true,
        leading: IconButton(
          icon: Icon(Symbols.menu),
          onPressed: () {},
          tooltip: 'Back to Library',
        ),
        actions: [
          IconButton(
            icon: Icon(Symbols.bookmark),
            onPressed: () {},
            tooltip: 'Bookmark this Chapter',
          ),
          IconButton(icon: Icon(Symbols.more_vert), onPressed: () {}),
        ],
        visible: _showControls,
      ),
      body: AnimatedContainer(
        duration: kAnimationDuration,
        curve: kAnimationCurve,
        padding: EdgeInsets.only(
          top: !_showControls ? context.mediaQuery.viewPadding.top : 0.0,
        ),
        child: GestureDetector(
          onTap: toggleControls,
          // child: SelectableRegion(
          //   selectionControls: materialTextSelectionControls,
          child: ScrollablePageView(
            pages: pages,
            startPageIndex: _currentPage,
            onPageIndexChanged: _updateReadProgress,
          ),
          // ),
        ),
      ),
      bottomNavigationBar: AnimatedVisibility(
        visible: _showControls,
        enter: slideInVertically(curve: kAnimationCurve),
        enterDuration: kAnimationDuration,
        exit: slideOutVertically(curve: kAnimationCurve),
        exitDuration: kAnimationDuration,
        child: Container(
          height: 72.0 + context.mediaQuery.systemGestureInsets.bottom,
          color: context.scheme.surfaceContainer,
        ),
      ),
    );
  }
}
