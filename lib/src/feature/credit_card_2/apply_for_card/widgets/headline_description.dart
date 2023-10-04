import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive.dart';

class HeadlineDescription extends StatelessWidget {
  final String title;

  final String desc;

  final Color titleColor;

  final Color descColor;

  const HeadlineDescription({
    required this.title,
    required this.desc,
    this.titleColor = GlorifiColors.midnightBlue,
    this.descColor = GlorifiColors.midnightBlue,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          title,
          style: headlineBold26Primary(color: titleColor),
        ).marginOnly(bottom: 36.h),
        Text(
          desc,
          style: captionRegular14Primary(color: descColor),
        )
      ],
    );
  }
}
