import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/feature/banking/consent/controller/check_deposit_controller.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/glorifi-widgets/glorifi_terms_checkbox.dart';
import 'package:glorifi/src/routes/app_pages.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_widgets/adaptive_scaffold.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive_extensions.dart';
import 'package:glorifi/src/widgets/appbars/glorifi_appbar.dart';
import 'package:glorifi/src/widgets/buttons/primary_button.dart';

class CheckDepositConsentScreen extends GetView<CheckDepositController> {
  const CheckDepositConsentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AdaptiveScaffold(
      appBar: GlorifiAppBar(
        title: 'Mobile Deposit',
      ),
      backgroundColor: GlorifiColors.white,
      body: Container(
        padding: EdgeInsets.fromLTRB(24.w, 20.h, 24.w, 52.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Enjoy the convenience of a GloriFi mobile check deposit',
              style: headlineRegular31Secondary(color: GlorifiColors.darkBlue),
            ),
            SizedBox(height: 8.h),
            Text(
              """
Make mobile deposits with no charges or monthly fees from the GloriFi app.

Mobile check deposit functionality is only available on the mobile app.""",
              style: captionRegular14Primary(color: GlorifiColors.darkBlue),
            ),
            SizedBox(height: 36.h),
            Row(
              children: [
                SizedBox(
                  height: 21.w,
                  width: 21.w,
                  child: GlorifiCheckbox(
                    margin: 0,
                    onPressed: (ischecked) =>
                        controller.hasConsented.value = ischecked,
                  ),
                ),
                SizedBox(width: 10.h),
                Flexible(
                  child: GestureDetector(
                    onTap: () => Get.toNamed(Routes.checkDepositTerms),
                    child: RichText(
                      text: TextSpan(
                        text: 'I confirm I have read and accept the ',
                        style: xSmallRegular12Primary(
                            color: GlorifiColors.darkBlue),
                        children: <TextSpan>[
                          TextSpan(
                            text: 'GloriFi mobile check deposit agreement.',
                            style: xSmallBold12Primary(
                                color: GlorifiColors.bloodOrange),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 32.h),
            Obx(_buildContinueButton),
          ],
        ),
      ),
    );
  }

  Widget _buildContinueButton() {
    return controller.hasConsented.value
        ? PrimaryButton(
            title: "Continue",
            width: 342.w,
            height: 64.h,
            primaryColor: GlorifiColors.primaryButtonProgressColor,
            textColor: GlorifiColors.superLightGrey,
            hasRightArrow: true,
            avoidShadow: true,
            onTap: () => {
              controller.saveUserAcceptance(),
              Get.offNamed(Routes.mobileDepositTo),
            },
          )
        : PrimaryButton(
            title: "Continue",
            width: 342.w,
            height: 64.h,
            iconColor: GlorifiColors.superLightGrey,
            primaryColor: GlorifiColors.silver,
            textColor: GlorifiColors.superLightGrey,
            hasRightArrow: true,
            avoidShadow: true,
            onTap: () => debugPrint("The user did not consent"),
          );
  }
}
