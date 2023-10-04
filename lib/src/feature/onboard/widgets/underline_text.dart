import 'package:flutter/material.dart';
import 'package:glorifi/src/utils/glorifi_text_styles.dart';
import 'package:glorifi/src/widgets/tap/ripple.dart';

class UnderlineText extends StatelessWidget {
  final Function()? onTap;
  final String text;
  final Color textColor;
  final double textSize;
  final int decorationThickness;

  const UnderlineText({
    Key? key,
    required this.text,
    this.onTap,
    this.textColor = Colors.white,
    this.textSize = 14,
    this.decorationThickness = 2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Ripple(
      onTap: onTap,
      child: Text(text,
          style: sansBoldStyle.copyWith(
            fontSize: textSize,
            height: 1.36,
            shadows: [Shadow(color: Colors.white, offset: Offset(0, -1.2))],
            color: Colors.transparent,
            decoration: TextDecoration.underline,
            decorationColor: Colors.white,
            decorationThickness: 2,
          )),
    );
  }
}
