import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/core/data_helper.dart';
import 'package:glorifi/src/core/logger.dart';
import 'package:glorifi/src/feature/onboard/create_profile_plus/controllers/create_profile_controller.dart';
import 'package:glorifi/src/feature/onboard/create_profile_plus/create_profile_name.dart';
import 'package:glorifi/src/feature/onboard/create_profile_plus/utils/create_profile_constant.dart';
import 'package:glorifi/src/feature/onboard/create_profile_plus/utils/create_profile_info.dart';
import 'package:glorifi/src/feature/onboard/create_profile_plus/widgets/create_profile_container.dart';
import 'package:glorifi/src/feature/onboard/create_profile_plus/widgets/disable_emaji_formatter.dart';
import 'package:glorifi/src/feature/onboard/create_profile_plus/widgets/input_suffix_icon.dart';
import 'package:glorifi/src/feature/onboard/create_profile_plus/widgets/input_suffix_icons.dart';
import 'package:glorifi/src/feature/onboard/create_profile_plus/widgets/profile_border.dart';
import 'package:glorifi/src/feature/onboard/create_profile_plus/widgets/profile_colors.dart';
import 'package:glorifi/src/feature/onboard/create_profile_plus/widgets/profile_text.dart';
import 'package:glorifi/src/feature/onboard/create_profile_plus/widgets/show_input_info.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_base_widget.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/glorifi_values.dart';
import 'package:glorifi/src/utils/responsive/responsive.dart';
import 'package:glorifi/src/utils/text_constants.dart';
import 'package:glorifi/src/widgets/buttons/primary_button.dart';

import '../../../font_style_global.dart';

class CreateProfilePlus extends StatefulWidget {
  static const routeName = '/create-profilePlus';

  CreateProfilePlus({Key? key}) : super(key: key);

  @override
  _CreateProfilePlusState createState() => _CreateProfilePlusState();
}

class _CreateProfilePlusState extends State<CreateProfilePlus> {
  final _dataHelper = DataHelperImpl.instance;

  final GlobalKey<FormState> _emailFormKey = GlobalKey();
  late CreateProfileController controller;

  bool isButtonPressed = false;

  Future<void> _saveForm() async {
    // Get.to(() => CreateProfileSecure());
    // return;
    setState(() {
      isButtonPressed = true;
    });
    validateEmail();
    if (!controller.haveEmailError.value) {
      setState(() {
        controller.loading = true;
      });
      final res = await _dataHelper.apiHelper
          .validateEmail(controller.emailController.text);
      setState(() {
        controller.loading = false;
      });
      res.fold((l) {
        Log.error(l.errorMessage);
      }, (r) {
        if (r == "false") {
          final dialogContextCompleter = Completer<BuildContext>();
          showDialog(
            context: context,
            builder: (BuildContext dialogContext) {
              if (!dialogContextCompleter.isCompleted) {
                dialogContextCompleter.complete(dialogContext);
              }
              return CupertinoAlertDialog(
                title: Text(
                    'It looks like that email is already in use, If you have an account, please sign in.'),
                content: Text(
                    'Otherwise, try creating your account using a different email address.'),
                actions: [
                  CupertinoDialogAction(
                    child: Text("Okay"),
                    onPressed: () async {
                      final dialogContext = await dialogContextCompleter.future;
                      Navigator.pop(dialogContext);
                      controller.emailController.text = "";
                    },
                  )
                ],
              );
            },
          );
        } else {
          Get.to(() => CreateProfileName());
        }
      });
    }
  }

  @override
  void initState() {
    super.initState();
    Get.put(CreateProfileController());
    controller = Get.find<CreateProfileController>();
  }

