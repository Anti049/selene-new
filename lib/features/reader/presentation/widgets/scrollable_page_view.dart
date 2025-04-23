import 'package:flutter/material.dart';
import 'package:selene/core/constants/animation_constants.dart';
import 'package:selene/features/reader/presentation/widgets/scrollable_page.dart';

class ScrollablePageView extends StatefulWidget {
  const ScrollablePageView({
    super.key,
    required this.pages,
    this.scrollDirection = Axis.vertical,
    this.startPageIndex = 0,
    this.startScrollOffset = 0.0,
    this.onPageIndexChanged,
    this.onScrollOffsetChanged,
  });

  final List<Widget> pages;
  final Axis scrollDirection;
  final int startPageIndex;
  final double startScrollOffset;
  final ValueChanged<int>? onPageIndexChanged;
  final ValueChanged<double>? onScrollOffsetChanged;

  @override
  State<ScrollablePageView> createState() => _ScrollablePageViewState();
}

class _ScrollablePageViewState extends State<ScrollablePageView> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: widget.startPageIndex);
    _pageController.addListener(() {
      if (widget.onPageIndexChanged != null) {
        widget.onPageIndexChanged!(_pageController.page!.round());
      }
      if (widget.onScrollOffsetChanged != null) {
        widget.onScrollOffsetChanged!(_pageController.offset);
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _pageController,
      scrollDirection: widget.scrollDirection,
      physics: NeverScrollableScrollPhysics(),
      children: [
        for (var page in widget.pages)
          ScrollablePage(
            page: page,
            index: widget.pages.indexOf(page),
            scrollDirection: widget.scrollDirection,
            onScrollOffsetChanged: widget.onScrollOffsetChanged,
            onPrevious:
                widget.pages.indexOf(page) > 0
                    ? () => _pageController.previousPage(
                      duration: kAnimationDuration,
                      curve: kAnimationCurve,
                    )
                    : null,
            onNext:
                widget.pages.indexOf(page) < widget.pages.length - 1
                    ? () => _pageController.nextPage(
                      duration: kAnimationDuration,
                      curve: kAnimationCurve,
                    )
                    : null,
          ),
      ],
    );
  }
}
