import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/feature/credit_card_2/apply_for_card/controller/acc_controller.dart';
import 'package:glorifi/src/feature/credit_card_2/apply_for_card/model/acc_screen_info_model.dart';
import 'package:glorifi/src/feature/credit_card_2/apply_for_card/screens/acc/offers/widget/button_with_credit_card_image.dart';
import 'package:glorifi/src/feature/credit_card_2/apply_for_card/widgets/acc_exit_container.dart';
import 'package:glorifi/src/routes/app_pages.dart';
import 'package:glorifi/src/utils/glorifi_assets.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive.dart';
import 'package:glorifi/src/utils/text_constants.dart';
import 'package:glorifi/src/widgets/buttons/primary_button.dart';

class ACCOfferBlueAndGoldCreditCardScreen extends GetView<ACCController> {
  ACCOfferBlueAndGoldCreditCardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ACCExitContainer(
      topPadding: 113,
      picture: Center(
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.r),
              child: Image.asset(
                GlorifiAssets.glorifiGoldCreditCardDark,
                width: 184.w,
                height: 115.h,
              ),
            ).marginOnly(top: 39.h, left: 69.w),
            ClipRRect(
              borderRadius: BorderRadius.circular(8.r),
              child: Image.asset(
                GlorifiAssets.glorifiMasterCardBlue,
                width: 184.w,
                height: 117.h,
              ),
            )
          ],
        ),
      ).marginOnly(bottom: 56.h),
      title: ACCScreensInfo.ACCOfferBlueAndGoldCreditCardScreen.title,
      subtitle: ACCScreensInfo.ACCOfferBlueAndGoldCreditCardScreen.subtitle!,
      ctaButtons: _buttons(),
    );
  }

  List<Widget> _buttons() => [
        ButtonWithCreditCardImage(
            text: TextConstants.continueStandardCard,
            image: GlorifiAssets.glorifiMasterCardBlue,
            onTap: () {
              Get.toNamed(Routes.accChooseCreditCardDesign);
            }).marginOnly(bottom: 24.h),
        ButtonWithCreditCardImage(
          text: TextConstants.reviewBrassDetails,
          image: GlorifiAssets.glorifiGoldCreditCardDark,
          onTap: () {
            Get.toNamed(Routes.accOfferBrassCardDetailsScreen);
          },
        ),
      ];
}
