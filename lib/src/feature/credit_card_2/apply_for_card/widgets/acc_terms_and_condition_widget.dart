import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/feature/credit_card_2/apply_for_card/screens/acc/review_application/acc_review_application_controller.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive_extensions.dart';
import 'package:glorifi/src/utils/text_constants.dart';

class ACCTermsAndCondition extends GetView<ACCReviewApplicationController> {
  const ACCTermsAndCondition({Key? key}) : super(key: key);

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
        borderRadius: BorderRadius.circular(6.r),
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
          _title(TextConstants.whatYouNeedToKnow),
          _termsCheckBox(),
          SizedBox(height: 24.h),
          _accuracyOfInformation(),
        ],
      ),
    ).paddingOnly(bottom: 24.h, top: 24.h);
  }

  Widget _title(String title) {
    return Text(
      title,
      style: leadBold24Primary(
        color: GlorifiColors.primaryDarkButtonColor,
      ),
    ).paddingOnly(bottom: 16.h);
  }

  Widget _termsCheckBox() {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 16.h,
        horizontal: 14.w,
      ),
      decoration: BoxDecoration(
        color: GlorifiColors.white,
        borderRadius: BorderRadius.circular(6.r),
        border: Border.all(
          color: GlorifiColors.borderGrey,
        ),
      ),
      child: Row(
        children: [
          _checkBox(),
          Expanded(
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: TextConstants.iConfirmIHaveReadAndAccept,
                    style: captionRegular14Primary(
                        color: GlorifiColors.darkGrey80),
                    recognizer: TapGestureRecognizer()..onTap = () {},
                  ),
                  TextSpan(
                    text: TextConstants.patriotAct,
                    style: captionSemiBold14Primary(
                        color: GlorifiColors.primaryDarkButtonColor),
                    recognizer: TapGestureRecognizer()..onTap = () {},
                  ),
                  TextSpan(
                    text: 'and\t',
                    style: captionRegular14Primary(
                        color: GlorifiColors.darkGrey80),
                    recognizer: TapGestureRecognizer()..onTap = () {},
                  ),
                  TextSpan(
                    text: TextConstants.eConsent,
                    style: captionSemiBold14Primary(
                        color: GlorifiColors.primaryDarkButtonColor),
                    recognizer: TapGestureRecognizer()..onTap = () {},
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _checkBox() {
    return Obx(
      () => Checkbox(
        checkColor: GlorifiColors.primaryButtonProgressColor,
        side: BorderSide(
          color: GlorifiColors.greyBgColor,
        ),
        activeColor: GlorifiColors.white,
        value: controller.isElectronicConsentAgreement.value,
        onChanged: (bool? value) {
          controller.isElectronicConsentAgreement(value);
        },
      ),
    );
  }

  Widget _accuracyOfInformation() {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: TextConstants.accuracyOfInformationContent,
            style: xSmallSemiBold12Primary(color: GlorifiColors.darkGrey80),
          ),
          TextSpan(
            text: TextConstants.accuracyOfInformationContentEmail,
            style: xSmallBold12Primary(color: GlorifiColors.gradientDarkBlue),
          ),
          TextSpan(
            text: TextConstants.accuracyOfInformationContentMoreDetail,
            style: xSmallSemiBold12Primary(color: GlorifiColors.darkGrey80),
          ),
        ],
      ),
    ).paddingOnly(bottom: 96.h);
  }
}
