import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/controllers/plaid_controller.dart';
import 'package:glorifi/src/controllers/profile_controller.dart';
import 'package:glorifi/src/model/profile_model.dart';
import 'package:glorifi/src/utils/responsive/responsive.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../../../controllers/profile_controller.dart';
import '../../../../../font_style_global.dart';
import '../../../../../utils/glorifi_colors.dart';
import '../../../../../utils/glorifi_text_styles.dart';
import '../../../../../widgets/buttons/primary_buton_dark.dart';

class EditProfileController extends GetxController {
  final ProfileController _profileController = Get.put(ProfileController());
  final Rx<bool> _creditScoreEnabledController = Rx(false);
  void onChangedCreditScoreEnabled(bool value) =>
      _creditScoreEnabledController(value);
  bool get creditScoreEnabled => _creditScoreEnabledController.value;

  final Rx<bool> loadingTapLinkExternalBankAccount = Rx(false);

  Future<void> gotoLinkedAccounts() async {
    loadingTapLinkExternalBankAccount.value = true;
    Future.delayed(const Duration(seconds: 3), () {
      loadingTapLinkExternalBankAccount.value = false;
    });
    Get.put(PlaidController());
    PlaidController _controller = Get.find<PlaidController>();
    await _controller.openPlaid();;
  }

