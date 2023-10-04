import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/feature/credit_card_2/apply_for_card/screens/card_details/controller/cc_details_controller.dart';
import 'package:glorifi/src/feature/credit_card_2/apply_for_card/screens/card_details/widgets/basic_card_design.dart';
import 'package:glorifi/src/feature/credit_card_2/apply_for_card/screens/card_details/widgets/cc_details_sticky_footer.dart';
import 'package:glorifi/src/feature/credit_card_2/apply_for_card/screens/card_details/widgets/cc_reward.dart';
import 'package:glorifi/src/feature/credit_card_2/apply_for_card/screens/card_details/widgets/cc_details_header.dart';
import 'package:glorifi/src/feature/credit_card_2/apply_for_card/widgets/simple_credit_card_benefits.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive.dart';

class BasicCardDetailsScreen extends GetView<CCDetailsController> {
  const BasicCardDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlorifiColors.superLightGrey,
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                CCDetailsScreenHeader(
                  bgColor: GlorifiColors.superLightGrey,
                  titleColor: GlorifiColors.midnightBlue,
                  subTitleColor: GlorifiColors.midnightBlue,
                  desColor: GlorifiColors.midnightBlue,
                  textBgColor: GlorifiColors.superLightGrey,
                  backButtonBorderColor: GlorifiColors.superLightGrey,
                  img: controller.basicCardDetailsModel.image!,
                  title: controller.basicCardDetailsModel.title!,
                  subTitle: controller.basicCardDetailsModel.subTitle!,
                  desc: controller.basicCardDetailsModel.description!,
                ).marginOnly(bottom: 8.h),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CCReward(
                      title: controller
                          .basicCardDetailsModel.basicCardRewardModel!.title!,
                      desc: controller.basicCardDetailsModel
                          .basicCardRewardModel!.description!,
                      reward: controller.basicCardDetailsModel
                          .basicCardRewardModel!.data!.reward!,
                      apr: controller.basicCardDetailsModel
                          .basicCardRewardModel!.data!.apr!,
                      annualFee: controller.basicCardDetailsModel
                          .basicCardRewardModel!.data!.annualFee!,
                    ).marginOnly(bottom: 80.h),
                    Text(
                      controller
                          .basicCardDetailsModel.basicCardBenefitModel!.title!,
                      style:
                          captionBold14Primary(color: GlorifiColors.darkBlue),
                    ).marginOnly(left: 24.w, right: 32.w, bottom: 18.h),
                    Divider(thickness: 2.h, color: GlorifiColors.greyD9)
                        .marginOnly(left: 24.w, right: 32.w, bottom: 20.h),
                    SimpleCreditCardBenefits(
                      benefits: controller.basicCardDetailsModel
                          .basicCardBenefitModel!.benefits!,
                    ).marginOnly(left: 24.w, right: 32.w, bottom: 50.h),
                    BasicCardDesign(
                      basicCardDesign: controller
                          .basicCardDetailsModel.basicCardDesignModel!,
                    ).marginOnly(bottom: 100.h),
                    Text(
                      controller.basicCardDetailsModel.basicCardFooterModel!,
                      style: captionRegular14Primary(
                          color: GlorifiColors.darkMidnightBlue),
                    ).marginOnly(left: 24.w, right: 32.w)
                  ],
                )
              ],
            ).marginOnly(bottom: 260.h),
          ),
          CCDetailsStickyFooter(),
        ],
      ),
    );
  }
}
