import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:selene/core/utils/theming.dart';

class ThemedLogo extends StatelessWidget {
  const ThemedLogo({super.key, this.size = 128.0, this.color, this.padding});

  final double size;
  final Color? color;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    final logoColor = color ?? context.scheme.primary;

    return Container(
      padding: padding,
      alignment: Alignment.center,
      child: SvgPicture.asset(
        'assets/images/logo.svg',
        colorFilter: ColorFilter.mode(logoColor, BlendMode.srcIn),
        width: size,
        height: size,
      ),
    );
  }
}
