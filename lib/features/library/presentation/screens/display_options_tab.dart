import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:selene/core/utils/enums.dart';
import 'package:selene/core/utils/theming.dart';
import 'package:selene/features/library/providers/library_preferences.dart';
import 'package:selene/features/settings/presentation/widgets/checkbox_setting_widget.dart';

@RoutePage()
class DisplayOptionsTab extends ConsumerWidget {
  const DisplayOptionsTab({super.key});

  bool isGridMode(DisplayMode mode) {
    return mode == DisplayMode.comfortableGrid ||
        mode == DisplayMode.compactGrid ||
        mode == DisplayMode.coverOnlyGrid;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final libraryPrefs = ref.watch(libraryPreferencesProvider);

    return ListView(
      controller: ScrollController(),
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.zero,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 8.0,
            children: [
              Text(
                'Display Mode',
                style: context.text.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              Wrap(
                spacing: 8.0,
                children:
                    DisplayMode.values
                        .map(
                          (mode) => ChoiceChip(
                            label: Text(mode.label),
                            iconTheme: null,
                            selected: libraryPrefs.displayMode.get() == mode,
                            onSelected:
                                (selected) =>
                                    libraryPrefs.displayMode.set(mode),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            backgroundColor: context.scheme.surfaceContainer,
                          ),
                        )
                        .toList(),
              ),
            ],
          ),
        ),
        if (isGridMode(libraryPrefs.displayMode.get()))
          Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Grid Size',
                      style: context.text.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      libraryPrefs.gridSize.get() > 0
                          ? '${libraryPrefs.gridSize.get().toInt()} Columns'
                          : 'Auto',
                      style: context.text.bodyMedium,
                    ),
                  ],
                ),
                Slider(
                  value: libraryPrefs.gridSize.get(),
                  onChanged: (value) => libraryPrefs.gridSize.set(value),
                  min: 0.0,
                  max: 6.0,
                  divisions: 6,
                ),
              ],
            ),
          ),
        if (libraryPrefs.displayMode.get() == DisplayMode.widgetList)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0),
                child: Text(
                  'Widget Options',
                  style: context.text.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              CheckboxSettingWidget(
                label: 'Published Date',
                preference: libraryPrefs.showPublishedDate,
                dense: true,
              ),
              CheckboxSettingWidget(
                label: 'Show Character Tags',
                preference: libraryPrefs.showCharacterTags,
                dense: true,
              ),
              CheckboxSettingWidget(
                label: 'Show Friendship Tags',
                preference: libraryPrefs.showFriendshipTags,
                dense: true,
              ),
              CheckboxSettingWidget(
                label: 'Show Romance Tags',
                preference: libraryPrefs.showRomanceTags,
                dense: true,
              ),
              CheckboxSettingWidget(
                label: 'Show Freeform Tags',
                preference: libraryPrefs.showFreeformTags,
                dense: true,
              ),
              CheckboxSettingWidget(
                label: 'Show Description',
                preference: libraryPrefs.showDescription,
                dense: true,
              ),
            ],
          ),
        Padding(
          padding: EdgeInsets.fromLTRB(0.0, 8.0, 16.0, 0.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Text(
                  'Overlays',
                  style: context.text.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              CheckboxSettingWidget(
                label: 'Downloaded Chapters Count',
                preference: libraryPrefs.showDownloadedCount,
                dense: true,
              ),
              CheckboxSettingWidget(
                label: 'Unread Chapters Count',
                preference: libraryPrefs.showUnreadCount,
                dense: true,
              ),
              CheckboxSettingWidget(
                label: 'Favorite Status',
                preference: libraryPrefs.showFavorite,
                dense: true,
              ),
              CheckboxSettingWidget(
                label: 'Continue Reading Button',
                preference: libraryPrefs.showContinueReadingButton,
                dense: true,
              ),
            ],
          ),
        ),
        SizedBox(height: context.mediaQuery.systemGestureInsets.bottom),
      ],
    );
  }
}
