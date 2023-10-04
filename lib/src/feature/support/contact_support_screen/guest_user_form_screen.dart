import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/controllers/support/faq_categories_controller.dart';
import 'package:glorifi/src/controllers/support/guest_user_controller.dart';
import 'package:glorifi/src/feature/onboard/create_profile_plus/widgets/birthday_formatter.dart';
import 'package:glorifi/src/feature/onboard/create_profile_plus/widgets/disable_emaji_formatter.dart';
import 'package:glorifi/src/feature/onboard/create_profile_plus/widgets/input_suffix_icon.dart';
import 'package:glorifi/src/feature/support/support_widgets/faq_textfield_widget.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_base_widget.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_sizing.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_widgets/adaptive_grid.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_widgets/adaptive_scaffold.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive_extensions.dart';
import 'package:glorifi/src/utils/text_constants.dart';
import 'package:glorifi/src/widgets/appbars/glorifi_appbar.dart';
import 'package:glorifi/src/widgets/shared/app_button.dart';
import 'package:glorifi/src/widgets/web/page_header.dart';
import 'package:intl/intl.dart';

class GuestUserFormScreen extends StatelessWidget {
  //todo take care of bindings in app_pages. That is not useful for bottomsheet navigation
  late FAQCategoriesController fAQCategoriesController;
  late GuestUserController controller;
  String? category = '';
  String? method = '';

  GuestUserFormScreen({Key? key}) : super(key: key) {
    fAQCategoriesController = Get.find<FAQCategoriesController>();
    controller = Get.isRegistered<GuestUserController>()
        ? Get.find<GuestUserController>()
        : Get.put(GuestUserController());

    if (Get.parameters['category'] != null) {
      category = Get.parameters['category'];
    } else {
      category = toBeginningOfSentenceCase(
        (Get.arguments != null)
            ? Get.arguments['category'].toLowerCase().contains('general')
                ? 'general'
                : Get.arguments['category']
            : fAQCategoriesController.selectedSupportCategoryTitle,
      );
    }
    if (Get.parameters['method'] != null) {
      method = Get.parameters['method'];
    } else {
      method = (Get.arguments != null)
          ? (Get.arguments['method'] ??
                  fAQCategoriesController.selectedSupportMethod) ??
              'email'
          : fAQCategoriesController.selectedSupportMethod;
    }
  }

  final Map titles = {
    'email': 'Email Support',
    'callback': 'Request a Callback',
    'chat': 'Chat with an Agent',
  };

