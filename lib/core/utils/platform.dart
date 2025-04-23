import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

extension PlatformExtension on BuildContext {
  bool get isAndroid => Theme.of(this).platform == TargetPlatform.android;
  bool get isIOS => Theme.of(this).platform == TargetPlatform.iOS;
  bool get isMacOS => Theme.of(this).platform == TargetPlatform.macOS;
  bool get isWindows => Theme.of(this).platform == TargetPlatform.windows;
  bool get isLinux => Theme.of(this).platform == TargetPlatform.linux;

  bool get isMobile =>
      Theme.of(this).platform == TargetPlatform.android ||
      Theme.of(this).platform == TargetPlatform.iOS;
  bool get isWeb => kIsWeb;
  bool get isDesktop =>
      Theme.of(this).platform == TargetPlatform.macOS ||
      Theme.of(this).platform == TargetPlatform.windows ||
      Theme.of(this).platform == TargetPlatform.linux;
}
