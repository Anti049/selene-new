import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:selene/common/widgets/action_button.dart';
import 'package:selene/core/utils/theming.dart';

class DetailsActionRow extends StatelessWidget {
  const DetailsActionRow({
    super.key,
    required this.onLibraryTap,
    this.isInLibrary = false,
    required this.onPredictionTap,
    this.isPredictedSoon = false,
    required this.onNotificationTap,
    this.shouldNotify = false,
    required this.sourceURL,
  });

  final VoidCallback onLibraryTap;
  final bool isInLibrary;
  final VoidCallback onPredictionTap;
  final bool isPredictedSoon;
  final VoidCallback onNotificationTap;
  final bool shouldNotify;
  final String? sourceURL;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        spacing: 4.0,
        children: [
          Expanded(
            child: ActionButton(
              label: 'Add to Library',
              icon: Symbols.favorite,
              filled: isInLibrary,
              color:
                  isInLibrary
                      ? context.scheme.primary
                      : context.scheme.onSurfaceVariant.withValues(alpha: 0.5),
              onPressed: onLibraryTap,
            ),
          ),
          Expanded(
            child: ActionButton(
              label: 'On Hiatus',
              icon: Symbols.hourglass,
              filled: isPredictedSoon,
              color:
                  isPredictedSoon
                      ? context.scheme.primary
                      : context.scheme.onSurfaceVariant.withValues(alpha: 0.5),
              onPressed: onPredictionTap,
            ),
          ),
          Expanded(
            child: ActionButton(
              label: 'Notify on Update',
              icon: Symbols.notifications,
              filled: shouldNotify,
              color:
                  shouldNotify
                      ? context.scheme.primary
                      : context.scheme.onSurfaceVariant.withValues(alpha: 0.5),
              onPressed: onNotificationTap,
            ),
          ),
          Expanded(
            child: ActionButton(
              label: 'Open in WebView',
              icon: Symbols.public,
              color:
                  sourceURL.isNotNullOrBlank
                      ? context.scheme.onSurfaceVariant
                      : context.scheme.onSurfaceVariant.withValues(alpha: 0.5),
              onPressed: () {
                // Handle source URL tap, e.g., open in browser
                // You can use a package like url_launcher to open the URL
              },
            ),
          ),
        ],
      ),
    );
  }
}
