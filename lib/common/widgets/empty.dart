import 'dart:math';

import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:selene/core/utils/theming.dart';

const kEmptyFaces = [
  "(･o･;)",
  "Σ(ಠ_ಠ)",
  "ಥ_ಥ",
  "(˘･_･˘)",
  "(；￣Д￣)",
  "(･Д･。",
  "(╯︵╰,)",
  "૮(˶ㅠ︿ㅠ)ა",
  "(っ◞‸◟ c)",
  "｡°(°.◜ᯅ◝°)°｡",
  "(≥o≤)",
  "(╥﹏╥)",
  "(´；д；`)",
  "( •ө• )",
  "(·•᷄‎ࡇ•᷅ )",
];

class Empty extends HookWidget {
  const Empty({
    super.key,
    this.message,
    this.subtitle,
    this.actions,
    this.style,
  });

  final String? message;
  final String? subtitle;
  final List<Widget>? actions;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    int errorIndex = useState(Random().nextInt(kEmptyFaces.length)).value;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            kEmptyFaces[errorIndex],
            style:
                style ??
                context.text.displayMedium?.copyWith(
                  color: context.scheme.secondary,
                ),
          ),
          if (message.isNotNullOrBlank)
            Baseline(
              baseline: 24.0,
              baselineType: TextBaseline.alphabetic,
              child: Text(
                message ?? '', // Fallback to empty string if null
                style: context.text.titleLarge?.copyWith(
                  color: context.scheme.secondary,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          if (subtitle.isNotNullOrBlank)
            Baseline(
              baseline: 24.0,
              baselineType: TextBaseline.alphabetic,
              child: Text(
                subtitle ?? '',
                style: context.text.titleMedium?.copyWith(
                  color: context.scheme.secondary,
                  fontWeight: FontWeight.normal,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          if (actions?.isNotEmpty ?? false)
            Padding(
              padding: const EdgeInsets.only(top: 24.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: actions ?? [],
              ),
            ),
        ],
      ),
    );
  }
}
