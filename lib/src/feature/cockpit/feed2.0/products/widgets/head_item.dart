import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:glorifi/src/feature/cockpit/feed2.0/products/widgets/side_divider.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';

Widget HeadItem(BuildContext context,
    {imageUrl: String,
    hint: String,
    title: String,
    content: String,
    arriving: String}) {
  return Column(
    children: [
      Stack(
        children: [
          Image.asset(
            imageUrl,
            height: 450,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
          ).paddingAll(imageUrl == 'assets/images/products/cards.png' ? 32 : 0),
          Positioned(
            bottom: 0,
            child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: FractionalOffset.topCenter,
                  end: FractionalOffset.bottomCenter,
                  colors: [
                    GlorifiColors.midnightBlue.withOpacity(0.0),
                    GlorifiColors.midnightBlue.withOpacity(0.5),
                    GlorifiColors.midnightBlue.withOpacity(0.8),
                    GlorifiColors.midnightBlue,
                    GlorifiColors.midnightBlue,
                  ],
                  stops: [0.0, 0.3, 0.5, 0.6, 1.0],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        hint.toString().toUpperCase(),
                        style: captionSemiBold14Primary(
                            color: GlorifiColors.white),
                      )
                    ],
                  ),
                  SideDivider().paddingOnly(top: 15)
                ],
              ).paddingAll(32).paddingOnly(top: 64),
            ),
          )
        ],
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: customGlorifiStyle(
              fontFamily: "Arvo",
              weight: FontWeight.w700,
              size: 28,
              color: GlorifiColors.white,
            ),
          ),
          Text(
            content,
            style: smallRegular16Primary(
              color: GlorifiColors.white,
            ),
          ).paddingOnly(top: 15),
          if (arriving.length > 0)
            Text(
              arriving,
              style: customGlorifiStyle(
                  fontFamily: 'Arvo',
                  weight: FontWeight.bold,
                  size: 16,
                  color: GlorifiColors.lightBlue),
            ).paddingOnly(top: 24)
        ],
      ).paddingOnly(left: 32, right: 32)
    ],
  );
}
