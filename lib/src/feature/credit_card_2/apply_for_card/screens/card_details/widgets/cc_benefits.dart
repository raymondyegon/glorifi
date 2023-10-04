import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/feature/credit_card_2/apply_for_card/screens/card_details/models/brass_card_details_model.dart';
import 'package:glorifi/src/feature/credit_card_2/apply_for_card/widgets/simple_credit_card_benefits.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive.dart';
import 'brass_card_details_footer.dart';

class CCBenefits extends StatelessWidget {
  final String title;

  final List<String> benefits;

  final BrassCardDetailsFooterModel brassCardFooter;

  const CCBenefits(
      {required this.title,
      required this.benefits,
      required this.brassCardFooter,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: GlorifiColors.midnightBlue,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: captionBold14Primary(color: GlorifiColors.white),
          ).marginOnly(bottom: 18.h),
          Divider(
            thickness: 1,
            color: GlorifiColors.white,
          ).marginOnly(bottom: 20.h),
          SimpleCreditCardBenefits(
            textColor: GlorifiColors.white,
            iconColor: GlorifiColors.white,
            benefits: benefits,
          ).marginOnly(bottom: 60.h),
          BrassCardDetailsFooter(footer: brassCardFooter),
        ],
      ).marginOnly(left: 24.w, right: 32.w, top: 64.h, bottom: 66.h),
    );
  }
}
