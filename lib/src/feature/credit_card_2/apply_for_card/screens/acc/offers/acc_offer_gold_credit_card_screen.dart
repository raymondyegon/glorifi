import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/feature/credit_card_2/apply_for_card/model/acc_screen_info_model.dart';
import 'package:glorifi/src/feature/credit_card_2/apply_for_card/widgets/acc_exit_container.dart';
import 'package:glorifi/src/routes/app_pages.dart';
import 'package:glorifi/src/utils/glorifi_assets.dart';
import 'package:glorifi/src/utils/responsive/responsive.dart';
import 'package:glorifi/src/widgets/buttons/primary_button.dart';

class ACCOfferGoldCreditCardScreen extends StatelessWidget {
  const ACCOfferGoldCreditCardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ACCExitContainer(
      topPadding: 113,
      picture: Center(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8.r),
          child: Image.asset(
            GlorifiAssets.glorifiGoldCreditCardDark,
            width: 124.w,
            height: 78.h,
          ),
        ).marginOnly(bottom: 103.h),
      ),
      title: ACCScreensInfo.ACCQualifiedScreen.title,
      subtitle: ACCScreensInfo.ACCQualifiedScreen.subtitle!,
      ctaButtons: [
        PrimaryButton(
          title: ACCScreensInfo.ACCQualifiedScreen.ctaTitle,
          hasRightArrow: true,
          onTap: () async {
            Get.toNamed(Routes.accAcceptCardAgreement);
          },
        ),
      ],
    );
  }
}
