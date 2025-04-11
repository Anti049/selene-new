import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:selene/core/constants/animation_constants.dart';
import 'package:selene/core/utils/theming.dart';

class ThemedLogo extends StatelessWidget {
  const ThemedLogo({super.key, this.size = 128.0});

  final double size;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      curve: kAnimationCurve,
      duration: kAnimationDuration,
      width: size,
      height: size,
      child: SvgPicture.asset(
        'assets/images/logo.svg',
        colorFilter: ColorFilter.mode(context.scheme.primary, BlendMode.srcIn),
        semanticsLabel: 'App Logo',
      ),
    );
  }
}
