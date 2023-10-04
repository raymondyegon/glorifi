import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';

import '../../../font_style_global.dart';

class TextWithNextButton extends StatelessWidget {
  const TextWithNextButton({
    required this.text,
    this.onTap,
    Key? key,
  }) : super(key: key);

  final String text;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(minHeight: 48),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            text,
            style: smallBold16Primary(),
          ),
          Spacer(),
          if (onTap != null)
            IconButton(
              padding: EdgeInsets.all(0),
              alignment: Alignment.topRight,
              icon: SvgPicture.asset(
                'assets/icons/caret_right_small.svg',
                color: GlorifiColors.black,
              ),
              onPressed: onTap,
            ),
        ],
      ),
    );
  }
}
