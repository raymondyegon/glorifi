import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/core/logger.dart';
import 'package:glorifi/src/feature/onboard/create_profile_plus/controllers/create_profile_controller.dart';
import 'package:glorifi/src/feature/onboard/create_profile_plus/create_profile_mobile.dart';
import 'package:glorifi/src/feature/onboard/create_profile_plus/utils/create_profile_constant.dart';
import 'package:glorifi/src/feature/onboard/create_profile_plus/utils/create_profile_info.dart';
import 'package:glorifi/src/feature/onboard/create_profile_plus/widgets/create_profile_container.dart';
import 'package:glorifi/src/feature/onboard/create_profile_plus/widgets/disable_emaji_formatter.dart';
import 'package:glorifi/src/feature/onboard/create_profile_plus/widgets/input_suffix_icon.dart';
import 'package:glorifi/src/feature/onboard/create_profile_plus/widgets/input_suffix_icons.dart';
import 'package:glorifi/src/feature/onboard/create_profile_plus/widgets/profile_border.dart';
import 'package:glorifi/src/feature/onboard/create_profile_plus/widgets/profile_button.dart';
import 'package:glorifi/src/feature/onboard/create_profile_plus/widgets/profile_colors.dart';
import 'package:glorifi/src/feature/onboard/create_profile_plus/widgets/profile_text.dart';
import 'package:glorifi/src/feature/onboard/create_profile_plus/widgets/show_input_info.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/glorifi_values.dart';
import 'package:glorifi/src/utils/text_constants.dart';
import 'package:glorifi/src/widgets/buttons/primary_button.dart';
import 'package:glorifi/src/utils/responsive/responsive.dart';

import '../../../font_style_global.dart';
import '../../../utils/adaptive/adaptive_base_widget.dart';

class CreateProfileName extends StatefulWidget {
  CreateProfileName({Key? key}) : super(key: key);

  @override
  _CreateProfileNameState createState() => _CreateProfileNameState();
}

class _CreateProfileNameState extends State<CreateProfileName> {
  final GlobalKey<FormState> _nameFormKey = GlobalKey();
  final controller = Get.find<CreateProfileController>();

  final FocusNode _firstNameFocus = FocusNode();
  final FocusNode _middleNameFocus = FocusNode();
  final FocusNode _lastNameFocus = FocusNode();
  final FocusNode _preferredNameFocus = FocusNode();

  bool isButtonPressed = false;
  bool shouldShowFirstNameError = true;
  bool shouldShowMiddleNameError = true;
  bool shouldShowLastNameError = true;
  bool shouldShowPreferredNameError = true;

  void _saveForm() {
    setState(() {
      shouldShowFirstNameError = true;
      shouldShowMiddleNameError = true;
      shouldShowLastNameError = true;
      shouldShowPreferredNameError = true;
      isButtonPressed = true;
    });

    validateFirstName();
    validateLastName();
    validateMiddleName();
    validatePrefferedName();

    if (!controller.haveFirstNameError.value  && !controller.haveLastNameError.value && !controller.haveMiddleNameError.value && !controller.havePreferredNameError.value) {
      Log.debug('Got a valid name');
      removeLastSpace();
      Get.to(() => CreateProfileMobile());
    }
  }

  removeLastSpace() {
    controller.firstNameController.text =
        controller.firstNameController.text.trimRight();
    controller.lastNameController.text =
        controller.lastNameController.text.trimRight();
    controller.middleNameController.text =
        controller.middleNameController.text.trimRight();
    controller.preferredNameController.text =
        controller.preferredNameController.text.trimRight();
  }

