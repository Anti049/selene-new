import 'package:flutter/material.dart';
import 'package:selene/core/constants/animation_constants.dart'; //
import 'package:selene/core/utils/theming.dart'; //

class BannerWidget extends StatelessWidget {
  const BannerWidget({
    super.key,
    required this.label,
    required this.backgroundColor,
    required this.textColor,
    required this.visible,
    required this.isTopmost,
    required this.bannerIndex, // 0 for top, 1 for second
    required this.totalVisibleBanners, // How many banners are visible above this one
  });

  final String label;
  final Color backgroundColor;
  final Color textColor;
  final bool visible;
  final bool isTopmost;
  final int bannerIndex;
  final int totalVisibleBanners;

  static const double _bannerHeight = 32.0;

  @override
  Widget build(BuildContext context) {
    final statusBarHeight = context.mediaQuery.viewPadding.top;
    final double height = _bannerHeight + (isTopmost ? statusBarHeight : 0.0);
    final double topOffset =
        _bannerHeight * bannerIndex + (isTopmost ? 0 : statusBarHeight);
    final double hiddenTopOffset = -(_bannerHeight * (totalVisibleBanners + 1));

    Widget bannerContent = Container(
      height: height,
      color: backgroundColor,
      padding: EdgeInsets.only(
        top: (isTopmost ? statusBarHeight : 0.0),
      ), // Add padding for status bar if topmost
      alignment: Alignment.center,
      child: Text(
        label,
        style: context.text.labelMedium?.copyWith(color: textColor),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );

    return AnimatedPositioned(
      duration: kAnimationDuration, //
      curve: kAnimationCurve, //
      top: visible ? topOffset : hiddenTopOffset,
      left: 0,
      right: 0,
      height: height,
      child: bannerContent,
    );
  }

  // Helper function to calculate the total height needed for visible banners
  static double calculateTotalBannerHeight(
    BuildContext context,
    bool isDownloadedVisible,
    bool isIncognitoVisible,
  ) {
    final statusBarHeight = context.mediaQuery.viewPadding.top;
    double totalHeight = 0;
    if (isDownloadedVisible) {
      totalHeight +=
          _bannerHeight + statusBarHeight; // Downloaded is always top
    }
    if (isIncognitoVisible && !isDownloadedVisible) {
      totalHeight +=
          _bannerHeight +
          statusBarHeight; // Incognito is top only if Downloaded is not
    } else if (isIncognitoVisible) {
      totalHeight += _bannerHeight; // Incognito is second banner
    }
    return totalHeight;
  }
}
