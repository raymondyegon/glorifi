import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/feature/credit_card_2/apply_for_card/controller/acc_controller.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive_extensions.dart';
import 'package:glorifi/src/utils/text_constants.dart';

class ACCCreditScorePullConsent extends GetView<ACCController> {
  const ACCCreditScorePullConsent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 15.h),
      padding: EdgeInsets.symmetric(
        vertical: 24.h,
        horizontal: 24.w,
      ),
      decoration: BoxDecoration(
        color: GlorifiColors.white,
        borderRadius: BorderRadius.circular(16.sp),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 0),
            blurRadius: 55,
            spreadRadius: 0,
            color: GlorifiColors.black.withOpacity(.10),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            TextConstants.creditScorePull,
            style: leadBold24Primary(
              color: GlorifiColors.primaryDarkButtonColor,
            ),
          ).paddingOnly(
            bottom: 16.h,
          ),
          Container(
            padding: EdgeInsets.symmetric(
              vertical: 16.h,
              horizontal: 14.w,
            ),
            decoration: BoxDecoration(
              color: GlorifiColors.white,
              borderRadius: BorderRadius.circular(16.sp),
              border: Border.all(
                color: GlorifiColors.grey9E.withOpacity(0.25),
              ),
            ),
            child: Row(
              children: [
                _checkBox(),
                Expanded(
                  child: Text(
                    TextConstants.consentToPullCreditScore,
                    style: captionRegular14Primary(
                      color: GlorifiColors.darkGrey80,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ).paddingOnly(
      bottom: 40.h,
    );
  }

  _checkBox() {
    return Obx(
      () => Checkbox(
        checkColor: GlorifiColors.primaryButtonProgressColor,
        side: BorderSide(
          color: GlorifiColors.greyBgColor,
        ),
        activeColor: GlorifiColors.white,
        value: controller.isConsentGiven.value,
        onChanged: (bool? value) => controller.acceptConsent(value),
      ),
    );
  }
}
