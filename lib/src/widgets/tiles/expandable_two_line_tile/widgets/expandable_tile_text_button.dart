import 'package:flutter/material.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive_extensions.dart';

import '../../../../font_style_global.dart';

class ExpandableTileTextButton extends StatelessWidget {
  const ExpandableTileTextButton({Key? key, this.onPressed, required this.text})
      : super(key: key);

  final Function()? onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.h,
      width: double.infinity,
      child: TextButton(
        onPressed: onPressed,
        child: Text(
          text,
          style: captionSemiBold14Primary(
            color: GlorifiColors.midnightBlueColor,
          ),
        ),
      ),
    );
  }
}
