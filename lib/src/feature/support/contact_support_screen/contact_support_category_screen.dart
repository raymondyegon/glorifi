import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/controllers/support/contact_support_controller.dart';
import 'package:glorifi/src/feature/support/contact_support_screen/widget/contact_support_category_item.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_base_widget.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_widgets/adaptive_grid.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_widgets/adaptive_scaffold.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive_extensions.dart';
import 'package:glorifi/src/utils/text_constants.dart';
import 'package:glorifi/src/widgets/appbars/glorifi_appbar.dart';
import 'package:glorifi/src/widgets/buttons/app_button.dart';
import 'package:intl/intl.dart';

import '../../../controllers/support/faq_categories_controller.dart';
import '../../../widgets/appbars/glorifi_appbar.dart';

class ContactSupportCategoryScreen extends StatelessWidget {
  late FAQCategoriesController faqCategoriesController;

  ContactSupportCategoryScreen({Key? key}) : super(key: key) {
    faqCategoriesController = Get.find<FAQCategoriesController>();
  }

  @override
  Widget build(BuildContext context) {
    return AdaptiveScaffold(
      resizeToAvoidBottomInset: false,
      showSimpleAppBar: !faqCategoriesController.isLoggedIn,
      backgroundColor: GlorifiColors.basicLightGrey,
      appBar: GlorifiAppBar(
        title: TextConstants.contactSupport,
        leading: Leading(onTap: () {
          if (faqCategoriesController.isBottomSheet) {
            faqCategoriesController.navigationStack.removeAt(0);
            faqCategoriesController.update();
          } else {
            Get.back();
          }
        }),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0.w),
        child: AdaptiveBuilder(
          builder: (context, sizingInfo) {
            return GetBuilder<ContactSupportController>(
              init: ContactSupportController(),
              builder: (controller) => Column(
                children: [
                  if (!sizingInfo.isNativeMobile)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          TextConstants.contactSupport,
                          style: headlineBold26Primary(
                            color: GlorifiColors.cornflowerBlue,
                          ),
                        ),
                        AppButton(
                          height: 52,
                          elevation: 0,
                          backgroundColor:
                              GlorifiColors.primaryButtonProgressColor,
                          borderColor: GlorifiColors.primaryButtonProgressColor,
                          fontSize: 18.sp,
                          label: "     ${TextConstants.cancelText}     ",
                          textStyle: bodyBold18Primary(
                            color: GlorifiColors.white,
                          ),
                          onTap: () {
                            if (faqCategoriesController.isBottomSheet) {
                              faqCategoriesController.navigationStack
                                  .removeAt(0);
                              faqCategoriesController.update();
                            } else {
                              Get.back();
                            }
                          },
                        ),
                      ],
                    ).paddingOnly(
                        top: 24.h,
                        right: sizingInfo.isDesktop ? 180.w : 0,
                        left: sizingInfo.isDesktop ? 180.w : 0),
                  AdaptiveGrid(
                    children: [
                      AdaptiveGridItem(
                        nativeMobile: 100,
                        desktop: 100,
                        tablet: 100,
                        webMobile: 100,
                        child: Container(
                          color: GlorifiColors.superLightGrey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                TextConstants.letUsKnowWhat,
                                style: smallRegular16Primary(
                                  color: GlorifiColors.midnightBlue,
                                ),
                              ).paddingOnly(
                                top: 54.h,
                                bottom: 24.h,
                              ),
                            ],
                          ),
                        ),
                      ),
                      ...List<AdaptiveGridItem>.generate(
                        controller.faqCategoriesController.list.length,
                        (index) {
                          return AdaptiveGridItem(
                            nativeMobile: 100,
                            desktop: 100,
                            tablet: 100,
                            webMobile: 100,
                            child: ContactSupportCategoryItem(
                              onTap: () {
                                controller.callConversationEmailApi(
                                  toBeginningOfSentenceCase(
                                    controller
                                            .faqCategoriesController.list[index]
                                            .toLowerCase()
                                            .contains('general')
                                        ? 'general'
                                        : controller.faqCategoriesController
                                            .list[index],
                                  ),
                                );
                                controller.navigateToContactSupport(
                                  controller
                                      .faqCategoriesController.list[index],
                                );
                              },
                              title: toBeginningOfSentenceCase(controller
                                  .faqCategoriesController.list[index])!,
                            ).paddingOnly(bottom: 10.h),
                          );
                        },
                      ),
                    ],
                  ).paddingOnly(
                      left: sizingInfo.isDesktop ? 270.w : 0,
                      right: sizingInfo.isDesktop ? 270.w : 0)
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