  @override
  Widget build(BuildContext context) {
    if (ModalRoute.of(context)!.settings.arguments != null) {
      final args = ModalRoute.of(context)!.settings.arguments as String;
      controller.redirectArgument = args;
    }
    return AdaptiveBuilder(
      builder: (context, sizingInfo) {
        return CreateProfileContainer(
          pageTitles: createProfileTitles,
          progressBarActiveTitle: createProfileTitles[0],
          sizingInfo: sizingInfo,
          percent: 0.2,
          title: CreateProfileInfo.emailScreenTitle,
          text: CreateProfileInfo.emailScreenSubtitle,
          child: Center(
            child: Form(
              key: _emailFormKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Obx(
                    () => TextFormField(
                      inputFormatters: [
                        DisableEmojiInputFilter.getDisableEmojiInputFilter(),
                        FilteringTextInputFormatter.deny(RegExp(r"\s\b|\b\s"))
                      ],
                      autocorrect: false,
                      enableSuggestions: false,
                      keyboardType: TextInputType.emailAddress,
                      autofocus: true,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      style: TextStyle(color: profileTextColor),

                      controller: controller.emailController,
                      decoration: InputDecoration(
                        suffixIcon: controller.emailController.text.isNotEmpty
                            ? InputSuffixIcons(
                                suffixIcons: [
                                  _inputClear(controller.emailController),
                                  _inputInfo(sizingInfo)
                                      .paddingOnly(right: 9.w),
                                ],
                              )
                            : _inputInfo(sizingInfo),
                        labelStyle: TextStyle(color: textInputPlaceholderColor),
                        enabledBorder: controller.haveEmailError.value ? errorBorder() :  normalBorder(),
                        border: normalBorder(),
                        focusedBorder:  controller.haveEmailError.value ? errorBorder() : activeBorder(),
                        errorBorder: errorBorder(),
                        labelText: 'Email Address',
                        floatingLabelStyle: TextStyle(color: profileTextColor),
                      ),
                      onChanged: (value) {

                        validateEmail();
                        setState(() {
                          controller.emailController.text;
                          isButtonPressed = false;
                        });
                      },
                      onEditingComplete: () {
                        setState(() {
                          !controller.validEmail;
                        });
                        if (controller.validEmail) {
                          FocusScope.of(context).requestFocus(FocusNode());
                        }
                      },
                    ),
                  ),
                  Obx(() => (controller.haveEmailError.value)
                      ? Container(
                          margin: EdgeInsets.only(top: 4, left: 4),
                          child: Text(
                            controller.errorMessageEmail.value,
                            style: formHintOrError(color: profileRed),
                          ),
                        )
                      : Container()),
                  SizedBox(height: GlorifiValues.smallMargin),
                  SizedBox(height: GlorifiValues.margin_32),
                  PrimaryButton(
                    height: 64.h,
                    title: TextConstants.continueButton,
                    fontSize: 18.sp,
                    textColor: GlorifiColors.midnightBlueColor,
                    hasRightArrow: true,
                    onTap: _saveForm,
                    isLoading: controller.loading,
                  ),
                ],
              ),
            ).paddingOnly(top: 30.h),
          ),
        );
      },
    );
  }

  validateEmail(){
    if (!isButtonPressed) {
      controller.haveEmailError.value=false;
      return null;
    }
    if (!controller.validEmail) {
      if (controller.emailController.text.isEmpty) {
        controller.haveEmailError.value=true;
        controller.errorMessageEmail.value= 'Email is required';
        return null;


      } else {
        controller.haveEmailError.value=true;
        controller.errorMessageEmail.value= 'Please enter a valid email';
        return null;

      }
    }
    controller.haveEmailError.value=false;
    return null;
  }

  Widget _inputClear(TextEditingController controller) {
    return InputSuffixIcon(
      iconData: Icons.close,
      iconColor: profileTextColor,
      onTap: () => _onInputClear(controller),
    );
  }

  _onInputClear(TextEditingController controller) {
    controller.clear();
    setState(() {
      controller.text;
      isButtonPressed = false;
    });
  }

  Widget _inputInfo(sizingInfo) {
    return InputSuffixIcon(
      iconData: Icons.info_outline_rounded,
      iconColor: profileTextColor,
      onTap: () => sizingInfo.isWebMobile || sizingInfo.isNativeMobile
          ? showBottomSheetLog(
              context,
              CreateProfileInfo.emailQuery,
              CreateProfileInfo.emailInfo,
            )
          : showInfoDialog(
              context,
              CreateProfileInfo.emailQuery,
              CreateProfileInfo.emailInfo,
            ),
    );
  }
}
