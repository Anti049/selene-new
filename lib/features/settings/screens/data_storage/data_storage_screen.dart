import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:selene/features/banners/providers/banner_state_provider.dart';
import 'package:selene/features/settings/screens/data_storage/providers/data_storage_preferences.dart';

@RoutePage()
class DataStorageScreen extends ConsumerWidget {
  const DataStorageScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool isTopBannerVisible = ref.watch(isTopBannerAreaCoveredProvider);
    final dataStorageSettings = ref.watch(dataStorageSettingsProvider);

    return Scaffold(
      primary: !isTopBannerVisible,
      appBar: AppBar(
        primary: !isTopBannerVisible,
        title: const Text('Data & Storage'),
      ),
      body: ListView(
        children:
            dataStorageSettings
                .map((setting) => setting.buildWidget(context))
                .toList(),
      ),
    );
  }
}
