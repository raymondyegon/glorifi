import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/utils/glorifi_assets.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive.dart';
import 'package:glorifi/src/utils/text_constants.dart';
import 'headline_description.dart';
import 'simple_credit_card_benefits.dart';

class DescriptiveBenefitsCard extends StatelessWidget {
  final List<String> benefits;
  final String title;
  final String desc;

  const DescriptiveBenefitsCard({
    required this.benefits,
    required this.title,
    required this.desc,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: GlorifiColors.midnightBlue,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            TextConstants.moreBenefits,
            style: captionBold14Primary(
              color: GlorifiColors.white,
            ),
          ).marginOnly(
            left: 24.w,
            right: 32.w,
            bottom: 18.h,
          ),
          Divider(
            thickness: 2.h,
            color: GlorifiColors.greyD9,
          ).marginOnly(
            left: 24.w,
            right: 32.w,
            bottom: 20.h,
          ),
          SimpleCreditCardBenefits(
            benefits: benefits,
            textColor: GlorifiColors.white,
            iconColor: GlorifiColors.white,
          ).marginOnly(
            left: 24.w,
            right: 32.w,
            bottom: 50.h,
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(8.r),
            child: Image.asset(
              GlorifiAssets.gloriFiBrassCard,
              width: 152.w,
              height: 95.h,
              fit: BoxFit.fill,
            ),
          ).paddingOnly(
            left: 24.w,
            right: 32.w,
            bottom: 15.h,
          ),
          HeadlineDescription(
            title: title,
            titleColor: GlorifiColors.white,
            desc: desc,
            descColor: GlorifiColors.white,
          ).marginOnly(
            left: 24.w,
            right: 32.w,
            bottom: 230.h,
          ),
        ],
      ).marginOnly(
        top: 64.h,
      ),
    );
  }
}
