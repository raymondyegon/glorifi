import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/feature/credit_card_2/apply_for_card/model/acc_screen_info_model.dart';
import 'package:glorifi/src/feature/credit_card_2/apply_for_card/widgets/acc_exit_container.dart';
import 'package:glorifi/src/routes/app_pages.dart';
import 'package:glorifi/src/utils/glorifi_assets.dart';
import 'package:glorifi/src/utils/responsive/responsive.dart';
import 'package:glorifi/src/widgets/buttons/primary_button.dart';

class ACCOfferBlueCreditCardScreen extends StatelessWidget {
  const ACCOfferBlueCreditCardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ACCExitContainer(
      topPadding: 113,
      picture: Center(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8.r),
          child: Image.asset(
            GlorifiAssets.glorifiMasterCardBlue,
            width: 124.w,
            height: 78.h,
          ),
        ),
      ).marginOnly(bottom: 103.h),
      title: ACCScreensInfo.ACCApprovedScreen.title,
      subtitle: ACCScreensInfo.ACCApprovedScreen.subtitle!,
      ctaButtons: [
        PrimaryButton(
          title: ACCScreensInfo.ACCApprovedScreen.ctaTitle,
          hasRightArrow: true,
          onTap: () async {
            await Get.toNamed(Routes.accOfferBlueAndGoldCreditCardScreen);
          },
        ),
      ],
    );
  }
}
