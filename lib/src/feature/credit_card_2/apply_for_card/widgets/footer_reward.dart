import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive.dart';
import 'package:glorifi/src/utils/text_constants.dart';

class FooterReward extends StatelessWidget {
  final String reward;
  final String apr;
  final int annualFee;
  final bool isFromBrassDetailsScreen;

  const FooterReward(
      {required this.reward,
      required this.apr,
      required this.annualFee,
      Key? key,
      required this.isFromBrassDetailsScreen})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: isFromBrassDetailsScreen ? MainAxisAlignment.start : MainAxisAlignment.spaceBetween,
      children: [
        !isFromBrassDetailsScreen ?
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              TextConstants.rewards,
              style: captionRegular14Primary(color: GlorifiColors.darkBlue),
            ).marginOnly(bottom: 8.h),
            Text(
              reward,
              style: captionBold14Primary(color: GlorifiColors.darkBlue),
            ).marginOnly(bottom: 8.h)
          ],
        ) : SizedBox(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              TextConstants.APR,
              style: captionRegular14Primary(color: GlorifiColors.darkBlue),
            ).marginOnly(bottom: 8.h),
            Text(
              apr,
              style: captionBold14Primary(color: GlorifiColors.darkBlue),
            ).marginOnly(bottom: 8.h)
          ],
        ),
        isFromBrassDetailsScreen ? Spacer() : SizedBox(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              TextConstants.annualFee,
              style: captionRegular14Primary(color: GlorifiColors.darkBlue),
            ).marginOnly(bottom: 8.h),
            Text(
              "\$$annualFee",
              style: captionBold14Primary(
                  color: annualFee > 0
                      ? GlorifiColors.darkBlue
                      : GlorifiColors.redError),
            ).marginOnly(bottom: 8.h)
          ],
        )
      ],
    ).marginOnly(bottom: 30.h);
  }
}