  showReasonBottomSheet() {
    showModalBottomSheet<void>(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      builder: (BuildContext context) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text("This is the reason we ask for Email"),
            profileNextButton(context, "Got it!", Container(), () {
              Navigator.pop(context);
            })
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return AdaptiveBuilder(builder: (context, sizingInfo) {
      return CreateProfileContainer(
        percent: 0.4,
        pageTitles: createProfileTitles,
        progressBarActiveTitle: createProfileTitles[1],
        title: CreateProfileInfo.nameScreenTitle,
        text: CreateProfileInfo.nameScreenSubtitle,
        child: Form(
          key: _nameFormKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _getFirstNameView(controller, sizingInfo),
              _getMiddleNameView(controller, sizingInfo),
              _getLastNameView(controller, sizingInfo),
              _getPreferredNameView(controller, sizingInfo),
              SizedBox(height: GlorifiValues.margin_32),
              PrimaryButton(
                height: 64.h,
                title: TextConstants.continueButton,
                fontSize: 18.sp,
                hasRightArrow: true,
                textColor: GlorifiColors.midnightBlueColor,
                onTap: _saveForm,
              ),
            ],
          ),
        ).paddingOnly(top: 30.h),
      );
    });
  }

  Widget _inputClear(TextEditingController controller,
      {Function()? doExtraOnInputClear}) {
    return InputSuffixIcon(
      iconData: Icons.close,
      iconColor: profileTextColor,
      onTap: () {
        _onInputClear(controller);
        doExtraOnInputClear?.call();
      },
    );
  }

  _onInputClear(TextEditingController editingController) {
    editingController.clear();
    setState(() {
      editingController.text;
    });
  }

  Widget _inputInfo(
    sizingInfo, {
    String inforTitle = "This is the title",
    String infoMessage = "This is the reason we ask for name",
  }) {
    return InputSuffixIcon(
      iconData: Icons.info_outline_rounded,
      iconColor: profileTextColor,
      onTap: () => sizingInfo.isWebMobile || sizingInfo.isNativeMobile
          ? showBottomSheetLog(context, inforTitle, infoMessage)
          : showInfoDialog(context, inforTitle, infoMessage),
    );
  }

  Widget _getFirstNameView(CreateProfileController controller, sizingInfo) {
    final infoWidget = _inputInfo(
      sizingInfo,
      inforTitle: CreateProfileInfo.firstNameQueryHint,
      infoMessage: CreateProfileInfo.firstNameInfo,
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Obx(() => TextFormField(
              inputFormatters: [
                DisableEmojiInputFilter.getDisableEmojiInputFilter(),
                FilteringTextInputFormatter.allow(
                  RegExp("[a-zA-Z -@.\/#&+\w\s]"),
                ),
                FilteringTextInputFormatter.deny(
                    controller.firstNameController.value.text.length > 0
                        ? RegExp('')
                        : RegExp(' ')),
              ],
              textCapitalization: TextCapitalization.words,
              textInputAction: TextInputAction.next,
              autofocus: true,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              style: TextStyle(color: profileTextColor),
              onFieldSubmitted: (term) {
                _fieldFocusChange(context, _firstNameFocus, _middleNameFocus);
              },
              controller: controller.firstNameController,
              decoration: InputDecoration(
                suffixIcon: controller.firstNameController.text.isNotEmpty
                    ? InputSuffixIcons(
                        suffixIcons: [
                          _inputClear(
                            controller.firstNameController,
                            doExtraOnInputClear: () {
                              shouldShowFirstNameError = false;
                            },
                          ),
                          infoWidget.paddingOnly(right: 9)
                        ],
                      )
                    : infoWidget,
                labelStyle: TextStyle(color: textInputPlaceholderColor),
                enabledBorder: controller.haveFirstNameError.value
                    ? errorBorder()
                    : normalBorder(),
                border: normalBorder(),
                focusedBorder: controller.haveFirstNameError.value
                    ? errorBorder()
                    : activeBorder(),
                errorBorder: errorBorder(),
                labelText: 'Legal First Name',
                floatingLabelStyle: TextStyle(color: profileTextColor),
              ),
              onChanged: (value) {
                //final bool isValid = _nameFormKey.currentState!.validate();
                validateFirstName();
                setState(() {
                  shouldShowFirstNameError = true;
                  !controller.firstNameValid;
                  isButtonPressed = false;
                });
              },
            )),

        Obx(() => (controller.haveFirstNameError.value)
            ? Container(
          margin: EdgeInsets.only(top: 4, left: 4),
          child: Text(
            controller.errorMessageFirstName.value,
            style: formHintOrError(color: profileRed),
          ),
        )
            : Container())

      ],
    );
  }

  validateFirstName() {
    if (!shouldShowFirstNameError) {
      controller.haveFirstNameError.value = false;
      return null;
    }
    if (!isButtonPressed) {
      controller.haveFirstNameError.value = false;
      return null;
    }
    if (!controller.firstNameValid) {
      if (controller.firstNameController.text.isEmpty) {
        controller.haveFirstNameError.value = true;
        controller.errorMessageFirstName.value = 'First name is required';
        return null;
      } else {
        controller.haveFirstNameError.value = true;
        controller.errorMessageFirstName.value =
            'Please enter a valid first name';
        return null;
      }
    }
  }

  Widget _getMiddleNameView(CreateProfileController controller, sizingInfo) {
    final infoWidget = _inputInfo(
      sizingInfo,
      inforTitle: CreateProfileInfo.middleNameQueryHint,
      infoMessage: CreateProfileInfo.middleNameInfo,
    );
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Obx(() => TextFormField(
            inputFormatters: [
              DisableEmojiInputFilter.getDisableEmojiInputFilter(),
              FilteringTextInputFormatter.allow(
                RegExp("[a-zA-Z -@.\/#&+\w\s]"),
              ),
              FilteringTextInputFormatter.deny(
                  controller.firstNameController.value.text.length > 0
                      ? RegExp('')
                      : RegExp(' ')),
            ],
            textCapitalization: TextCapitalization.words,
            focusNode: _middleNameFocus,
            textInputAction: TextInputAction.next,
            style: TextStyle(color: profileTextColor),
            onFieldSubmitted: (term) {
              _fieldFocusChange(context, _middleNameFocus, _lastNameFocus);
            },
            controller: controller.middleNameController,
            decoration: InputDecoration(
              suffixIcon: controller.middleNameController.text.isNotEmpty
                  ? InputSuffixIcons(
                      suffixIcons: [
                        _inputClear(
                          controller.middleNameController,
                          doExtraOnInputClear: () {
                            shouldShowMiddleNameError = false;
                            _nameFormKey.currentState!.validate();
                          },
                        ),
                        infoWidget.paddingOnly(right: 9)
                      ],
                    )
                  : infoWidget,
              labelStyle: TextStyle(color: textInputPlaceholderColor),
              labelText: 'Legal Middle Name (optional)',
              floatingLabelStyle: TextStyle(color: profileTextColor),
              enabledBorder: controller.haveMiddleNameError.value
                  ? errorBorder()
                  : normalBorder(),
              border: normalBorder(),
              focusedBorder: controller.haveMiddleNameError.value
                  ? errorBorder()
                  : activeBorder(),
              errorBorder: errorBorder(),
              hintText: 'e.g. Marie, Andrew',
              hintStyle: TextStyle(color: textInputPlaceholderColor),
            ),
            onChanged: (value) {
              validateMiddleName();
              setState(() {
                shouldShowMiddleNameError = true;
                !controller.middleNameValid;
                isButtonPressed = false;
              });
            },

          ).paddingOnly(top: 20),),
      Obx(() => (controller.haveMiddleNameError.value)
          ? Container(
        margin: EdgeInsets.only(top: 4, left: 4),
        child: Text(
          controller.errorMessageMiddleName.value,
          style: formHintOrError(color: profileRed),
        ),
      )
          : Container())

    ]);
  }

  validateMiddleName() {
    if (!shouldShowMiddleNameError) {
      controller.haveMiddleNameError.value = false;
      return null;
    }
    if (!isButtonPressed) {
      controller.haveMiddleNameError.value = false;
      return null;
    }
    if (!controller.middleNameValid) {
      controller.haveMiddleNameError.value = true;
      controller.errorMessageMiddleName.value =
          'Please enter a valid middle name';
      return null;
    }
    controller.haveMiddleNameError.value = false;
    return null;
  }

  Widget _getLastNameView(CreateProfileController controller, sizingInfo) {
    var inputInfo = _inputInfo(
      sizingInfo,
      inforTitle: CreateProfileInfo.lastNameQueryHint,
      infoMessage: CreateProfileInfo.lastNameInfo,
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
         Obx(() => TextFormField(
              inputFormatters: [
                DisableEmojiInputFilter.getDisableEmojiInputFilter(),
                FilteringTextInputFormatter.allow(
                  RegExp("[a-zA-Z -@.\/#&+\w\s]"),
                ),
                FilteringTextInputFormatter.deny(
                    controller.firstNameController.value.text.length > 0
                        ? RegExp('')
                        : RegExp(' ')),
              ],
              textCapitalization: TextCapitalization.words,
              focusNode: _lastNameFocus,
              textInputAction: TextInputAction.next,
              style: TextStyle(color: profileTextColor),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              onFieldSubmitted: (term) {
                _fieldFocusChange(context, _lastNameFocus, _preferredNameFocus);
              },
              controller: controller.lastNameController,
              decoration: InputDecoration(
                suffixIcon: controller.lastNameController.text.isNotEmpty
                    ? InputSuffixIcons(
                        suffixIcons: [
                          _inputClear(
                            controller.lastNameController,
                            doExtraOnInputClear: () {
                              shouldShowLastNameError = false;
                            },
                          ),
                          inputInfo.paddingOnly(right: 9)
                        ],
                      )
                    : inputInfo,
                enabledBorder: controller.haveLastNameError.value
                    ? errorBorder()
                    : normalBorder(),
                border: normalBorder(),
                focusedBorder: controller.haveLastNameError.value
                    ? errorBorder()
                    : activeBorder(),
                errorBorder: errorBorder(),
                labelStyle: TextStyle(color: textInputPlaceholderColor),
                labelText: 'Legal Last Name',
                floatingLabelStyle: TextStyle(color: profileTextColor),
                hintStyle: TextStyle(color: textInputPlaceholderColor),
              ),
              onChanged: (value) {
                //final bool isValid = _nameFormKey.currentState!.validate();
                validateLastName();
                setState(() {
                  shouldShowLastNameError = true;
                  !controller.lastNameValid;
                  isButtonPressed = false;
                });
              },
            ).paddingOnly(top: 20),),

        Obx(() => (controller.haveLastNameError.value)
            ? Container(
          margin: EdgeInsets.only(top: 4, left: 4),
          child: Text(
            controller.errorMessageLastName.value,
            style: formHintOrError(color: profileRed),
          ),
        )
            : Container())

      ],
    );
  }

  validateLastName() {
    if (!shouldShowLastNameError) {
      controller.haveLastNameError.value = false;
      return null;
    }
    if (!isButtonPressed) {
      controller.haveLastNameError.value = false;
      return null;
    }
    if (!controller.lastNameValid) {
      if (controller.lastNameController.text.isEmpty) {
        controller.haveLastNameError.value = true;
        controller.errorMessageLastName.value = 'Last name is required';
        return null;
      } else {
        controller.haveLastNameError.value = true;
        controller.errorMessageLastName.value =
            'Please enter a valid last name';
        return null;
      }
    }
    controller.haveLastNameError.value = false;
    return null;
  }

  Widget _getPreferredNameView(CreateProfileController controller, sizingInfo) {
    var inputInfo = _inputInfo(
      sizingInfo,
      inforTitle: CreateProfileInfo.preferredNameQueryHint,
      infoMessage: CreateProfileInfo.preferredNameInfo,
    );
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
       Obx(() => TextFormField(
            inputFormatters: [
              DisableEmojiInputFilter.getDisableEmojiInputFilter(),
              FilteringTextInputFormatter.allow(
                RegExp("[a-zA-Z -@.\/#&+\w\s]"),
              ),
              FilteringTextInputFormatter.deny(
                  controller.firstNameController.value.text.length > 0
                      ? RegExp('')
                      : RegExp(' ')),
            ],
            textCapitalization: TextCapitalization.words,
            focusNode: _preferredNameFocus,
            textInputAction: TextInputAction.done,
            style: TextStyle(color: profileTextColor),
            onFieldSubmitted: (term) {
              _preferredNameFocus.unfocus();
            },
            controller: controller.preferredNameController,

            decoration: InputDecoration(
              suffixIcon: controller.preferredNameController.text.isNotEmpty
                  ? InputSuffixIcons(
                      suffixIcons: [
                        _inputClear(
                          controller.preferredNameController,
                          doExtraOnInputClear: () {
                            setState(() {
                              shouldShowPreferredNameError = false;
                              _nameFormKey.currentState!.validate();
                            });
                          },
                        ),
                        inputInfo.paddingOnly(right: 9)
                      ],
                    )
                  : inputInfo,
              labelStyle: TextStyle(color: textInputPlaceholderColor),
              enabledBorder: controller.havePreferredNameError.value
                  ? errorBorder()
                  : normalBorder(),
              border: normalBorder(),
              focusedBorder: controller.havePreferredNameError.value
                  ? errorBorder()
                  : activeBorder(),
              errorBorder: errorBorder(),
              labelText: 'Preferred Name (optional)',
              floatingLabelStyle: TextStyle(color: profileTextColor),

            ),
            onChanged: (value) {
              validatePrefferedName();
              setState(() {
                shouldShowPreferredNameError = true;
                !controller.middleNameValid;
                controller.preferredNameController;
              });
            },
          ).paddingOnly(top: 20),),
      Obx(() => (controller.havePreferredNameError.value)
          ? Container(
        margin: EdgeInsets.only(top: 4, left: 4),
        child: Text(
          controller.errorMessagePreferredName.value,
          style: formHintOrError(color: profileRed),
        ),
      )
          : Container())


    ]);
  }


  validatePrefferedName(){
    if (!shouldShowPreferredNameError) {
      controller.havePreferredNameError.value=false;
      return null;
    }
    if (!isButtonPressed) {
      controller.havePreferredNameError.value=false;
      return null;
    }
    if (!controller.preferredNameValid) {
      controller.havePreferredNameError.value=true;
      controller.errorMessagePreferredName.value= 'Please enter a valid preferred name';
      return null;
    }

    controller.havePreferredNameError.value=false;
    return null;
  }

  void _fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }
}
