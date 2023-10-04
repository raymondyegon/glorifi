import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:glorifi/src/feature/cockpit/feed2.0/products/widgets/side_divider.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';

Widget PictureContentItem(
    {imageUrl: String, hint: String, title: String, content: String}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Image.asset(
        imageUrl,
      ),
      ProductContentItem(content: content, title: title, hint: hint),
    ],
  ).paddingOnly(top: 58);
}

Widget ProductContentItem({hint: String, title: String, content: String}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        hint,
        style: captionRegular14Primary(color: GlorifiColors.white),
      ),
      SideDivider().paddingOnly(top: 12),
      Text(
        title,
        style: customGlorifiStyle(
          fontFamily: "Arvo",
          weight: FontWeight.w700,
          size: 28,
          color: GlorifiColors.white,
        ),
      ).paddingOnly(top: 34),
      Text(
        content,
        style: smallRegular16Primary(
          color: GlorifiColors.white,
        ),
      ).paddingOnly(top: 20),
    ],
  ).paddingOnly(top: 32, left: 24, right: 24);
}
