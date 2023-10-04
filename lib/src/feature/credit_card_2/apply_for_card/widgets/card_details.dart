import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive.dart';

class CardDetails extends StatelessWidget {
  final String title;

  final String subTitle;

  final String desc;

  final Color bgColor;
  final Color titleColor;
  final Color subTitleColor;
  final Color desColor;

  const CardDetails({
    required this.title,
    required this.subTitle,
    required this.desc,
    this.bgColor = GlorifiColors.midnightBlue,
    this.titleColor = GlorifiColors.white,
    this.subTitleColor = GlorifiColors.white,
    this.desColor = GlorifiColors.white,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: bgColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: headlineRegular30Secondary(color: titleColor),
          ).marginOnly(bottom: 46.h),
          Text(
            subTitle,
            style: headlineRegular24Secondary(color: subTitleColor),
          ).marginOnly(bottom: 24.h),
          Text(
            desc,
            style: captionRegular14Primary(color: desColor),
          ),
        ],
      ).paddingOnly(top: 8.h, bottom: 24.h, left: 24.w, right: 32.w),
    );
  }
}
