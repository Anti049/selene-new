import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LibraryComponentItem extends ConsumerStatefulWidget {
  const LibraryComponentItem({
    super.key,
    required this.workID,
    required this.isSelected,
    required this.onTap,
    required this.onLongPress,
  });

  final int workID;
  final bool isSelected;
  final Function(int workID) onTap;
  final Function(int workID) onLongPress;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _LibraryComponentItemState();
}

class _LibraryComponentItemState extends ConsumerState<LibraryComponentItem> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
