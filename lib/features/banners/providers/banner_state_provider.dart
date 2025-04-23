import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:selene/features/banners/providers/fullscreen_provider.dart';
import 'package:selene/features/more/providers/more_preferences.dart'; // Your provider for banner modes

part 'banner_state_provider.g.dart'; // Remember to generate this file

@riverpod
bool isTopBannerAreaCovered(Ref ref) {
  // Watch the preferences that control banner visibility
  final morePrefs = ref.watch(morePreferencesProvider);
  final isDownloadedVisible = morePrefs.downloadedOnlyMode.get();
  final isIncognitoVisible = morePrefs.incognitoMode.get();
  final fullscreen = ref.watch(fullscreenProvider);

  // The top area is considered covered if either banner is visible
  // because the topmost visible banner handles the status bar space.
  return (isDownloadedVisible || isIncognitoVisible) && !fullscreen;
}