  @override
  Widget build(BuildContext context) {
    return AdaptiveBuilder(
      builder: (context, sizingInfo) {
        return AdaptiveScaffold(
          backgroundColor: GlorifiColors.productsBgWhite,
          resizeToAvoidBottomInset: false,
          showSimpleAppBar: !fAQCategoriesController.isLoggedIn,
          appBar: GlorifiAppBar(
            title: titles[method],
            disableLeading: true,
            trailing: Trailing(
              text: "Cancel",
              onTap: () {
                if (fAQCategoriesController.isBottomSheet) {
                  fAQCategoriesController.navigationStack.removeAt(0);
                  fAQCategoriesController.update();
                } else {
                  Get.back();
                }
              },
            ),
          ),
          body: SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: sizingInfo.isDesktop
                  ? 200.w
                  : sizingInfo.isTablet
                      ? 34.5.w
                      : 24.w,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (!sizingInfo.isNativeMobile)
                  PageHeader(
                    headerTitle: titles[method],
                    headerButtonTitle: "Cancel",
                    headerButtonOnTap: Get.back,
                    horizontalPadding: 0,
                    showWebPageFont: true,
                  ),
                Text(
                  "Before we can connect you with an${sizingInfo.isDesktop ? ' ' : '\n'}agent, please provide the following information:",
                  style: bodyRegular18Primary(
                    color: GlorifiColors.midnightBlueColor,
                  ),
                  textAlign: TextAlign.start,
                ).marginOnly(
                  top: (sizingInfo.isDesktop)
                      ? 16.h
                      : (sizingInfo.isWebMobile)
                          ? 32.h
                          : 48.h,
                  bottom: (sizingInfo.isDesktop) ? 72.h : 32.h,
                ),
                ConstrainedBox(
                  constraints: BoxConstraints(minWidth: 1024),
                  child: _pageBody(sizingInfo),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _pageBody(AdaptiveSizingInfo sizingInfo) {
    return AdaptiveGrid(
      children: [
        if (sizingInfo.isDesktop)
          AdaptiveGridItem(
            desktop: 15,
          ),
        AdaptiveGridItem(
          webMobile: 100,
          nativeMobile: 100,
          tablet: 100,
          desktop: 70,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(
                () => FaqTextField(
                  title: 'Name',
                  hint: 'e.g. Jacob',
                  hintStyle: formInput(
                    color: GlorifiColors.greyBgColor,
                  ),
                  isCapitalizationNeeded: true,
                  controller: controller.nameController,
                  errorText: controller.nameError.value,
                  onChanged: (val) => controller.onNameChanged(val),
                  isValid: controller.nameIsNotValid.value,
                  suffixWidget: Visibility(
                    visible: controller.nameController.text.isNotEmpty,
                    child: InputSuffixIcon(
                      iconData: Icons.close,
                      iconColor: GlorifiColors.midnightBlue,
                      onTap: () {
                        controller.nameController.clear();
                      },
                    ),
                  ),
                  inputFormatter: <TextInputFormatter>[
                    DisableEmojiInputFilter.getDisableEmojiInputFilter(),
                    FilteringTextInputFormatter.deny(
                      RegExp(r'^\s*'),
                    )
                  ],
                ).paddingOnly(
                  bottom: 15.h,
                ),
              ),
              Obx(
                () => FaqTextField(
                  title: 'Email',
                  hint: 'example@email.com',
                  hintStyle: formInput(
                    color: GlorifiColors.greyBgColor,
                  ),
                  inputFormatter: <TextInputFormatter>[
                    DisableEmojiInputFilter.getDisableEmojiInputFilter()
                  ],
                  controller: controller.emailController,
                  errorText: controller.emailError.value,
                  onChanged: (val) => controller.onEmailChanged(val),
                  isValid: controller.emailIsNotValid.value,
                  suffixWidget: Visibility(
                    visible: controller.emailController.text.isNotEmpty,
                    child: InputSuffixIcon(
                      iconData: Icons.close,
                      iconColor: GlorifiColors.midnightBlue,
                      onTap: () {
                        controller.emailController.clear();
                      },
                    ),
                  ),
                ).paddingOnly(
                  bottom: 15.h,
                ),
              ),
              Obx(
                () => FaqTextField(
                  title: 'Phone',
                  hint: '555-555-5555',
                  hintStyle: formInput(
                    color: GlorifiColors.greyBgColor,
                  ),
                  controller: controller.phoneController,
                  errorText: controller.phoneError.value,
                  onChanged: (val) => controller.onNumberChanged(val),
                  isValid: controller.phoneIsNotValid.value,
                  textInputType: TextInputType.number,
                  suffixWidget: Visibility(
                    visible: controller.phoneController.text.isNotEmpty,
                    child: InputSuffixIcon(
                      iconData: Icons.close,
                      iconColor: GlorifiColors.midnightBlue,
                      onTap: () {
                        controller.phoneController.clear();
                      },
                    ),
                  ),
                  inputFormatter: <TextInputFormatter>[
                    CardFormatter(
                      sample: 'xxx-xxx-xxxx',
                      separator: '-',
                    ),
                    LengthLimitingTextInputFormatter(12),
                  ],
                ).paddingOnly(
                  bottom: 15.h,
                ),
              ),
              AppButton(
                onTap: () => controller.validate(method, category),
                textColor: GlorifiColors.white,
                textStyle: bodyBold18Primary(
                  color: GlorifiColors.white,
                ),
                label: TextConstants.continueButton,
                backgroundColor: GlorifiColors.darkBlueColor,
                height: 64,
              ).paddingOnly(
                top: 24.h,
              ),
            ],
          ),
        ),
        if (sizingInfo.isDesktop)
          AdaptiveGridItem(
            desktop: 15,
          ),
      ],
    );
  }
}
