import 'package:flutter/material.dart';
import 'package:selene/core/utils/theming.dart';

class ActionButton extends StatelessWidget {
  const ActionButton({
    super.key,
    required this.label,
    required this.icon,
    required this.onPressed,
    this.color,
    this.filled = false,
  });

  final String label;
  final IconData icon;
  final VoidCallback onPressed;
  final Color? color;
  final bool filled;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 4.0,
          children: [
            Icon(
              icon,
              fill: filled ? 1.0 : 0.0,
              size: 24.0,
              color: color ?? context.scheme.onSurfaceVariant,
            ),
            Text(
              '$label\n',
              maxLines: 2,
              textAlign: TextAlign.center,
              style: context.text.labelMedium?.copyWith(
                color: color ?? context.scheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
