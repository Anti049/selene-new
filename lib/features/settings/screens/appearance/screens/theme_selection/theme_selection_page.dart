import 'package:animated_visibility/animated_visibility.dart';
import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:selene/common/widgets/padded_app_bar.dart';
import 'package:selene/core/constants/animation_constants.dart';
import 'package:selene/core/database/models/preference.dart';
import 'package:selene/core/theme/models/app_theme.dart';
import 'package:selene/core/theme/providers/theme_repository_provider.dart';
import 'package:selene/core/utils/theming.dart';
import 'package:selene/features/settings/screens/appearance/providers/appearance_preferences.dart';
import 'package:selene/features/settings/screens/appearance/screens/theme_selection/presentation/widgets/theme_section.dart';

@RoutePage()
class ThemeSelectionScreen extends ConsumerStatefulWidget {
  const ThemeSelectionScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ThemeSelectionScreenState();
}

class _ThemeSelectionScreenState extends ConsumerState<ThemeSelectionScreen> {
  Map<ThemeCategory, bool> expandedCategories = {};
  bool expandAll = false;

  @override
  void initState() {
    super.initState();

    for (final category in ThemeCategory.values) {
      expandedCategories[category] = false;
    }
  }

  List<AppTheme> _getThemesForCategory(ThemeCategory category) {
    // Get providers
    final themeRepository = ref.watch(themeRepositoryProvider);

    // Return themes for the specified category
    final categoryThemes = themeRepository.getThemesByCategorySync(category);

    // Sort themes by name
    categoryThemes.sort((a, b) => a.name.compareTo(b.name));

    // Move "System" theme from sorted index to first
    final systemThemeIndex = categoryThemes.indexWhere(
      (theme) => theme.id == 'system',
    );
    if (systemThemeIndex != -1) {
      final systemTheme = categoryThemes.removeAt(systemThemeIndex);
      categoryThemes.insert(0, systemTheme);
    }

    // Move "Dynamic" theme from sorted index to second
    final dynamicThemeIndex = categoryThemes.indexWhere(
      (theme) => theme.id == 'dynamic',
    );
    if (dynamicThemeIndex != -1) {
      final dynamicTheme = categoryThemes.removeAt(dynamicThemeIndex);
      categoryThemes.insert(1, dynamicTheme);
    }

    // Return the sorted themes
    return categoryThemes;
  }

  Map<ThemeCategory, List<AppTheme>> _getThemesByCategoryMap(
    BuildContext context,
  ) {
    final themesByCategory = <ThemeCategory, List<AppTheme>>{};
    for (final category in ThemeCategory.values) {
      themesByCategory[category] = _getThemesForCategory(category);
    }
    return themesByCategory;
  }

  bool isCategorySelected(ThemeCategory category, String themeID) {
    final selectedTheme = ref
        .watch(themeRepositoryProvider)
        .getThemeByIdSync(themeID);
    return selectedTheme?.category == category;
  }

  void expandContractCategory(ThemeCategory category) {
    setState(() {
      expandedCategories[category] = !expandedCategories[category]!;
      expandAll = expandedCategories.values.every((e) => e);
    });
  }

  void expandContractAll(bool expand) {
    setState(() {
      for (final category in ThemeCategory.values) {
        expandedCategories[category] = expand;
      }
      expandAll = expand;
    });
  }

  @override
  Widget build(BuildContext context) {
    final appearancePrefs = ref.watch(appearancePreferencesProvider);
    final themeMode = appearancePrefs.themeMode;
    final themeID = appearancePrefs.themeID.get() ?? 'system';
    final categorizedThemes = _getThemesByCategoryMap(context);

    return Scaffold(
      appBar: PaddedAppBar(title: const Text('Theme Selection')),
      body: ListView(
        children: [
          const SizedBox(height: 4.0),
          for (final category in categorizedThemes.keys)
            if (categorizedThemes[category]!.isNotEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8.0,
                  vertical: 4.0,
                ),
                child: Column(
                  children: [
                    ListTile(
                      title: Text(category.name),
                      subtitle: Text(
                        '${categorizedThemes[category]!.length} themes',
                      ),
                      tileColor:
                          expandedCategories[category]!
                              ? context.scheme.surfaceContainerHigh
                              : context.scheme.surfaceContainer,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: const Radius.circular(8.0),
                          topRight: const Radius.circular(8.0),
                          bottomLeft: Radius.circular(
                            expandedCategories[category]! ? 0.0 : 8.0,
                          ),
                          bottomRight: Radius.circular(
                            expandedCategories[category]! ? 0.0 : 8.0,
                          ),
                        ),
                      ),
                      enabled: categorizedThemes[category]?.isNotEmpty ?? false,
                      leading: Container(
                        width: 24.0,
                        height: 24.0,
                        decoration: BoxDecoration(
                          color:
                              isCategorySelected(category, themeID)
                                  ? context.scheme.primary
                                  : Colors.transparent,
                          borderRadius: BorderRadius.circular(256.0),
                        ),
                        child: Icon(
                          Symbols.check,
                          color:
                              isCategorySelected(category, themeID)
                                  ? context.scheme.onPrimary
                                  : Colors.transparent,
                          size: 16.0,
                        ),
                      ),
                      trailing: Icon(
                        expandedCategories[category]!
                            ? Symbols.keyboard_arrow_up
                            : Symbols.keyboard_arrow_down,
                      ),
                      onTap: () {
                        expandContractCategory(category);
                      },
                    ),
                    AnimatedVisibility(
                      visible: expandedCategories[category] ?? false,
                      enter: expandVertically(curve: kAnimationCurve),
                      enterDuration: kAnimationDuration,
                      exit: shrinkVertically(curve: kAnimationCurve),
                      exitDuration: kAnimationDuration,
                      child: ThemeSection(
                        title: category.name,
                        themes: categorizedThemes[category]!,
                      ),
                    ),
                  ],
                ),
              ),
          const SizedBox(height: 4.0),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        // color: context.scheme.surfaceContainerLow,
        child: Row(
          children: [
            IconButton(
              onPressed: () {
                themeMode.cycle(ThemeMode.values);
              },
              icon: Icon(switch (themeMode.get()) {
                ThemeMode.system => Symbols.brightness_auto,
                ThemeMode.light => Symbols.brightness_high,
                ThemeMode.dark => Symbols.brightness_low,
              }),
              tooltip: switch (themeMode.get()) {
                ThemeMode.system => 'Set to Light Mode',
                ThemeMode.light => 'Set to Dark Mode',
                ThemeMode.dark => 'Set to System Mode',
              },
            ),
            const SizedBox(width: 4.0),
            IconButton(
              onPressed: () {
                expandContractAll(!expandAll);
              },
              icon: Icon(expandAll ? Symbols.collapse_all : Symbols.expand_all),
              tooltip:
                  expandAll
                      ? 'Collapse all categories'
                      : 'Expand all categories',
            ),
            const SizedBox(width: 4.0),
            IconButton(onPressed: () {}, icon: const Icon(Symbols.square)),
            const SizedBox(width: 4.0),
            IconButton(onPressed: () {}, icon: const Icon(Symbols.pentagon)),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 0.0,
        onPressed: () {},
        child: const Icon(Symbols.add, fill: 1.0),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endContained,
    );
  }
}
