import 'dart:io';

import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/feature/banking/deposit_check/controller/deposit_check_camera_controller.dart';
import 'package:glorifi/src/feature/banking/deposit_check/controller/mobile_deposit_controller.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/routes/app_pages.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_widgets/adaptive_scaffold.dart';
import 'package:glorifi/src/utils/glorifi_assets.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive_extensions.dart';
import 'package:glorifi/src/widgets/appbars/glorifi_appbar.dart';
import 'package:glorifi/src/widgets/buttons/primary_button.dart';

class MobileDepositScreen extends GetView<MobileDepositController> {
  MobileDepositScreen({Key? key}) : super(key: key);

  final cameraController = Get.put(DepositCheckCameraController());
  final currencyFormatter = CurrencyTextInputFormatter(symbol: r"$");

  @override
  Widget build(BuildContext context) {
    return AdaptiveScaffold(
        backgroundColor: GlorifiColors.white,
        appBar: GlorifiAppBar(
          title: 'Mobile Deposit',
          trailing: Trailing(
              text: "Cancel",
              onTap: Get.back,
              textStyle:
                  captionBold14Primary(color: GlorifiColors.bloodOrange)),
        ),
        body: Obx(
          () => GestureDetector(
              onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
              child: SingleChildScrollView(
                  padding: EdgeInsets.fromLTRB(24.w, 48.h, 24.w, 52.h),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Provide your check details",
                            style: leadRegular24Secondary(
                                color: GlorifiColors.biscayBlue)),
                        SizedBox(height: 42.h),
                        _buildDepositAmountInputField(),
                        SizedBox(height: 37.h),
                        _buildCheckCaptureSection(context),
                        SizedBox(height: 54.h),
                        _buildContinueButton()
                      ]))),
        ));
  }

  Widget _buildDepositAmountInputField() {
    final depositAmountTextFormStyle =
        headlineBold28Primary(color: GlorifiColors.biscayBlue);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Deposit Amount",
            style: smallBold16Primary(color: GlorifiColors.ebonyBlue)),
        SizedBox(height: 16.h),
        TextFormField(
          key: controller.mobileDepositKey,
          onChanged: (String? value) {
            controller.depositAmountValueController.refresh();
          },
          autocorrect: true,
          controller: controller.depositAmountValueController.value,
          decoration: InputDecoration(
              fillColor: GlorifiColors.white,
              enabledBorder:
                  UnderlineInputBorder(borderSide: BorderSide(width: 2.w)),
              hintStyle: depositAmountTextFormStyle,
              hintText: r"$0.00",
              prefixStyle: depositAmountTextFormStyle),
          style: depositAmountTextFormStyle,
          keyboardType: TextInputType.number,
          inputFormatters: [currencyFormatter],
        ),
        SizedBox(height: 11.h),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Text(
                  'Your available daily mobile deposit limit is ${controller.getMobileDepositLimit()}. '
                  r'Your available monthly deposit limit is $100,000.',
                  // TODO: Get monthly value from Alogent
                  softWrap: true,
                  style:
                      captionRegular14Primary(color: GlorifiColors.ebonyBlue)),
            ),
            GestureDetector(
              onTap: _showDepositLimitBottomInfo,
              child: SvgPicture.asset(
                GlorifiAssets.infoCircle,
                width: 24.h,
                height: 24.h,
              ),
            ),
          ],
        )
      ],
    );
  }

  _showDepositLimitBottomInfo() {
    showModalBottomSheet<void>(
      context: Get.context!,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.r),
      ),
      builder: (BuildContext context) {
        return FractionallySizedBox(
          heightFactor: 580 / 844,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 21.h),
              Container(
                  width: 134.w,
                  height: 5.h,
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.all(Radius.circular(100.r)))),
              SizedBox(height: 19.h),
              Text("Mobile Deposit Limit",
                  style:
                      bodyBold18Primary(color: GlorifiColors.textColorBlack)),
              SizedBox(height: 8.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 28.w),
                // TODO: Get values from Alogent
                child: Text(
                    """
The daily limit for mobile deposits is ${controller.getMobileDepositLimit()} a day. There is also a 30 day limit of \$100,000; these may be subject to change.

If your check is more than your available limit, please contact us on 844-456-7434.
""" // TODO: Get monthly value from Alogent
                    ,
                    style: bodyRegular18Primary(
                        color: GlorifiColors.textColorBlack)),
              ),
              const Spacer(),
              PrimaryButton(
                title: "Got It!",
                width: 358.w,
                height: 64.h,
                primaryColor: GlorifiColors.primaryButtonProgressColor,
                textColor: GlorifiColors.superLightGrey,
                onTap: Get.back,
              ),
              SizedBox(height: 56.h),
            ],
          ),
        );
      },
    );
  }

  Widget _buildCheckCaptureSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text("Take a photo of the physical check",
                style: smallBold16Primary(color: GlorifiColors.black)),
          ],
        ),
        SizedBox(height: 8.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text("Please remember to sign the back of your check.",
                style: captionRegular14Primary(color: GlorifiColors.textColor)),
          ],
        ),
        SizedBox(height: 16.h),
        _buildCameraCaptureButton(
          () async {
            cameraController.permissionValidation(
                context, Routes.checkDepositCamera, true);
          },
          GlorifiAssets.camera,
          "Capture Front",
          cameraController.frontCheckPhoto,
        ),
        SizedBox(height: 16.h),
        _buildCameraCaptureButton(
          () async {
            cameraController.permissionValidation(
                context, Routes.checkDepositCameraBackConfirmation, false);
          },
          GlorifiAssets.cameraRotate,
          "Capture Back",
          cameraController.backCheckPhoto,
        ),
      ],
    );
  }

  Widget _buildCameraCaptureButton(
      void Function()? onTap, String iconPath, String description, var photo) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 335.w,
        height: 76.h,
        padding: EdgeInsets.only(left: 20.w, right: 34.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8.r)),
          border: Border.all(color: GlorifiColors.biscayBlue, width: 2.w),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              iconPath,
              color: GlorifiColors.denimBlue,
              height: 24.h,
            ),
            SizedBox(width: 17.w),
            Text(description,
                style: captionSemiBold16Primary(
                    color: GlorifiColors.midnightBlue)),
            Spacer(),
            Container(
              width: 106.w,
              height: 49.h,
              child: photo.value.path != ""
                  ? RotatedBox(
                      quarterTurns: -1,
                      child: Image.file(File(photo.value!.path)),
                    )
                  : Container(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContinueButton() {
    return _continueButtonEnabled()
        ? PrimaryButton(
            title: "Continue",
            width: 335.w,
            height: 64.h,
            primaryColor: GlorifiColors.primaryButtonProgressColor,
            textColor: GlorifiColors.superLightGrey,
            hasRightArrow: true,
            avoidShadow: true,
            onTap: () => Get.toNamed(Routes.mobileDepositVerifyingCheck),
          )
        : PrimaryButton(
            title: "Continue",
            width: 335.w,
            height: 64.h,
            iconColor: GlorifiColors.superLightGrey,
            primaryColor: GlorifiColors.silver,
            textColor: GlorifiColors.superLightGrey,
            hasRightArrow: true,
            avoidShadow: true,
            onTap: () => debugPrint("Photos not taken."),
          );
  }

  bool _continueButtonEnabled() {
    return currencyFormatter.getUnformattedValue() > 0 &&
        cameraController.frontCheckPhoto.value.path != "" &&
        cameraController.backCheckPhoto.value.path != "" &&
        cameraController.analysisSuccessful.value == true;
  }
}
