import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:selene/core/utils/theming.dart';

class Hyperlink extends StatelessWidget {
  const Hyperlink(this.text, {super.key, this.link, this.style});

  final String text;
  final String? link;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        text: text,
        style:
            style?.copyWith(color: context.scheme.primary) ??
            TextStyle(
              color: context.scheme.primary,
              decoration: TextDecoration.underline,
            ),
        recognizer:
            TapGestureRecognizer()
              ..onTap = () {
                // Handle tap on the hyperlink
                // For example, open the link in a web browser
                print('Test');
              },
      ),
    );
  }
}
