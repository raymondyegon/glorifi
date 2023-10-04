import 'package:flutter/material.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';

import '../../../font_style_global.dart';

class TitleTextWidget extends StatelessWidget {
  const TitleTextWidget({Key? key, required this.titleText, this.style})
      : super(key: key);

  final titleText;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return Text(
      titleText,
      style: style ??
          bodyRegular18Secondary(
            color: GlorifiColors.cornflowerBlue,
          ),
    );
  }
}
