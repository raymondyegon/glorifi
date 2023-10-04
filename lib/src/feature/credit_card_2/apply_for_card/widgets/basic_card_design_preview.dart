import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive.dart';

class BasicCardDesignPreview extends StatelessWidget {
  final String img;
  final String description;

  const BasicCardDesignPreview({
    required this.img,
    required this.description,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8.r),
          child: Image.asset(
            img,
            width: 100.w,
            height: 63.h,
            fit: BoxFit.fill,
          ),
        ).marginOnly(
          right: 8.w,
        ),
        Flexible(
          child: Text(
            description,
            style: captionRegular14Primary(color: GlorifiColors.darkBlue),
          ).paddingOnly(right: 8.w),
        )
      ],
    );
  }
}
