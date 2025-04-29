import 'package:animated_visibility/animated_visibility.dart';
import 'package:auto_route/auto_route.dart';
import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:selene/core/constants/animation_constants.dart';
import 'package:selene/core/database/models/chapter.dart';
import 'package:selene/core/database/models/work.dart';
import 'package:selene/core/database/providers/library_providers.dart';
import 'package:selene/core/utils/theming.dart';
import 'package:selene/data/remote/work_service_registry.dart';
import 'package:selene/features/download_queue/models/download_task.dart';
import 'package:selene/features/download_queue/providers/download_queue_provider.dart';
import 'package:selene/routing/router.gr.dart';

class ChapterWidget extends ConsumerStatefulWidget {
  const ChapterWidget({super.key, required this.chapterID, this.work});

  final int chapterID;
  final WorkModel? work;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ChapterWidgetState();
}

class _ChapterWidgetState extends ConsumerState<ChapterWidget>
    with SingleTickerProviderStateMixin {
  bool _isLoaded = false;
  bool _isLoading = false;
  double? _loadProgress;
  bool _isRead = false;
  ChapterModel? _chapter;

  // Progress animation
  late AnimationController _animationController;
  late Animation<double> _progressAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: kAnimationDuration,
      vsync: this,
    );
    _progressAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: kAnimationCurve),
    );
    _isLoaded = _chapter?.content.isNotNullOrBlank ?? false;
    // Load the chapter data
    final chapterRepository = ref.read(chapterRepositoryProvider);
    chapterRepository.getChapterByID(widget.chapterID).then((chapter) {
      setState(() {
        _chapter = chapter;
        _isLoaded = chapter?.content.isNotNullOrBlank ?? false;
        _isRead = false;
      });
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _updateProgress(double newProgress) {
    setState(() {
      _progressAnimation = Tween<double>(
        begin: _loadProgress ?? 0.0,
        end: newProgress,
      ).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
      );
      _loadProgress = newProgress;
    });
    _animationController.forward(from: 0.0);
  }

  void _loadChapter() async {
    setState(() {
      _isLoading = true;
      _loadProgress = null;
      _isLoaded = false;
    });

    if (_chapter == null) {
      // If chapter is not loaded, fetch it from the repository
      final chapterRepository = ref.read(chapterRepositoryProvider);
      _chapter = await chapterRepository.getChapterByID(widget.chapterID);
      if (_chapter == null) {
        setState(() {
          _isLoading = false;
          _loadProgress = 0.0; // Simulate load failure
          _isLoaded = false;
        });
        return;
      }
    }

    final workServiceRegistry = ref.read(workServiceRegistryProvider);
    final workService = workServiceRegistry.getServiceByURL(
      _chapter!.sourceURL,
    );
    ChapterModel? loadedChapter = await workService?.downloadChapter(
      _chapter!,
      onProgress: ({int? progress, int? total, String? message}) {
        if (progress != null && total != null) {
          _updateProgress(progress / total);
        } else if (message != null) {
          // Handle any messages from the download process
          print(message); // For debugging purposes
        }
      },
    );
    if (loadedChapter == null) {
      setState(() {
        _isLoading = false;
        _loadProgress = 0.0; // Simulate load failure
        _isLoaded = false;
      });
      return;
    }

    // Update the repository with the loaded chapter
    final chapterRepository = ref.read(chapterRepositoryProvider);
    loadedChapter = await chapterRepository.upsertChapter(loadedChapter);

    setState(() {
      _isLoading = false;
      _loadProgress = 1.0; // Simulate load completion
      _isLoaded = true;
      _chapter = loadedChapter;
    });
  }

  @override
  Widget build(BuildContext context) {
    final downloadQueue = ref.watch(downloadQueueProvider);
    final chapterTask = downloadQueue.queue.firstOrNullWhere(
      (task) => task.chapterId == widget.chapterID,
    );
    // TODO: Implement read status handling
    // TODO: Implement skeleton loading state
    if (_chapter == null) {
      return ListTile(
        title: Text('Loading chapter...'),
        subtitle: Text('Please wait while the chapter is being loaded.'),
        trailing: CircularProgressIndicator(),
      );
    }
    return ListTile(
      title: Row(
        spacing: 8.0,
        children: [
          if (!_isRead)
            Container(
              width: 6.0,
              height: 6.0,
              decoration: BoxDecoration(
                color: context.scheme.primary,
                shape: BoxShape.circle,
              ),
            ),
          Text('Chapter ${_chapter!.index}'),
        ],
      ),
      subtitle: Text(_chapter!.title),
      trailing: AnimatedCrossFade(
        duration: kAnimationDuration,
        firstCurve: kAnimationCurve,
        secondCurve: kAnimationCurve,
        sizeCurve: kAnimationCurve,
        firstChild: IconButton(
          icon: Stack(
            children: [
              Positioned.fill(
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: AnimatedVisibility(
                    visible: chapterTask != null && !_isLoaded,
                    enter: fadeIn(curve: kAnimationCurve),
                    enterDuration: kAnimationDuration,
                    exit: fadeOut(curve: kAnimationCurve),
                    exitDuration: kAnimationDuration,
                    child:
                        _loadProgress != null
                            ? AnimatedBuilder(
                              animation: _progressAnimation,
                              builder: (context, child) {
                                return CustomPaint(
                                  painter: PieChartPainter(
                                    _progressAnimation.value,
                                    context.scheme.primary,
                                  ),
                                );
                              },
                            )
                            : CircularProgressIndicator(
                              color: context.scheme.onSurfaceVariant,
                              strokeWidth: 2.0,
                            ),
                  ),
                ),
              ),
              Icon(
                Symbols.arrow_downward_alt,
                color:
                    _isLoading && ((_loadProgress ?? 0) >= 0.5)
                        ? context.scheme.onPrimary
                        : context.scheme.onSurfaceVariant,
                size: 32.0,
              ),
            ],
          ),
          onPressed: () {
            if (_chapter != null && widget.work != null) {
              final task = DownloadTask(
                taskId: _chapter!.sourceURL ?? 'chapter_${_chapter!.id!}',
                workId: widget.work!.id!,
                workTitle: widget.work!.title,
                chapterId: _chapter!.id!,
                chapterTitle: _chapter!.title,
              );
              ref.read(downloadQueueProvider.notifier).addTask(task);
            }
          },
        ),
        secondChild: IconButton(
          icon: Icon(
            Symbols.check_circle,
            size: 28.0,
            fill: 1.0,
            color: context.scheme.primary,
          ),
          onPressed: () {
            // Handle chapter read action
            // setState(() {
            //   _isRead = !_isRead;
            // });
            // _loadChapter(); // Reload to update read status
          },
        ),
        crossFadeState:
            _isLoaded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
      ),
      onTap: () {
        if (widget.work != null) {
          context.router.push(ReaderRoute(work: widget.work!));
          return;
        }
      },
    );
  }
}

class PieChartPainter extends CustomPainter {
  final double progress; // Progress value (0.0 to 1.0)
  final Color color; // Color of the pie chart

  PieChartPainter(this.progress, this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = color
          ..style = PaintingStyle.fill;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    // Draw the pie chart arc
    final sweepAngle =
        2 * 3.141592653589793 * progress; // Convert progress to radians
    final rect = Rect.fromCircle(center: center, radius: radius);
    canvas.drawArc(rect, -3.141592653589793 / 2, sweepAngle, true, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true; // Always repaint when progress changes
  }
}
