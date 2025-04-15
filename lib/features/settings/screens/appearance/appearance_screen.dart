import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:selene/features/banners/models/providers/banner_state_provider.dart';
import 'package:selene/features/settings/screens/appearance/providers/appearance_preferences.dart';

@RoutePage()
class AppearanceScreen extends ConsumerWidget {
  const AppearanceScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool isTopBannerVisible = ref.watch(isTopBannerAreaCoveredProvider);
    final appearanceSettings = ref.watch(appearanceSettingsProvider);

    return Scaffold(
      primary: !isTopBannerVisible,
      appBar: AppBar(
        primary: !isTopBannerVisible,
        title: const Text('Appearance'),
      ),
      body: ListView(
        children:
            appearanceSettings
                .map((setting) => setting.buildWidget(context))
                .toList(),
      ),
    );
  }
}
