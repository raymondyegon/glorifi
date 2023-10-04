import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/feature/onboard/create_profile_plus/widgets/disable_emaji_formatter.dart';
import 'package:glorifi/src/feature/onboard/create_profile_plus/widgets/input_suffix_icon.dart';
import 'package:glorifi/src/feature/onboard/create_profile_plus/widgets/input_suffix_icons.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/routes/app_pages.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/widgets/appbars/glorifi_appbar.dart';
import 'package:glorifi/src/widgets/buttons/primary_buton_dark.dart';

import '../../../create_profile_plus/widgets/profile_border.dart';
import '../../../create_profile_plus/widgets/profile_colors.dart';
import '../controllers/edit_preferred_name_controller.dart';

class EditPreferredNameView extends StatefulWidget {
  const EditPreferredNameView({Key? key}) : super(key: key);

  @override
  State<EditPreferredNameView> createState() => _EditPreferredNameViewState();
}

class _EditPreferredNameViewState extends State<EditPreferredNameView> {
  EditPreferredNameController controller = Get.find();
  final GlobalKey<FormState> _preferredNameFormKey = GlobalKey();

  bool isButtonPressed = false;
  bool shouldShowPreferredNameError = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GlorifiAppBar(title: 'Edit Preferred Name'),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _preferredNameFormKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Preferred Name (Optional)',
                  style: xSmallSemiBold12Primary(
                      color: GlorifiColors.midnightBlue),
                ).marginOnly(bottom: 8),
                _getPreferredNameInputField(),
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

  void _onSaveTap() async {
    FocusManager.instance.primaryFocus?.unfocus();
    setState(() {
      shouldShowPreferredNameError = true;
      isButtonPressed = true;
    });
    // final bool isValid = _preferredNameFormKey.currentState!.validate();
    final bool isValid = !controller.haveError.value;

    if (isValid) {
      setState(() {
        controller.loading = true;
      });

      bool isSuccessfullyUpdated = await controller.updatePreferredName();
      if (isSuccessfullyUpdated) {
        await Get.toNamed(Routes.EDIT_PROFILE_SUCCESS,
            arguments: "Preferred Name");
        Get.back(
            result:
                true); // when Edit profile success page hit back/close button, this method will get back to previous screen with result = true
      }

      setState(() {
        controller.loading = false;
      });
    }
  }

  Widget _getPreferredNameInputField() {
    return Obx(() => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              autofocus: true,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              style: TextStyle(color: GlorifiColors.textFieldTextColor),
              keyboardType: TextInputType.text,
              validator: (value) {
                Future.delayed(Duration(milliseconds: 100)).then((value) {
                  if (controller.preferredNameController.text.isEmpty) {
                    controller.errorMessage.value =
                        'Please enter your preferred name.';
                    controller.haveError.value = true;
                    return null;
                  }
                  if (!controller.preferredNameValid) {
                    controller.errorMessage.value =
                        'Please enter a valid preferred name';
                    controller.haveError.value = true;

                    return null;
                  }
                  controller.haveError.value = false;

                  return null;
                });
              },
              controller: controller.preferredNameController,
              inputFormatters: [
                DisableEmojiInputFilter.getDisableEmojiInputFilter()
              ],
              textCapitalization: TextCapitalization.sentences,
              decoration: InputDecoration(
                hintText: "ie. Jake",
                hintStyle: formInput(
                  color: GlorifiColors.silver,
                ),
                filled: true,
                fillColor: GlorifiColors.white,
                suffixIcon: InputSuffixIcons(
                  suffixIcons: [
                    controller.preferredNameController.text.isNotEmpty
                        ? _inputClear(controller.preferredNameController)
                            .paddingOnly(right: 6)
                        : Container(),
                  ],
                ),
                enabledBorder:
                    controller.haveError.value ? errorBorder() : _border(),
                border: normalBorder(),
                focusedBorder:
                    controller.haveError.value ? errorBorder() : _border(),
                errorBorder: errorBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  !controller.preferredNameValid;
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

  Widget _inputClear(TextEditingController controller) {
    return InputSuffixIcon(
      iconData: Icons.close,
      iconColor: GlorifiColors.textFieldTextColor,
      onTap: () => _onInputClear(controller),
    );
  }

  _onInputClear(TextEditingController controller) {
    controller.clear();
    setState(() {
      controller.text;
    });
  }
}
