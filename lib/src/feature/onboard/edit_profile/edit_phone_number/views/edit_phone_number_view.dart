import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/controllers/profile_controller.dart';
import 'package:glorifi/src/feature/onboard/create_profile_plus/widgets/birthday_formatter.dart';
import 'package:glorifi/src/feature/onboard/create_profile_plus/widgets/disable_emaji_formatter.dart';
import 'package:glorifi/src/feature/onboard/create_profile_plus/widgets/input_suffix_icon.dart';
import 'package:glorifi/src/feature/onboard/create_profile_plus/widgets/input_suffix_icons.dart';
import 'package:glorifi/src/feature/onboard/create_profile_plus/widgets/profile_colors.dart';
import 'package:glorifi/src/feature/onboard/edit_profile/edit_phone_number/controllers/edit_phone_number_controller.dart';
import 'package:glorifi/src/feature/onboard/edit_profile/edit_phone_number/views/verify_phone_number_dialog.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/routes/app_pages.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/widgets/appbars/glorifi_appbar.dart';
import 'package:glorifi/src/widgets/buttons/primary_buton_dark.dart';

import '../../../create_profile_plus/widgets/profile_border.dart';

class EditPhoneNumberView extends StatefulWidget {
  EditPhoneNumberView({Key? key}) : super(key: key);

  @override
  State<EditPhoneNumberView> createState() => _EditPhoneNumberView();
}

class _EditPhoneNumberView extends State<EditPhoneNumberView> {
  EditPhoneNumberController get controller => Get.find();
  final GlobalKey<FormState> _phoneNumberFormKey = GlobalKey();
  bool isButtonPressed = false;

  String _tempNumber = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tempNumber = controller.phoneNumberController.text;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GlorifiAppBar(title: 'Edit Mobile Number'),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _phoneNumberFormKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Mobile Number',
                  style: xSmallSemiBold12Primary(
                      color: GlorifiColors.midnightBlue),
                ).marginOnly(bottom: 4),
                _getphoneNumberCodeInputField(),
                const Spacer(),
                PrimaryDarkButton(
                  title: 'Save',
                  onTap: _onSaveTap,
                  isLoading: controller.loading,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _getphoneNumberCodeInputField() {
    return Obx(() => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              inputFormatters: [
                CardFormatter(sample: 'xxx-xxx-xxxx', separator: '-'),
                DisableEmojiInputFilter.getDisableEmojiInputFilter()
              ],
              autofocus: true,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              keyboardType: TextInputType.number,

              style: TextStyle(color: GlorifiColors.textFieldTextColor),
              controller: controller.phoneNumberController,
              decoration: InputDecoration(
                suffixIcon: controller.phoneNumberController.text.isNotEmpty
                    ? InputSuffixIcons(
                        suffixIcons: [
                          _inputClear().paddingOnly(right: 6),
                        ],
                      )
                    : null,
                filled: true,
                fillColor: GlorifiColors.white,
                enabledBorder:
                    controller.haveError.value ? errorBorder() : _border(),
                border: normalBorder(),
                focusedBorder:
                    controller.haveError.value ? errorBorder() : _border(),
                errorBorder: errorBorder(),
                hintText: '555-555-5555',
                hintStyle: formInput(
                  color: GlorifiColors.silver,
                ),
              ),
              onChanged: (value) {
                setState(() {
                  !controller.isphoneNumberCodeValid;
                  isButtonPressed = false;
                });
              },
            ),
            if (controller.haveError.value)
              Container(
                margin: EdgeInsets.only(top: 4, left: 4),
                child: Text(
                  controller.errorMessage.value,
                  style: formHintOrError(color: profileRed),
                ),
              )
          ],
        ));
  }

  InputBorder _border({Color color = GlorifiColors.bermudaGray}) {
    return OutlineInputBorder(
      borderSide: BorderSide(color: color, width: 1),
      borderRadius: BorderRadius.circular(8),
    );
  }

  Widget _inputClear() {
    return InputSuffixIcon(
      iconData: Icons.close,
      iconColor: profileBlack,
      onTap: _onInputClear,
    );
  }

  validateNumber(){
    if (!isButtonPressed) {
      controller.haveError.value = false;
      return null;
    }
    if (!controller.isphoneNumberCodeValid) {
      if (controller.phoneNumberController.text.isEmpty) {
        controller.haveError.value = true;
        controller.errorMessage.value =
        'Mobile Number is required';

        return null;
      } else {
        controller.haveError.value = true;

        controller.errorMessage.value =
        'Please enter a valid Mobile Number';
        return null;
      }
    }
    controller.haveError.value = false;
    return null;
  }

  _onInputClear() {
    controller.phoneNumberController.clear();
    setState(() {
      controller.phoneNumberController.text;
      isButtonPressed = false;
    });
  }

  void _showPhoneNumberVerificationModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
      ),
      builder: (BuildContext context) {
        return VerifyPhoneNumberDialog();
      },
    );
  }

  void _onSaveTap() async {
    if (_tempNumber == controller.phoneNumberController.text) {
      Get.back();
      return;
    }
    FocusManager.instance.primaryFocus?.unfocus();
    setState(() {
      isButtonPressed = true;
    });
    controller.phoneNumberOnlineValidationController(true);
    validateNumber();
    if (!controller.haveError.value) {
      setState(() {
        controller.loading = true;
      });
      bool edited = await controller
          .editPhoneNumber(controller.phoneNumberController.text);
      if (edited) {
        Get.back();
        ProfileController profileController = Get.find();
        final controller = Get.find<EditPhoneNumberController>();
        profileController
            .updateMobileNumber(controller.phoneNumberController.text);
        await Get.toNamed(
          Routes.EDIT_PROFILE_SUCCESS,
          arguments: "Mobile Number",
        );
        // var resp = await controller.sentOtpPhone();
        // setState(() {
        //   controller.loading = false;
        // });
        // if (resp != null) {
        //   _showPhoneNumberVerificationModal();
        // } else {
        //   _toastMessageController
        //       .showShortToast('Please input valid mobile number');
        // }
      }
    }
  }
}
