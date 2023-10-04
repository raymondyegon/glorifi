import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/feature/onboard/create_profile_plus/widgets/disable_emaji_formatter.dart';
import 'package:glorifi/src/feature/onboard/create_profile_plus/widgets/input_suffix_icon.dart';
import 'package:glorifi/src/feature/onboard/create_profile_plus/widgets/input_suffix_icons.dart';
import 'package:glorifi/src/feature/onboard/create_profile_plus/widgets/profile_colors.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/routes/app_pages.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/widgets/appbars/glorifi_appbar.dart';
import 'package:glorifi/src/widgets/buttons/primary_buton_dark.dart';

import '../../../create_profile_plus/widgets/profile_border.dart';
import '../controllers/edit_zip_code_controller.dart';

class EditZipCodeView extends StatefulWidget {
  EditZipCodeView({Key? key}) : super(key: key);

  @override
  State<EditZipCodeView> createState() => _EditZipCodeViewState();
}

class _EditZipCodeViewState extends State<EditZipCodeView> {
  EditZipCodeController get controller => Get.find();
  final GlobalKey<FormState> _zipFormKey = GlobalKey();
  bool isButtonPressed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GlorifiAppBar(title: 'Edit ZIP Code'),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _zipFormKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'ZIP Code',
                  style: xSmallSemiBold12Primary(
                    color: GlorifiColors.midnightBlue,
                  ),
                ).marginOnly(bottom: 4),
                _getZipCodeInputField(),
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

  Widget _getZipCodeInputField() {
    return Obx(() => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              inputFormatters: [
                DisableEmojiInputFilter.getDisableEmojiInputFilter()
              ],
              autofocus: true,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              keyboardType: TextInputType.number,
              maxLength: 5,
              validator: (value) {
                if (!isButtonPressed) {
                  return null;
                }
                if (!controller.isZipCodeValid) {
                  if (controller.zipController.text.isEmpty) {
                    controller.haveZipCodeNameError.value = true;
                    controller.errorMessage.value = 'ZIP Code is required';
                    return null;
                  } else {
                    controller.haveZipCodeNameError.value = true;
                    controller.errorMessage.value =
                        'Please enter a valid ZIP Code';
                    return null;
                  }
                }
                controller.haveZipCodeNameError.value = false;

                return null;
              },
              style: TextStyle(color: GlorifiColors.textFieldTextColor),
              controller: controller.zipController,
              decoration: InputDecoration(
                suffixIcon: controller.zipController.text.isNotEmpty
                    ? InputSuffixIcons(
                        suffixIcons: [
                          _inputClear().paddingOnly(right: 6),
                        ],
                      )
                    : null,
                filled: true,
                fillColor: GlorifiColors.white,
                enabledBorder: controller.haveZipCodeNameError.value
                    ? errorBorder()
                    : _border(),
                border: normalBorder(),
                focusedBorder: controller.haveZipCodeNameError.value
                    ? errorBorder()
                    : _border(),
                errorBorder: errorBorder(),
                counterText: '',
                //hide max_length count from bottom of TextFormField
                hintText: '90210',
                hintStyle: formInput(
                  color: GlorifiColors.silver,
                ),
              ),
              onChanged: (value) {
                setState(() {
                  !controller.isZipCodeValid;
                  isButtonPressed = false;
                });
              },
            ),
            if (controller.haveZipCodeNameError.value)
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

  _onInputClear() {
    controller.zipController.clear();
    setState(() {
      controller.zipController.text;
      isButtonPressed = false;
    });
  }

  void _onSaveTap() async {
    FocusManager.instance.primaryFocus?.unfocus();
    setState(() {
      isButtonPressed = true;
    });
    controller.zipOnlineValidationController(true);
    // final bool isValid = _zipFormKey.currentState!.validate();
    final bool isValid = !controller.haveZipCodeNameError.value;

    if (isValid) {
      setState(() {
        controller.loading = true;
      });

      bool? isZipValidOnline = await controller.isZipCodeValidByOnline();

      // setState(() {
      //   _zipFormKey.currentState!.validate();
      // });

      if (isZipValidOnline != null && isZipValidOnline && isValid) {
        bool isSuccessfullyUpdated = await controller.updateZipCode();
        if (isSuccessfullyUpdated) {
          await Get.toNamed(Routes.EDIT_PROFILE_SUCCESS, arguments: "ZIP Code");
          Get.back(
              result:
                  true); // when Edit profile success page hit back/close button, this method will get back to previous screen with result = true
        }
      }

      setState(() {
        controller.loading = false;
      });
    }
  }
}
