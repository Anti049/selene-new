import 'dart:ui';

import 'package:auto_route/auto_route.dart';
import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:selene/common/widgets/empty.dart';
import 'package:selene/core/constants/animation_constants.dart';
import 'package:selene/core/constants/ui_constants.dart';
import 'package:selene/core/database/models/tag.dart';
import 'package:selene/core/database/models/work.dart';
import 'package:selene/core/database/providers/library_providers.dart';
import 'package:selene/core/utils/theming.dart';
import 'package:selene/features/banners/models/providers/banner_state_provider.dart';
import 'package:selene/features/settings/screens/appearance/providers/appearance_preferences.dart';
import 'package:selene/features/work_details/presentation/widgets/details_action_row.dart';
import 'package:selene/features/work_details/presentation/widgets/details_tag_section.dart';
import 'package:selene/features/work_details/presentation/widgets/expandable_text.dart';

@RoutePage()
class WorkDetailsPage extends ConsumerStatefulWidget {
  const WorkDetailsPage({super.key, required this.work});

  final WorkModel work;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _WorkDetailsPageState();
}

class _WorkDetailsPageState extends ConsumerState<WorkDetailsPage> {
  // Stateful work model for refreshing
  late WorkModel _work = widget.work;
  // Scroll handlers for FAB
  final ScrollController _scrollController = ScrollController();
  final ValueNotifier<bool> _scrolledToTop = ValueNotifier<bool>(true);
  final ValueNotifier<bool> _scrolledToBottom = ValueNotifier<bool>(false);
  final ValueNotifier<bool> _shouldShowTitle = ValueNotifier<bool>(false);
  final ValueNotifier<double> _appBarOpacity = ValueNotifier<double>(0.0);
  // Expand/collapse state for details
  bool _isExpanded = false;
  double? _titleVisibilityThreshold;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        // Calculate the point where the content below the app bar starts
        // This is the top padding of the content area
        _titleVisibilityThreshold =
            4.0 + kAppBarHeight + context.mediaQuery.viewPadding.top;
      }
    });
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    _scrolledToTop.dispose();
    _scrolledToBottom.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (!mounted || _titleVisibilityThreshold == null) return;

    final offset = _scrollController.offset;
    final scrolledToTop = offset <= 0;
    final scrolledToBottom =
        offset >= _scrollController.position.maxScrollExtent;
    final scrolledUp =
        _scrollController.position.userScrollDirection ==
        ScrollDirection.forward;

    // Determine if the AppBar should be transparent based on scroll offset
    // Transition starts after scrolling a small amount (e.g., 10 pixels)
    final bool shouldShowTitle = offset > _titleVisibilityThreshold!;

    // Update ValueNotifiers (no setState needed for these)
    if (_scrolledToTop.value != scrolledToTop) {
      _scrolledToTop.value = scrolledToTop;
    }
    if (_scrolledToBottom.value != scrolledToBottom || scrolledUp) {
      _scrolledToBottom.value = scrolledToBottom || scrolledUp;
    }

    // Check if the title visibility state needs to change
    if (_shouldShowTitle.value != shouldShowTitle) {
      _shouldShowTitle.value = shouldShowTitle;
    }

    final appBarThreshold = 16.0;
    final appBarOpacity = (offset - appBarThreshold) / (appBarThreshold);
    if (appBarOpacity < 0.0) {
      _appBarOpacity.value = 0.0;
    } else if (appBarOpacity > 1.0) {
      _appBarOpacity.value = 1.0;
    } else {
      _appBarOpacity.value = appBarOpacity;
    }
  }

  Future<void> _refreshWorkDetails(BuildContext context) async {
    // TODO: Fetch basic info from source (AO3, FFN, etc.)
    // Re-fetch work from database
    WorkModel? work = await ref
        .read(worksRepositoryProvider)
        .getWorkById(widget.work.id!);
    if (work == null) {
      // Show error snackbar
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to refresh work details')),
        );
      }
      return;
    }
    setState(() {
      _work = work;
    });
  }

  Widget _buildBackgroundGradient(BuildContext context) {
    // Get providers
    final isTopBannerVisible = ref.watch(isTopBannerAreaCoveredProvider);

    // Return an empty box if there's no cover URL
    if (_work.coverURL.isNullOrBlank) {
      return const SizedBox.shrink();
    }

    // Define the height
    double gradientHeight =
        240.0 - (isTopBannerVisible ? context.mediaQuery.viewPadding.top : 0.0);

    return Container(
      width: double.infinity,
      height: gradientHeight,
      decoration: BoxDecoration(),
      clipBehavior: Clip.antiAlias,
      child: ShaderMask(
        blendMode: BlendMode.dstIn,
        shaderCallback: (Rect bounds) {
          return LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.white.withValues(alpha: 0.75), // Start with some opacity
              Colors.white.withValues(alpha: 0.0), // Fade to fully transparent
            ],
            // Ensure fade completes slightly before the bottom edge
            stops: const [0.0, 1.0],
          ).createShader(bounds);
        },
        child: ImageFiltered(
          imageFilter: ImageFilter.blur(
            sigmaX: 10.0, // Let's try reducing the blur slightly
            sigmaY: 10.0,
            // Revert to decal, often works best with clipping
            tileMode: TileMode.decal,
          ),
          // Clip the ImageFiltered content itself
          child: ClipRect(
            child: Image.network(
              _work.coverURL!,
              fit: BoxFit.cover,
              // Ensure the image slightly overflows the container height
              // BEFORE blurring, so the blur has edge pixels to work with.
              // This might require adjusting the height based on sigma.
              // A simpler approach is to rely on BoxFit.cover and clipping.
              // height: gradientHeight + (10.0 * 2), // Example: Add sigma * 2
              // width: double.infinity, // Keep width infinite
              errorBuilder:
                  (context, error, stackTrace) =>
                      Container(color: Colors.transparent),
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) {
                  return child;
                }
                return Container(color: context.scheme.surfaceContainer);
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCoverImage(BuildContext context) {
    final aspectRatio = 3.0 / 4.0; // 3:4 aspect ratio
    final imageHeight = 140.0;
    final imageWidth = imageHeight * aspectRatio; // 3:4 aspect ratio
    return Container(
      constraints: BoxConstraints(
        maxHeight: imageHeight, // Fixed height for cover image
        maxWidth: imageWidth, // Fixed width for cover image
        minHeight: imageHeight, // Ensure it doesn't shrink below this height
        minWidth: imageWidth, // Ensure it doesn't shrink below this width
      ),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.0)),
      clipBehavior: Clip.antiAlias,
      child: AspectRatio(
        aspectRatio: 3.0 / 4.0,
        child:
            _work.coverURL.isNotNullOrBlank
                ? Image.network(
                  _work.coverURL!,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) {
                      return child; // Image is fully loaded
                    }
                    return Center(
                      child: CircularProgressIndicator(
                        value:
                            loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                    (loadingProgress.expectedTotalBytes ?? 1)
                                : null,
                      ),
                    );
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: context.scheme.surfaceContainerHigh,
                      child: Icon(
                        Symbols.broken_image,
                        size: 64.0,
                        color: context.scheme.onSurface,
                      ),
                    );
                  },
                )
                : Material(
                  color: context.scheme.surfaceContainerHigh,
                  child: InkWell(
                    onTap: () {},
                    child: Container(
                      alignment: Alignment.center,
                      child: Empty(
                        style: context.text.titleLarge?.copyWith(
                          color: context.scheme.onSurface,
                        ),
                      ),
                    ),
                  ),
                ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Get providers
    final isTopBannerVisible = ref.watch(isTopBannerAreaCoveredProvider);
    final appearancePrefs = ref.watch(appearancePreferencesProvider);

    // Return the main Scaffold widget
    final bottomPadding = 80.0 + context.mediaQuery.systemGestureInsets.bottom;
    return Scaffold(
      primary: !isTopBannerVisible,
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        // Wrap AppBar with PreferredSize for correct height
        preferredSize: Size.fromHeight(
          kAppBarHeight, // Adjust for top banner
        ), // Or your desired AppBar height
        child: ValueListenableBuilder<double>(
          // Listen to _appBarOpacity for background
          valueListenable: _appBarOpacity,
          builder: (context, opacityValue, child) {
            return AppBar(
              primary: !isTopBannerVisible,
              title: ValueListenableBuilder<bool>(
                // Listen to _shouldShowTitle for title opacity
                valueListenable: _shouldShowTitle,
                builder: (context, shouldShow, child) {
                  // Use AnimatedOpacity directly, driven by the builder
                  return AnimatedOpacity(
                    opacity: shouldShow ? 1.0 : 0.0,
                    duration: kAnimationDuration,
                    curve: kAnimationCurve,
                    child: Text(_work.title),
                  );
                },
              ),
              backgroundColor: ElevationOverlay.applySurfaceTint(
                context.theme.appBarTheme.backgroundColor ??
                    context.scheme.surface,
                context.theme.appBarTheme.surfaceTintColor ??
                    context.scheme.surfaceTint,
                context.theme.appBarTheme.scrolledUnderElevation ?? 3.0,
              ).withValues(alpha: opacityValue),
              elevation: 0.0, // Keep these as needed
              scrolledUnderElevation: 0.0, // Keep these as needed
              // You might need to explicitly pass leading/actions if they don't depend on the notifiers
              // leading: ...,
              // actions: ...,
            );
          },
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () => _refreshWorkDetails(context),
        child: RawScrollbar(
          controller: _scrollController,
          interactive: true,
          thickness: 8.0,
          radius: const Radius.circular(4.0),
          trackVisibility: true,
          padding: EdgeInsets.only(
            bottom: bottomPadding,
            top:
                4.0 +
                kAppBarHeight +
                (isTopBannerVisible ? 0.0 : context.mediaQuery.viewPadding.top),
            right: 4.0,
          ),
          thumbColor: Theme.of(context).colorScheme.primary,
          child: ListView(
            controller: _scrollController,
            physics: AlwaysScrollableScrollPhysics(),
            padding: EdgeInsets.only(bottom: bottomPadding),
            children: [
              // Header section
              IntrinsicHeight(
                child: Stack(
                  children: [
                    if (!appearancePrefs.einkMode.get())
                      _buildBackgroundGradient(context),
                    Padding(
                      padding: EdgeInsets.only(
                        top:
                            kAppBarHeight +
                            (isTopBannerVisible
                                ? 0.0
                                : context.mediaQuery.viewPadding.top),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: IntrinsicHeight(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: 16.0,
                            children: [
                              // Book Cover
                              if (true) _buildCoverImage(context),
                              // Work Details
                              Expanded(
                                child: Center(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    spacing: 4.0,
                                    children: [
                                      // Title
                                      Text(
                                        _work.title,
                                        style: context.text.titleLarge
                                            ?.copyWith(
                                              color: context.scheme.onSurface,
                                            ),
                                      ),
                                      // Fandom(s)
                                      Row(
                                        spacing: 8.0,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Symbols.auto_stories,
                                            size: 20,
                                            weight: 600,
                                            color:
                                                context.scheme.onSurfaceVariant,
                                          ),
                                          Flexible(
                                            child: Text(
                                              _work.fandomNames,
                                              style: context.text.labelLarge
                                                  ?.copyWith(
                                                    color:
                                                        context
                                                            .scheme
                                                            .onSurfaceVariant,
                                                  ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      // Author(s)
                                      Row(
                                        spacing: 8.0,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Symbols.person,
                                            size: 20,
                                            weight: 600,
                                            color:
                                                context.scheme.onSurfaceVariant,
                                          ),
                                          Flexible(
                                            child: Text(
                                              _work.authorNames,
                                              style: context.text.labelLarge
                                                  ?.copyWith(
                                                    color:
                                                        context
                                                            .scheme
                                                            .onSurfaceVariant,
                                                  ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const Divider(height: 2.0),
                                      // Book Published Date
                                      Row(
                                        spacing: 8.0,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Symbols.publish,
                                            size: 20,
                                            weight: 600,
                                            color:
                                                context.scheme.onSurfaceVariant,
                                          ),
                                          Flexible(
                                            child: Text(
                                              'Published • ${_work.datePublished?.toLocal().toIso8601String().split('T').first ?? 'Unknown'}',
                                              style: context.text.labelMedium
                                                  ?.copyWith(
                                                    color:
                                                        context
                                                            .scheme
                                                            .onSurfaceVariant,
                                                  ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      // Book Updated/Completed Date
                                      Row(
                                        spacing: 8.0,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Icon(
                                            _work.status == WorkStatus.completed
                                                ? Symbols.check_circle
                                                : Symbols.update,
                                            size: 20,
                                            weight: 600,
                                            color:
                                                context.scheme.onSurfaceVariant,
                                          ),
                                          Flexible(
                                            child: Text(
                                              '${_work.status == WorkStatus.completed ? 'Completed' : 'Updated'} • ${_work.dateUpdated?.toLocal().toIso8601String().split('T').first ?? 'Unknown'}',
                                              style: context.text.labelMedium
                                                  ?.copyWith(
                                                    color:
                                                        context
                                                            .scheme
                                                            .onSurfaceVariant,
                                                  ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Actions section
              DetailsActionRow(
                onLibraryTap: () {},
                isInLibrary: true,
                onPredictionTap: () {},
                onNotificationTap: () {},
                sourceURL: _work.sourceURL,
              ),
              // Summary section
              Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8.0),
                child: ExpandableText(
                  text: _work.summary ?? '',
                  maxLines: 3,
                  onExpanded: (value) {
                    setState(() {
                      _isExpanded = value;
                    });
                  },
                ),
              ),
              // Tags section
              ...[
                if (_work.tags.isNotEmpty)
                  for (final type in TagType.values)
                    if (_work.tags.any((tag) => tag.type == type))
                      DetailsTagSection(
                        isExpanded: _isExpanded,
                        tags:
                            _work.tags
                                .where((tag) => tag.type == type)
                                .toList(),
                      ),
              ],
              SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 8.0,
                  ),
                  child: Text(
                    '${_work.chapters.length} Chapters',
                    style: context.text.titleMedium,
                  ),
                ),
              ),
              Column(
                children: [
                  for (var i = 0; i < _work.chapters.length; i++)
                    ListTile(
                      title: Text('Chapter ${_work.chapters[i].index + 1}'),
                      subtitle: Text(_work.chapters[i].title),
                      trailing: Icon(Symbols.chevron_right),
                      onTap: () {
                        // context.router.push(
                        //   ReaderRoute(work: _work, chapter: i),
                        // );
                      },
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: ValueListenableBuilder<bool>(
        valueListenable: _scrolledToTop,
        builder: (context, scrolledToTop, child) {
          return ValueListenableBuilder<bool>(
            valueListenable: _scrolledToBottom,
            builder: (context, scrolledToBottom, child) {
              return FloatingActionButton.extended(
                onPressed: () {
                  // context.router.push(ReaderRoute(work: _work));
                },
                label: AnimatedSize(
                  duration: Duration(milliseconds: 200),
                  curve: Curves.easeInOut,
                  child:
                      scrolledToTop || scrolledToBottom
                          ? Text('Start Reading')
                          : const SizedBox(width: 0.0, height: 0.0),
                ),
                extendedIconLabelSpacing:
                    scrolledToTop || scrolledToBottom ? null : 0.0,
                extendedPadding:
                    scrolledToTop || scrolledToBottom
                        ? null
                        : EdgeInsets.all(16.0),
                icon: Icon(Symbols.play_arrow, fill: 1.0),
              );
            },
          );
        },
      ),
    );
  }
}
