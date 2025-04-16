import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:selene/core/constants/animation_constants.dart'; // Import animation constants
import 'package:selene/core/utils/theming.dart';
import 'package:selene/features/banners/presentation/widgets/banner_widget.dart';
import 'package:selene/features/more/providers/more_preferences.dart';

class BannersContainer extends ConsumerWidget {
  final Widget child;

  const BannersContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final prefs = ref.watch(morePreferencesProvider);
    final isDownloadedVisible = prefs.downloadedOnlyMode.get();
    final isIncognitoVisible = prefs.incognitoMode.get();
    final isAnyBannerVisible = isDownloadedVisible || isIncognitoVisible;

    // Determine topmost status
    final isDownloadedTopmost = isDownloadedVisible;
    final isIncognitoTopmost = isIncognitoVisible && !isDownloadedVisible;

    // Calculate banner indices and total visible count
    int downloadedBannerIndex = 0;
    int incognitoBannerIndex = isDownloadedVisible ? 1 : 0;
    int totalVisibleAboveIncognito = isDownloadedVisible ? 1 : 0;

    // Calculate the total height needed for visible banners
    // This value changes instantly when state changes
    final double targetTotalBannerHeight =
        BannerWidget.calculateTotalBannerHeight(
          context,
          isDownloadedVisible,
          isIncognitoVisible,
        );

    final appBrightness = context.scheme.brightness;

    final statusBarStyle = SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness:
          isAnyBannerVisible ? appBrightness : appBrightness.inverted,
    );

    final navBarStyle = FlexColorScheme.themedSystemNavigationBar(
      context,
      systemNavBarStyle: FlexSystemNavBarStyle.navigationBar,
      opacity: 0.5,
    );

    final appStyle = navBarStyle.copyWith(
      statusBarColor: statusBarStyle.statusBarColor,
      statusBarIconBrightness: statusBarStyle.statusBarIconBrightness,
    );

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: appStyle,
      child: Stack(
        children: [
          // Main Content Area - Use AnimatedPadding
          AnimatedPadding(
            padding: EdgeInsets.only(top: targetTotalBannerHeight),
            duration: kAnimationDuration, // Use same duration as banners
            curve: kAnimationCurve, // Use same curve as banners
            child: child,
          ),

          // Banners
          // Incognito Banner
          BannerWidget(
            label: 'Incognito Mode',
            backgroundColor: context.scheme.secondary,
            textColor: context.scheme.onSecondary,
            visible: isIncognitoVisible,
            isTopmost: isIncognitoTopmost,
            bannerIndex: incognitoBannerIndex,
            totalVisibleBanners: totalVisibleAboveIncognito,
          ),
          // Downloaded Only Banner
          BannerWidget(
            label: 'Downloaded Only',
            backgroundColor: context.scheme.primary,
            textColor: context.scheme.onPrimary,
            visible: isDownloadedVisible,
            isTopmost: isDownloadedTopmost,
            bannerIndex: downloadedBannerIndex,
            totalVisibleBanners: 0,
          ),
        ],
      ),
    );
  }
}
