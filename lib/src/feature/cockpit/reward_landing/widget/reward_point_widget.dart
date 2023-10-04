import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/feature/cockpit/controllers/loyalty_controller.dart';
import 'package:glorifi/src/feature/cockpit/reward_landing/controllers/reward_landing_controller.dart';
import 'package:glorifi/src/feature/feature_flag/feature_flag_manager.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive.dart';
import 'package:glorifi/src/utils/text_constants.dart';
import 'package:glorifi/src/widgets/buttons/primary_button.dart';

class RewardPointWidget extends GetView<LoyaltyController> {
  final RewardLandingController landingController;
  final Function() onTapRedeem;

  const RewardPointWidget({
    required this.landingController,
    required this.onTapRedeem,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            bottom: 35.0,
            top: 10,
          ),
          child: Text(
            'Rewards',
            style: headlineBold26Primary(
              color: GlorifiColors.primaryDarkButtonColor,
            ),
          ),
        ),
        _getRewardPointInformationRow().marginOnly(bottom: 36.h),
        Text(
          TextConstants.rewardPointNote,
          style: smallRegular16Primary(color: GlorifiColors.textColor),
        ),
        SizedBox(height: 45.h),
        Obx(() {
          return Container(
          constraints: BoxConstraints(maxWidth: 400),
          child: PrimaryButton(
            title: "Redeem Rewards",
            onTap: onTapRedeem,
            height: 64.h,
            hasRightArrow: true,
            avoidShadow: true,
            iconSpacing: 12,
            fontSize: 18.sp,
            primaryColor: GlorifiColors.darkBlue,
            textColor: GlorifiColors.white,
              enabled: FeatureFlagManager.rewardsRedeemEnabled &&
                  controller.currentBalance > 0,
          ),
          );
        }),
        SizedBox(height: 32.h),
      ],
    );
  }

  Widget _getRewardPointInformationRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: TextSpan(
                    text: '${landingController.userName}, you have ',
                    style:
                        leadRegular24Secondary(color: GlorifiColors.darkBlue),
                    children: [
                      TextSpan(
                        text: controller.currentBalance.toString(),
                        style:
                            leadBold24Secondary(color: GlorifiColors.darkBlue),
                      ),
                      TextSpan(
                        text: ' points!',
                        style: leadRegular24Secondary(
                            color: GlorifiColors.darkBlue),
                      ),
                    ]),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
