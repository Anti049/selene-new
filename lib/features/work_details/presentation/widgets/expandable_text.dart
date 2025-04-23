import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:selene/core/utils/theming.dart';

class ExpandableText extends StatefulWidget {
  final String text;
  final int maxLines;
  final TextStyle? style;
  final void Function(bool)? onExpanded;

  const ExpandableText({
    super.key,
    required this.text,
    this.maxLines = 3,
    this.style,
    this.onExpanded,
  });

  @override
  State<ExpandableText> createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText>
    with SingleTickerProviderStateMixin {
  bool _isExpanded = false;
  late AnimationController _animationController;
  late Animation<double> _heightAnimation;
  double _textHeight = 0.0;
  double _collapsedHeight = 0.0;
  bool _requiresTruncation = false;
  bool _parentExpanded = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _calculateHeights();
  }

  void _calculateHeights() {
    final style = context.text.bodyMedium!
        .copyWith(color: context.text.bodySmall?.color)
        .merge(widget.style);
    // Convert HTML to plaintext (with lines breaks and formatting)
    final plainText = widget.text.replaceAll(RegExp(r'<[^>]*>'), '\n').trim();

    final textPainter = TextPainter(
      text: TextSpan(text: plainText, style: style),
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: context.mediaQuery.size.width);

    _textHeight = textPainter.height + 1.0;

    final collapsedTextPainter = TextPainter(
      text: TextSpan(text: plainText, style: style),
      maxLines: widget.maxLines,
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: context.mediaQuery.size.width);

    _collapsedHeight = collapsedTextPainter.height;
    _collapsedHeight = _collapsedHeight.floorToDouble();

    _requiresTruncation =
        _textHeight >
        _collapsedHeight +
            1.0; // Ensure there's a difference to show the expand/collapse

    _heightAnimation = Tween<double>(
      begin: _collapsedHeight,
      end: _textHeight,
    ).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    if (!_requiresTruncation) {
      _isExpanded = true; // Automatically expand if no truncation is needed
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _toggleExpanded() {
    if (_requiresTruncation) {
      setState(() {
        _isExpanded = !_isExpanded;
        _parentExpanded = _isExpanded;
        if (_isExpanded) {
          _animationController.forward();
        } else {
          _animationController.reverse();
        }
      });
    } else {
      setState(() {
        _parentExpanded = !_parentExpanded;
      });
    }
    widget.onExpanded?.call(_parentExpanded);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: _toggleExpanded,
              child: AnimatedBuilder(
                animation: _heightAnimation,
                builder: (context, child) {
                  return Stack(
                    children: [
                      Column(
                        children: [
                          ClipRect(
                            child: Align(
                              alignment: Alignment.topLeft,
                              heightFactor:
                                  _requiresTruncation
                                      ? _heightAnimation.value / _textHeight
                                      : 1.0,
                              child: HtmlWidget(
                                widget.text,
                                textStyle:
                                    widget.style ?? context.text.bodyMedium,
                              ),
                            ),
                          ),
                          if (_requiresTruncation)
                            AnimatedSize(
                              duration: Duration(milliseconds: 200),
                              curve: Curves.easeInOut,
                              child: Container(
                                height: _isExpanded ? 24.0 : 0.0,
                              ),
                            ),
                          if (!_requiresTruncation)
                            Padding(
                              padding: const EdgeInsets.only(bottom: 32.0),
                              child: SizedBox.shrink(),
                            ),
                        ],
                      ),
                      if (_requiresTruncation)
                        Positioned.fill(
                          child: AnimatedOpacity(
                            duration: Duration(milliseconds: 200),
                            opacity: _isExpanded ? 0.0 : 1.0,
                            child: Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    context.theme.scaffoldBackgroundColor
                                        .withAlpha(0),
                                    context.theme.scaffoldBackgroundColor,
                                  ],
                                  stops: [0.5, 1.0],
                                ),
                              ),
                            ),
                          ),
                        ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Center(
            child: IconButton(
              visualDensity: VisualDensity(horizontal: -4.0, vertical: -4.0),
              icon: Icon(
                _isExpanded && _parentExpanded
                    ? Icons.expand_less
                    : Icons.expand_more,
              ),
              onPressed: _toggleExpanded,
            ),
          ),
        ),
      ],
    );
  }
}
