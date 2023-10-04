import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/controllers/support/faq_categories_controller.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_base_widget.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_widgets/adaptive_grid.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_widgets/adaptive_scaffold.dart';
import 'package:glorifi/src/utils/constants.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive_extensions.dart';
import 'package:glorifi/src/widgets/shared/app_button.dart';

class ContactSupportErrorScreen extends StatelessWidget {
  late FAQCategoriesController fAQCategoriesController;

  ContactSupportErrorScreen({Key? key}) : super(key: key) {
    fAQCategoriesController = Get.find<FAQCategoriesController>();
  }

  @override
  Widget build(BuildContext context) {
    return AdaptiveScaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: GlorifiColors.superLightGrey,
      body: AdaptiveBuilder(
        builder: (context, sizingInfo) {
          return Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: GestureDetector(
                  child: Icon(
                    Icons.arrow_back_ios_outlined,
                    color: GlorifiColors.biscayBlue,
                    size: 20.sp,
                  ).paddingOnly(
                      left: 32.h, top: 72.h, right: 32.h, bottom: 72.h),
                  onTap: () {
                    if (fAQCategoriesController.isBottomSheet) {
                      fAQCategoriesController.navigationStack
                          .removeWhere((index) {
                        return index > ContactSupportCategoryScreen;
                      });
                      fAQCategoriesController.update();
                    } else {
                      Get.until(
                          (route) => !Get.currentRoute.contains('support_'));
                    }
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: sizingInfo.isDesktop
                      ? 450.w
                      : sizingInfo.isTablet
                          ? 34.5.w
                          : 24.w,
                ),
                child: AdaptiveGrid(
                  children: [
                    AdaptiveGridItem(
                      nativeMobile: 100,
                      desktop: 100,
                      tablet: 100,
                      webMobile: 100,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            alignment: sizingInfo.isDesktop
                                ? Alignment.center
                                : Alignment.centerLeft,
                            child: Text(
                              'Sorry, support is currently unavailable.',
                              textAlign: TextAlign.start,
                              style: headlineSemiBold31Primary(
                                color: GlorifiColors.cornflowerBlue,
                              ),
                            ),
                          ).paddingOnly(bottom: 32.h, top: 162.h),
                          Container(
                            alignment: sizingInfo.isDesktop
                                ? Alignment.center
                                : Alignment.centerLeft,
                            child: Text(
                              'We apologize for the inconvenience. We are experiencing technical issues. Please try again later, or see if your question is in our FAQs.',
                              textAlign: sizingInfo.isDesktop
                                  ? TextAlign.center
                                  : TextAlign.start,
                              style: smallRegular16Primary(
                                color: GlorifiColors.cornflowerBlue,
                              ),
                            ),
                          ).paddingOnly(
                            bottom: sizingInfo.isDesktop ? 36.h : 40.h,
                          ),
                          AppButton(
                            onTap: () {
                              if (fAQCategoriesController.isBottomSheet) {
                                fAQCategoriesController.navigationStack
                                    .removeWhere((index) {
                                  return index > FaqCategoryListingScreen;
                                });
                                fAQCategoriesController.update();
                              } else {
                                Get.until((route) =>
                                    !Get.currentRoute.contains('support_'));
                              }
                            },
                            textStyle: bodyBold18Primary(
                              color: GlorifiColors.superLightGrey,
                            ),
                            label: 'Frequently Asked Questions',
                            backgroundColor: GlorifiColors.midnightBlue,
                            height: 64,
                          ).paddingOnly(top: 90.h),
                        ],
                      ).paddingOnly(
                        bottom: 88.h,
                      ),
                    ),
                  ],
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
