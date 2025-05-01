import 'package:animated_visibility/animated_visibility.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:selene/core/constants/animation_constants.dart';
import 'package:selene/core/database/models/tag.dart';
import 'package:selene/core/database/models/work.dart';
import 'package:selene/core/utils/theming.dart';
import 'package:selene/features/library/presentation/widgets/tag_chip.dart';
import 'package:selene/features/library/providers/library_preferences.dart';
import 'package:selene/routing/router.gr.dart';
import 'package:selene/data/local/file_service_registry.dart';

class LibraryComponentItem extends ConsumerStatefulWidget {
  const LibraryComponentItem({
    super.key,
    required this.work,
    required this.isSelected,
    required this.onTap,
    required this.onLongPress,
  });

  final WorkModel work;
  final bool isSelected;
  final Function(int workID) onTap;
  final Function(int workID) onLongPress;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _LibraryComponentItemState();
}

class _LibraryComponentItemState extends ConsumerState<LibraryComponentItem> {
  bool _isExpanded = false;
  double _readProgress = 0.0; // Placeholder for read progress

  void _toggleExpansion() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  Map<TagType, List<TagModel>> get _separatedTags {
    final tags = widget.work.tags;
    final separatedTags = <TagType, List<TagModel>>{};

    for (final tag in tags) {
      final type = tag.type == TagType.other ? TagType.info : tag.type;
      if (!separatedTags.containsKey(type)) {
        separatedTags[type] = [];
      }
      separatedTags[type]!.add(tag);
    }

    return separatedTags;
  }

