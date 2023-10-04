import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/controllers/support/contact_support_controller.dart';
import 'package:glorifi/src/controllers/support/faq_categories_controller.dart';
import 'package:glorifi/src/core/base/page_state.dart';
import 'package:glorifi/src/feature/support/contact_support_screen/widget/contract_support_item.dart';
import 'package:glorifi/src/feature/support/contact_support_screen/widget/footer_widget.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_base_widget.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_widgets/adaptive_scaffold.dart';
import 'package:glorifi/src/utils/glorifi_assets.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive_extensions.dart';
import 'package:glorifi/src/utils/text_constants.dart';
import 'package:glorifi/src/widgets/appbars/glorifi_appbar.dart';
import 'package:glorifi/src/widgets/loading/glorifi_spinner.dart';
import 'package:glorifi/src/widgets/web/page_header.dart';

import '../../../controllers/support/faq_categories_controller.dart';
import '../../../utils/constants.dart';

class ContactSupportScreen extends StatelessWidget {
  late FAQCategoriesController fAQCategoriesController;
  late ContactSupportController controller;
  bool? isOpenCallback = false;
  bool? isOpenChat = false;
  String? scheduleFormatted = '';

  ContactSupportScreen({
    Key? key,
  }) : super(key: key) {
    fAQCategoriesController = Get.find<FAQCategoriesController>();
    controller = Get.isRegistered<ContactSupportController>()
        ? Get.find<ContactSupportController>()
        : Get.put(ContactSupportController());

    getScheduledHourData();
  }

  @override
  Widget build(BuildContext context) {
    var category = Get.arguments?['category'];

    if (category == null) {
      category = fAQCategoriesController.selectedCategoryKey != null
          ? fAQCategoriesController.selectedCategoryKey
          : Get.parameters['category'];
    }

    return AdaptiveScaffold(
      resizeToAvoidBottomInset: false,
      showSimpleAppBar: !fAQCategoriesController.isLoggedIn,
      backgroundColor: GlorifiColors.basicLightGrey,
      appBar: GlorifiAppBar(
        title: TextConstants.contactSupport,
        leading: Leading(onTap: () {
          if (fAQCategoriesController.isBottomSheet) {
            fAQCategoriesController.navigationStack.removeAt(0);
            fAQCategoriesController.update();
          } else {
            Get.back();
          }
        }),
        trailing: Trailing(
          text: TextConstants.close,
          onTap: () {
            if (fAQCategoriesController.isBottomSheet) {
              fAQCategoriesController.navigationStack.removeWhere((index) {
                return index >= ContactSupportCategoryScreen;
              });
              fAQCategoriesController.update();
            } else {
              Get.until((route) => !Get.currentRoute.contains('support_'));
            }
          },
        ),
      ),
      body: AdaptiveBuilder(
        builder: (context, sizingInfo) {
          double horizontalPadding = sizingInfo.isDesktop
              ? 200.w
              : sizingInfo.isTablet
                  ? 34.5.w
                  : sizingInfo.isWebMobile
                      ? 24.5.w
                      : 23.75.w;
          double bodyHorizontalPadding = sizingInfo.isDesktop
              ? 380.w
              : sizingInfo.isTablet
                  ? 34.5.w
                  : sizingInfo.isWebMobile
                      ? 24.5.w
                      : 23.75.w;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (!sizingInfo.isNativeMobile)
                PageHeader(
                  headerTitle: TextConstants.contactSupport,
                  showWebPageFont: true,
                  horizontalPadding: horizontalPadding,
                  showTrailingButton: false,
                ),
              Obx(
                () => (controller.pageState == PageState.LOADING)
                    ? Center(
                        child: GlorifiSpinner(
                          size: 36,
                        ),
                      ).paddingOnly(
                        top: 128.h,
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: sizingInfo.isDesktop
                            ? MainAxisAlignment.start
                            : MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Visibility(
                                child: ContactSupportItem(
                                  title: TextConstants.chatWithAnAgent,
                                  assetIcon: GlorifiAssets.liveChat,
                                  onTap: () =>
                                      controller.navigateToChatScreen(category),
                                ),
                                visible: getIsOpenChatValue(),
                              ).paddingOnly(
                                top: 16.h,
                              ),
                              Visibility(
                                child: ContactSupportItem(
                                  title: TextConstants.requestCallBack,
                                  assetIcon: GlorifiAssets.callDark,
                                  onTap: () => controller
                                      .navigateToCallBackScreen(category),
                                ),
                                visible: getControllerIsOpenCallbackValue(),
                              ).paddingOnly(top: 16.h),
                              ContactSupportItem(
                                title: TextConstants.emailSupport,
                                assetIcon: GlorifiAssets.mailForward,
                                onTap: () =>
                                    controller.navigateToEmailSupport(category),
                              ).paddingOnly(
                                top: 16.h,
                              ),
                            ],
                          ),
                          Visibility(
                            visible: controller.scheduleHours.value
                                        .scheduleFormatted !=
                                    null &&
                                !controller.scheduleHours.value
                                    .scheduleFormatted!.isEmpty,
                            child: ContactSupportFooter(
                              scheduleHours: getScheduleFormatted(),
                            ).paddingOnly(
                              top: sizingInfo.isDesktop ? 32.h : 170.h,
                            ),
                          ),
                        ],
                      ).paddingOnly(
                        left: bodyHorizontalPadding,
                        right: bodyHorizontalPadding,
                        top: 32.h,
                      ),
              ),
            ],
          );
        },
      ),
    );
  }

  void getScheduledHourData() {
    isOpenChat = Get.parameters['isOpenChat'] == "true" ? true : false;
    isOpenCallback = Get.parameters['isOpenCallback'] == "true" ? true : false;
    scheduleFormatted = Get.parameters['scheduleFormatted'];
  }

  getControllerIsOpenCallbackValue() {
    bool? value = false;

    if (controller.scheduleHours.value.isOpenCallback != null &&
        controller.scheduleHours.value.isOpenCallback!) {
      value = true;
    } else {
      value = isOpenCallback;
    }
    return value;
  }

  getScheduleFormatted() {
    if (controller.scheduleHours.value.scheduleFormatted != null &&
        !controller.scheduleHours.value.scheduleFormatted!.isEmpty) {
      return controller.scheduleHours.value.scheduleFormatted;
    } else {
      return scheduleFormatted;
    }
  }

  getIsOpenChatValue() {
    bool? value = false;

    if (controller.scheduleHours.value.isOpenChat != null &&
        controller.scheduleHours.value.isOpenChat!) {
      value = true;
    } else {
      value = isOpenChat;
    }
    return value;
  }
}
