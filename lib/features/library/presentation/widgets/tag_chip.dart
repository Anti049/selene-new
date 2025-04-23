import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:selene/core/database/models/tag.dart';
import 'package:selene/core/utils/theming.dart';

class TagChip extends StatelessWidget {
  const TagChip({super.key, required this.tag, this.onTap});

  final TagModel tag;
  final VoidCallback? onTap;

  IconData? get icon {
    return switch (tag.type) {
      TagType.info => null,
      TagType.fandom => Symbols.warning,
      TagType.character => Symbols.person,
      TagType.friendship => Symbols.group,
      TagType.romance => Symbols.favorite,
      TagType.freeform => null,
      TagType.other => null,
    };
  }

  Color backgroundColor(BuildContext context) {
    return switch (tag.type) {
      TagType.info => context.scheme.primaryContainer,
      TagType.character => context.scheme.secondaryContainer,
      TagType.friendship => context.scheme.tertiaryContainer,
      TagType.romance => context.scheme.tertiary,
      _ => context.scheme.surfaceContainer,
    };
  }

  Color textColor(BuildContext context) {
    return switch (tag.type) {
      TagType.info => context.scheme.onPrimaryContainer,
      TagType.character => context.scheme.onSecondaryContainer,
      TagType.friendship => context.scheme.onTertiaryContainer,
      TagType.romance => context.scheme.onTertiary,
      _ => context.scheme.onSurfaceVariant,
    };
  }

  @override
  Widget build(BuildContext context) {
    return ActionChip(
      labelPadding: EdgeInsets.fromLTRB(
        icon != null ? 0.0 : 4.0,
        0.0,
        4.0,
        0.0,
      ),
      label: Row(
        spacing: 8.0,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 16.0, fill: 1.0, color: textColor(context)),
          ],
          Flexible(
            child: Text(
              tag.name,
              style: context.text.labelMedium?.copyWith(
                color: textColor(context),
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              softWrap: false,
            ),
          ),
        ],
      ),
      onPressed: onTap,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4.0),
        side: BorderSide(color: textColor(context).withValues(alpha: 0.5)),
      ),
      color: WidgetStateProperty.fromMap({
        WidgetState.any: backgroundColor(context),
      }),
    );
  }
}