  @override
  Widget build(BuildContext context) {
    // Get providers
    // final showPublishedDate = ref.watch(
    //   libraryPreferencesProvider.select(
    //     (prefs) => prefs.showPublishedDate.get(),
    //   ),
    // );
    final showCharacterTags = ref.watch(
      libraryPreferencesProvider.select(
        (prefs) => prefs.showCharacterTags.get(),
      ),
    );
    final showFriendshipTags = ref.watch(
      libraryPreferencesProvider.select(
        (prefs) => prefs.showFriendshipTags.get(),
      ),
    );
    final showRomanceTags = ref.watch(
      libraryPreferencesProvider.select((prefs) => prefs.showRomanceTags.get()),
    );
    final showFreeformTags = ref.watch(
      libraryPreferencesProvider.select(
        (prefs) => prefs.showFreeformTags.get(),
      ),
    );
    // final showDescription = ref.watch(
    //   libraryPreferencesProvider.select((prefs) => prefs.showDescription.get()),
    // );

    // Get separated tags
    final separatedTags = _separatedTags;
    final infoTags = separatedTags[TagType.info] ?? [];
    final characterTags = separatedTags[TagType.character] ?? [];
    final friendshipTags = separatedTags[TagType.friendship] ?? [];
    final romanceTags = separatedTags[TagType.romance] ?? [];
    final freeformTags = separatedTags[TagType.freeform] ?? [];

    // Return widget
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: GestureDetector(
        onTap: () => widget.onTap(widget.work.id!),
        onLongPress: () => widget.onLongPress(widget.work.id!),
        child: Container(
          width: double.infinity,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            color:
                widget.isSelected
                    ? ElevationOverlay.applySurfaceTint(
                      context.scheme.surfaceContainerHigh,
                      context.scheme.primary,
                      8.0,
                    )
                    : context.scheme.surfaceContainerHigh,
            borderRadius: BorderRadius.circular(6.0),
            border: Border.all(
              color:
                  widget.isSelected
                      ? context.scheme.primary
                      : context.scheme.outlineVariant,
              width: 2.0,
              strokeAlign: BorderSide.strokeAlignOutside,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Header
              Container(
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(12.0, 8.0, 12.0, 8.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  spacing: 16.0,
                  children: [
                    // Title, Fandom(s), and Author(s)
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 2.0,
                        children: [
                          // Title
                          Text(
                            widget.work.title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: context.text.titleMedium?.copyWith(
                              color:
                                  widget.isSelected
                                      ? context.scheme.primary
                                      : context.scheme.onSurface,
                            ),
                          ),
                          // Fandom(s)
                          Row(
                            spacing: 8.0,
                            children: [
                              Icon(
                                Symbols.collections_bookmark,
                                fill: 1.0,
                                color:
                                    widget.isSelected
                                        ? context.scheme.primary.withValues(
                                          alpha: 0.7,
                                        )
                                        : context.scheme.onSurfaceVariant,
                                size: 16.0,
                              ),
                              Flexible(
                                child: Text(
                                  widget.work.fandomNames,
                                  style: context.text.labelMedium?.copyWith(
                                    color:
                                        widget.isSelected
                                            ? context.scheme.primary.withValues(
                                              alpha: 0.7,
                                            )
                                            : context.scheme.onSurfaceVariant,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                          // Author(s)
                          Row(
                            spacing: 8.0,
                            children: [
                              Icon(
                                Symbols.person,
                                fill: 1.0,
                                color:
                                    widget.isSelected
                                        ? context.scheme.primary.withValues(
                                          alpha: 0.7,
                                        )
                                        : context.scheme.onSurfaceVariant,
                                size: 16.0,
                              ),
                              Flexible(
                                child: Text(
                                  widget.work.authorNames,
                                  style: context.text.labelSmall?.copyWith(
                                    color:
                                        widget.isSelected
                                            ? context.scheme.primary.withValues(
                                              alpha: 0.7,
                                            )
                                            : context.scheme.onSurfaceVariant,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    // Actions
                    Consumer(
                      builder: (context, ref, child) {
                        final showContinueButton = ref.watch(
                          libraryPreferencesProvider.select(
                            (prefs) => prefs.showContinueReadingButton.get(),
                          ),
                        );
                        return Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            IconButton(
                              icon: Icon(
                                _isExpanded
                                    ? Symbols.keyboard_arrow_up
                                    : Symbols.keyboard_arrow_down,
                              ),
                              onPressed: _toggleExpansion,
                            ),
                            if (showContinueButton)
                              IconButton.filled(
                                icon: Icon(Symbols.play_arrow, fill: 1.0),
                                onPressed: () {
                                  // Read last read progress from the work model
                                  final readProgress = widget.work.readProgress;

                                  context.router.push(
                                    ReaderRoute(
                                      work: widget.work,
                                      readProgress: readProgress,
                                    ),
                                  );
                                },
                              ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
              // Progress Bar
              LinearPercentIndicator(
                percent: 0.0, // TODO: Implement real read progress
                backgroundColor:
                    widget.isSelected
                        ? ElevationOverlay.applySurfaceTint(
                          context.scheme.outlineVariant,
                          context.scheme.primary,
                          8.0,
                        )
                        : context.scheme.outlineVariant,
                progressColor: context.scheme.primary,
                lineHeight: 4,
                animation: true,
                animationDuration: kAnimationDuration.inMilliseconds,
                curve: kAnimationCurve,
                padding: EdgeInsets.zero,
                animateFromLastPercent: true,
                animateToInitialPercent: false,
              ),
              // Tags Section
              AnimatedVisibility(
                visible: _isExpanded,
                enter: expandVertically(curve: kAnimationCurve),
                enterDuration: kAnimationDuration,
                exit: shrinkVertically(curve: kAnimationCurve),
                exitDuration: kAnimationDuration,
                child: Container(
                  width: double.infinity,
                  color:
                      widget.isSelected
                          ? ElevationOverlay.applySurfaceTint(
                            context.scheme.surfaceContainer,
                            context.scheme.primary,
                            8.0,
                          )
                          : context.scheme.surfaceContainer,
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    spacing: 4.0,
                    children: [
                      // Always show general/info tags
                      if (infoTags.isNotEmpty)
                        Wrap(
                          spacing: 4.0,
                          runSpacing: 4.0,
                          children:
                              infoTags.map((tag) {
                                return TagChip(
                                  tag: tag,
                                  onTap: () {
                                    // Handle tag tap if needed
                                  },
                                );
                              }).toList(),
                        ),
                      // Show character tags if enabled
                      if (showCharacterTags && characterTags.isNotEmpty)
                        Wrap(
                          spacing: 4.0,
                          runSpacing: 4.0,
                          children:
                              characterTags.map((tag) {
                                return TagChip(
                                  tag: tag,
                                  onTap: () {
                                    // Handle tag tap if needed
                                  },
                                );
                              }).toList(),
                        ),
                      // Show friendship tags if enabled
                      if (showFriendshipTags && friendshipTags.isNotEmpty)
                        Wrap(
                          spacing: 4.0,
                          runSpacing: 4.0,
                          children:
                              friendshipTags.map((tag) {
                                return TagChip(
                                  tag: tag,
                                  onTap: () {
                                    // Handle tag tap if needed
                                  },
                                );
                              }).toList(),
                        ),
                      // Show romance tags if enabled
                      if (showRomanceTags && romanceTags.isNotEmpty)
                        Wrap(
                          spacing: 4.0,
                          runSpacing: 4.0,
                          children:
                              romanceTags.map((tag) {
                                return TagChip(
                                  tag: tag,
                                  onTap: () {
                                    // Handle tag tap if needed
                                  },
                                );
                              }).toList(),
                        ),
                      // Show freeform tags if enabled
                      if (showFreeformTags && freeformTags.isNotEmpty)
                        Wrap(
                          spacing: 4.0,
                          runSpacing: 4.0,
                          children:
                              freeformTags.map((tag) {
                                return TagChip(
                                  tag: tag,
                                  onTap: () {
                                    // Handle tag tap if needed
                                  },
                                );
                              }).toList(),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