  Future<void> showDialogBox(BuildContext context) async {
    Get.defaultDialog(
      title: "",
      content: Container(
        width: 650.w,
        padding: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 15.h),
        child: Row(
          children: [
            Expanded(
              child: SizedBox(),
              flex: 2,
            ),
            Expanded(
              flex: 5,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Align(
                      alignment: Alignment.topRight,
                      child: Text(
                        "Cancel",
                        style: captionSemiBold14Primary(
                            color: GlorifiColors.darkOrange),
                      )),
                  SizedBox(
                    height: 20.h,
                  ),
                  Text(
                    "Please verify your\n mobile number",
                    style: headlineRegular31Secondary(),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20.h),
                  Text("This is the reason we ask for mobile number",
                      style: xSmallRegular12Primary()),
                  SizedBox(height: 20.h),
                  TextField(
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: GlorifiColors.darkBlue, width: 1.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: GlorifiColors.darkBlue, width: 1.0),
                      ),
                      hintText: '(123) - 456 - 7689',
                    ),
                  ),
                  SizedBox(height: 20.h),
                  PinCodeTextField(
                    length: 5,
                    keyboardType: TextInputType.number,
                    cursorColor: GlorifiColors.midnightBlue,
                    obscureText: true,
                    obscuringCharacter: "*",
                    onChanged: (String value) {},
                    appContext: context,
                    pinTheme: PinTheme(
                        borderRadius: BorderRadius.circular(5),
                        fieldHeight: 50,
                        fieldWidth: 40,
                        activeColor: GlorifiColors.midnightBlue,
                        inactiveColor: GlorifiColors.creditBgGrey,
                        selectedColor: GlorifiColors.midnightBlue),
                  ),
                  SizedBox(height: 20.h),
                  RichText(
                    text: TextSpan(
                      text: 'Did’t get the code? ',
                      style: xSmallRegular12Primary(
                          color: GlorifiColors.midnightBlue),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Resend',
                          style: xSmallBold12Primary(
                            color: GlorifiColors.midnightBlue,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20.h),
                  PrimaryDarkButton(
                    title: "Send Code",
                    textColor: GlorifiColors.midnightBlue,
                    onTap: () {},
                    primaryColor: GlorifiColors.darkOrange,
                  )
                ],
              ),
            ),
            Expanded(
              child: SizedBox(),
              flex: 2,
            ),
          ],
        ),
      ),
      backgroundColor: Colors.white,
      titleStyle: universNormalStyle.copyWith(
        fontSize: 21,
        fontWeight: FontWeight.w400,
        color: GlorifiColors.textColorBlack,
      ),
    );
  }

  Future<void> showBottomSheetPage(BuildContext context) async {
    /*Get.bottomSheet(
      SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(top: 15.h,
              left: 30.w, right: 30.w, bottom: 30.h),
          child: Row(
            children: [

              Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: 15.h,
                  ),
                  Align(
                      alignment: Alignment.topRight,
                      child: Text(
                        "Cancel",
                        style: captionSemiBold14Primary(
                            color: GlorifiColors.darkOrange),
                      )),
                  SizedBox(
                    height: 20.h,
                  ),
                  Text(
                    "Please verify your\nmobile number",
                    style: headlineRegular31Secondary(),
                    textAlign: TextAlign.center,maxLines: 2,
                  ),
                  SizedBox(height: 20.h),
                  Text(
                      "This is the reason we ask for mobile number",
                      style: xSmallRegular12Primary()),
                  SizedBox(height: 20.h),
                  SizedBox(
                    width: 330.w,
                    child: TextField(
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: GlorifiColors.darkBlue,
                              width: 1.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: GlorifiColors.darkBlue,
                              width: 1.0),
                        ),
                        hintText: '(123) - 456 - 7689',
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  SizedBox(
                    width: 330.w,
                    child: PinCodeTextField(
                      length: 5,
                      keyboardType: TextInputType.number,
                      cursorColor: GlorifiColors.midnightBlue,
                      obscureText: true,
                      obscuringCharacter: "*",
                      onChanged: (String value) {},
                      appContext: context,
                      pinTheme: PinTheme(
                          borderRadius:
                          BorderRadius.circular(5),
                          fieldHeight: 50,
                          fieldWidth: 40,
                          activeColor:
                          GlorifiColors.midnightBlue,
                          inactiveColor:
                          GlorifiColors.creditBgGrey,
                          selectedColor:
                          GlorifiColors.midnightBlue),
                    ),
                  ),
                  SizedBox(height: 20.h),

                  RichText(
                    text: TextSpan(
                      text: 'Did’t get the code? ',
                      style: xSmallRegular12Primary(
                          color: GlorifiColors.midnightBlue),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Resend',
                          style: xSmallBold12Primary(
                            color: GlorifiColors.midnightBlue,
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 20.h),
                  PrimaryDarkButton(
                    title: "Send Code",
                    textColor: GlorifiColors.midnightBlue,
                    onTap: () {},
                    primaryColor: GlorifiColors.darkOrange,
                  )
                ],
              ),
            ],
          ),
        ),
      ),
      backgroundColor: GlorifiColors.white,
      enableDrag: true,);*/

    Get.bottomSheet(
      SingleChildScrollView(
        child: Container(
          width: 670,
          padding:
              EdgeInsets.only(top: 15.h, left: 30.w, right: 30.w, bottom: 10.h),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                height: 15.h,
              ),
              Align(
                  alignment: Alignment.topRight,
                  child: Text(
                    "Cancel",
                    style: captionSemiBold14Primary(
                        color: GlorifiColors.darkOrange),
                  )),
              SizedBox(
                height: 20.h,
              ),
              Text(
                "Please verify your\nmobile number",
                style: headlineRegular31Secondary(),
                textAlign: TextAlign.center,
                maxLines: 2,
              ),
              SizedBox(height: 20.h),
              Text("This is the reason we ask for mobile number",
                  style: xSmallRegular12Primary()),
              SizedBox(height: 20.h),
              TextField(
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: GlorifiColors.darkBlue, width: 1.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: GlorifiColors.darkBlue, width: 1.0),
                  ),
                  hintText: '(123) - 456 - 7689',
                ),
              ),
              SizedBox(height: 20.h),
              PinCodeTextField(
                length: 5,
                keyboardType: TextInputType.number,
                cursorColor: GlorifiColors.midnightBlue,
                obscureText: true,
                obscuringCharacter: "*",
                onChanged: (String value) {},
                appContext: context,
                pinTheme: PinTheme(
                    borderRadius: BorderRadius.circular(5),
                    fieldHeight: 50,
                    fieldWidth: 40,
                    activeColor: GlorifiColors.midnightBlue,
                    inactiveColor: GlorifiColors.creditBgGrey,
                    selectedColor: GlorifiColors.midnightBlue),
              ),
              SizedBox(height: 20.h),
              RichText(
                text: TextSpan(
                  text: 'Did’t get the code? ',
                  style:
                      xSmallRegular12Primary(color: GlorifiColors.midnightBlue),
                  children: <TextSpan>[
                    TextSpan(
                      text: 'Resend',
                      style: xSmallBold12Primary(
                        color: GlorifiColors.midnightBlue,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.h),
              PrimaryDarkButton(
                title: "Send Code",
                textColor: GlorifiColors.midnightBlue,
                onTap: () {},
                primaryColor: GlorifiColors.darkOrange,
              )
            ],
          ),
        ),
      ),
      backgroundColor: GlorifiColors.white,
      enableDrag: true,
    );
  }

  ProfileModel get getProfile => _profileController.userProfile;

  @override
  void onInit() {
    onChangedCreditScoreEnabled(
      _profileController.userProfile.creditScoreEnabled ?? false,
    );
    super.onInit();
  }
}
