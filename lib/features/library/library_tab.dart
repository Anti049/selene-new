import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:selene/common/widgets/empty.dart';
import 'package:selene/features/settings/screens/appearance/providers/appearance_preferences.dart';

@RoutePage()
class LibraryTab extends ConsumerWidget {
  const LibraryTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appearancePrefs = ref.watch(appearancePreferencesProvider);

    return Scaffold(
      body: Empty(
        message: 'Library Not Implemented',
        subtitle: appearancePrefs.themeID.value,
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Symbols.add),
        onPressed: () {
          if (appearancePrefs.themeID.value == 'gaziter') {
            appearancePrefs.themeID.setValue('system');
          } else {
            appearancePrefs.themeID.setValue('gaziter');
          }
        },
      ),
    );
  }
}
