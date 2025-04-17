import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:selene/common/widgets/empty.dart';
import 'package:selene/common/widgets/padded_app_bar.dart';
import 'package:selene/core/constants/ui_constants.dart';
import 'package:selene/core/database/models/work.dart';
import 'package:selene/core/database/providers/library_providers.dart';
import 'package:selene/core/utils/theming.dart';
import 'package:selene/features/work_details/providers/work_details_provider.dart';

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
  // Expand/collapse state for details
  final ValueNotifier<bool> _isExpanded = ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
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
    final scrolledToTop = _scrollController.offset <= 0;
    final scrolledToBottom =
        _scrollController.offset >= _scrollController.position.maxScrollExtent;

    // Update ValueNotifier values only if they change
    if (_scrolledToTop.value != scrolledToTop) {
      _scrolledToTop.value = scrolledToTop;
    }
    if (_scrolledToBottom.value != scrolledToBottom) {
      _scrolledToBottom.value = scrolledToBottom;
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
      _work = widget.work; // Reset to original work for demo purposes
    });
  }

  Widget _buildCoverImage(BuildContext context) {
    return Container(
      height: 140.0,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.0)),
      clipBehavior: Clip.antiAlias,
      child: AspectRatio(
        aspectRatio: 3.0 / 4.0,
        child:
            _work.coverURL != null
                ? Image.network(
                  'https://placehold.co/900x1200.svg' ?? '',
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
    return Scaffold(
      appBar: AppBar(title: Text('Lorem Ipsum Pluras Anum Extantus')),
      body: RefreshIndicator(
        onRefresh: () => _refreshWorkDetails(context),
        child: RawScrollbar(
          controller: _scrollController,
          interactive: true,
          thickness: 8.0,
          radius: const Radius.circular(4.0),
          trackVisibility: true,
          padding: const EdgeInsets.only(bottom: 80.0, top: 4.0, right: 4.0),
          thumbColor: Theme.of(context).colorScheme.primary,
          child: ListView(
            controller: _scrollController,
            padding: EdgeInsets.only(bottom: 80.0),
            children: [
              // Header section
              Padding(
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: 8.0,
                            children: [
                              // Title
                              Text(
                                _work.title,
                                style: context.text.titleLarge?.copyWith(
                                  color: context.scheme.onSurface,
                                ),
                              ),
                              // Fandom(s)
                              Row(
                                spacing: 8.0,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Symbols.auto_stories,
                                    size: 20,
                                    weight: 600,
                                    color: context.scheme.onSurfaceVariant,
                                  ),
                                  Flexible(
                                    child: Text(
                                      _work.fandomNames,
                                      style: context.text.labelLarge?.copyWith(
                                        color: context.scheme.onSurfaceVariant,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              // Author(s)
                              Row(
                                spacing: 8.0,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Symbols.person,
                                    size: 20,
                                    weight: 600,
                                    color: context.scheme.onSurfaceVariant,
                                  ),
                                  Flexible(
                                    child: Text(
                                      _work.authorNames,
                                      style: context.text.labelLarge?.copyWith(
                                        color: context.scheme.onSurfaceVariant,
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
            ],
          ),
        ),
      ),
    );
  }
}
