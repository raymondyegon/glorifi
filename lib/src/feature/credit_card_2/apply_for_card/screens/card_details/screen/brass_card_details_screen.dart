import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/feature/credit_card_2/apply_for_card/screens/card_details/controller/cc_details_controller.dart';
import 'package:glorifi/src/feature/credit_card_2/apply_for_card/screens/card_details/widgets/cc_benefits.dart';
import 'package:glorifi/src/feature/credit_card_2/apply_for_card/screens/card_details/widgets/cc_details_sticky_footer.dart';
import 'package:glorifi/src/feature/credit_card_2/apply_for_card/screens/card_details/widgets/cc_partner.dart';
import 'package:glorifi/src/feature/credit_card_2/apply_for_card/screens/card_details/widgets/cc_partner_perks.dart';
import 'package:glorifi/src/feature/credit_card_2/apply_for_card/screens/card_details/widgets/cc_reward.dart';
import 'package:glorifi/src/feature/credit_card_2/apply_for_card/screens/card_details/widgets/cc_details_header.dart';
import 'package:glorifi/src/feature/credit_card_2/apply_for_card/screens/card_details/widgets/cc_services.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive.dart';

class BrassCardDetailsScreen extends GetView<CCDetailsController> {
  const BrassCardDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlorifiColors.white,
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                CCDetailsScreenHeader(
                  img: controller.brassCardDetailsModel.image!,
                  title: controller.brassCardDetailsModel.title!,
                  subTitle: controller.brassCardDetailsModel.subTitle!,
                  desc: controller.brassCardDetailsModel.description!,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CCReward(
                      title: controller.brassCardDetailsModel.rewards!.title!,
                      desc: controller
                          .brassCardDetailsModel.rewards!.description!,
                      reward: controller
                          .brassCardDetailsModel.rewards!.data!.reward!,
                      apr: controller.brassCardDetailsModel.rewards!.data!.apr!,
                      annualFee: controller
                          .brassCardDetailsModel.rewards!.data!.annualFee!,
                    ),
                    CCServices(
                        benefits: controller
                            .brassCardDetailsModel.brassCardServices!),
                    CCPartner(
                      partners: controller.brassCardDetailsModel.partners!,
                    ).marginOnly(top: 39.h).marginOnly(bottom: 66.h),
                    CCPartnerPerks(
                      brassCardElitePartnerPerks: controller
                          .brassCardDetailsModel.brassCardElitePartnerPerks!,
                    ),
                    CCBenefits(
                        title: controller.brassCardDetailsModel
                            .brassCardBenefitsModel!.title!,
                        benefits: controller.brassCardDetailsModel
                            .brassCardBenefitsModel!.benefits!,
                        brassCardFooter:
                            controller.brassCardDetailsModel.brassCardFooter!),
                    CCDetailsStickyFooter(),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
