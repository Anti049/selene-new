import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:selene/core/utils/theming.dart';

class ScrollablePage extends StatefulWidget {
  const ScrollablePage({
    super.key,
    required this.page,
    required this.index,
    this.onPrevious,
    this.onNext,
    this.onScrollOffsetChanged,
    this.scrollDirection = Axis.vertical,
  });

  final Widget page;
  final int index;
  final VoidCallback? onPrevious;
  final VoidCallback? onNext;
  final ValueChanged<double>? onScrollOffsetChanged;
  final Axis scrollDirection;

  @override
  State<ScrollablePage> createState() => _ScrollablePageState();
}

class _ScrollablePageState extends State<ScrollablePage> {
  final EasyRefreshController _refreshController = EasyRefreshController(
    controlFinishRefresh: true,
    controlFinishLoad: true,
  );
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    _refreshController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (widget.onScrollOffsetChanged != null) {
      widget.onScrollOffsetChanged!(_scrollController.offset);
    }
  }

  @override
  Widget build(BuildContext context) {
    return EasyRefresh.builder(
      controller: _refreshController,
      scrollController: _scrollController,
      triggerAxis: widget.scrollDirection,
      header: ClassicHeader(
        showMessage: false,
        showText: false,
        processedDuration: const Duration(milliseconds: 0),
        pullIconBuilder: (context, state, animation) {
          final value = state.offset / state.actualTriggerOffset;
          return CircularProgressIndicator(
            value: value,
            strokeWidth: 2.0,
            valueColor: AlwaysStoppedAnimation<Color>(context.scheme.primary),
            constraints: BoxConstraints.tightFor(width: 24.0, height: 24.0),
          );
        },
        infiniteOffset: null,
      ),
      footer: ClassicFooter(
        showMessage: false,
        showText: false,
        processedDuration: const Duration(milliseconds: 0),
        triggerOffset: 64.0,
        spacing: 8.0,
        pullIconBuilder: (context, state, animation) {
          final value = state.offset / state.actualTriggerOffset;
          return CircularProgressIndicator(
            value: value,
            strokeWidth: 2.0,
            valueColor: AlwaysStoppedAnimation<Color>(context.scheme.primary),
            constraints: const BoxConstraints.tightFor(
              width: 24.0,
              height: 24.0,
            ),
          );
        },
        infiniteOffset: null,
        safeArea: false,
      ),
      onRefresh: () async {
        if (widget.onPrevious != null) {
          widget.onPrevious!();
          _refreshController.finishRefresh(IndicatorResult.success);
          _refreshController.resetFooter();
        } else {
          _refreshController.finishRefresh(IndicatorResult.noMore);
        }
      },
      onLoad: () async {
        if (widget.onNext != null) {
          widget.onNext!();
          _refreshController.finishLoad(IndicatorResult.success);
          _refreshController.resetHeader();
        } else {
          _refreshController.finishLoad(IndicatorResult.noMore);
        }
      },
      childBuilder: (context, physics) {
        return SingleChildScrollView(
          physics: physics,
          controller: _scrollController,
          child: widget.page,
        );
      },
    );
  }
}
