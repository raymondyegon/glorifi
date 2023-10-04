import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/feature/banking/deposit_check/controller/mobile_deposit_controller.dart';
import 'package:glorifi/src/feature/banking/deposit_check/mobile_deposit_accepted.dart';
import 'package:glorifi/src/feature/banking/deposit_check/mobile_deposit_in_review.dart';
import 'package:glorifi/src/feature/banking/widgets/glorifi_gradient_progress_indicator.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_widgets/adaptive_scaffold.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive_extensions.dart';
import 'package:glorifi/src/widgets/appbars/glorifi_appbar.dart';

class MobileDepositVerifyingCheckScreen
    extends GetView<MobileDepositController> {
  const MobileDepositVerifyingCheckScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: controller.verifyCheck(),
      builder: (context, snapshot) {
        return Obx(() {
          if (controller.depositAmountVerifyCheckReturnCode.value ==
              SubmitDepositReturnCode.Ok) {
            controller.depositAmountVerifyCheckReturnCode.value =
                SubmitDepositReturnCode.None;
            if (controller.submittedCheckResult ==
                SubmittedCheckResult.Complete) {
              return MobileDepositAcceptedScreen();
            } else {
              return MobileDepositInReviewScreen();
            }
          } else {
            return AdaptiveScaffold(
              appBar: GlorifiAppBar(
                title: 'Mobile Deposit',
                trailing: Trailing(
                    text: "Cancel",
                    onTap: Get.back,
                    textStyle:
                        captionBold14Primary(color: GlorifiColors.bloodOrange)),
              ),
              body: Container(
                padding: EdgeInsets.only(left: 24.w, right: 24.w, bottom: 52.h),
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GlorifiGradientProgressIndicator(
                              radius: 37.79.r,
                              strokeWidth: 11.w,
                              backgroundColor: GlorifiColors.biscayBlue,
                              gradientColors: [
                                GlorifiColors.superLightGrey.withOpacity(0.1),
                                GlorifiColors.bloodOrange
                              ],
                            ),
                            SizedBox(height: 16.h),
                            Text(
                              "Verifying check",
                              style: leadRegular24Secondary(
                                  color: GlorifiColors.biscayBlue),
                            ),
                          ]),
                    )
                  ],
                ),
              ),
            );
          }
        });
      },
    );
  }
}
