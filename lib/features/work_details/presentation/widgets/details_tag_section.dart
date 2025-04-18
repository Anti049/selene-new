import 'package:flutter/material.dart';
import 'package:selene/core/database/models/tag.dart';
import 'package:selene/features/library/presentation/widgets/tag_chip.dart';

class DetailsTagSection extends StatelessWidget {
  const DetailsTagSection({
    super.key,
    required this.isExpanded,
    required this.tags,
  });

  final bool isExpanded;
  final List<TagModel> tags;

  List<Widget> getTagChildren() {
    return tags
        .map(
          (tag) => TagChip(
            tag: TagModel(name: tag.name, type: tag.type),
            onTap: () {},
          ),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final tagChildren = getTagChildren();
    final padding = const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 4.0);

    if (tagChildren.isEmpty) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: padding,
      child:
          isExpanded
              ? Wrap(spacing: 4.0, runSpacing: 4.0, children: tagChildren)
              : SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(spacing: 4.0, children: tagChildren),
              ),
    );
  }
}
