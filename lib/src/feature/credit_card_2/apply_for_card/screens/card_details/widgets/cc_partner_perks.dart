import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/feature/credit_card_2/apply_for_card/screens/card_details/models/brass_card_details_model.dart';
import 'package:glorifi/src/feature/credit_card_2/apply_for_card/widgets/simple_credit_card_benefits.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive.dart';

class CCPartnerPerks extends StatelessWidget {
  final BrassCardElitePartnerPerksModel brassCardElitePartnerPerks;

  const CCPartnerPerks({required this.brassCardElitePartnerPerks, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            brassCardElitePartnerPerks.title!,
            style: headlineBold26Primary(color: GlorifiColors.darkBlue),
          ).marginOnly(bottom: 20.h),
          SimpleCreditCardBenefits(
            benefits: brassCardElitePartnerPerks.perks!,
          ),
        ],
      ).marginOnly(left: 24.w, right: 32.w, bottom: 66.h),
    );
  }
}
