import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/controllers/support/contact_support_controller.dart';
import 'package:glorifi/src/core/data_helper.dart';
import 'package:glorifi/src/feature/banking/deposit_check_view_review/print.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/routes/app_pages.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_base_widget.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_widgets/adaptive_grid.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_widgets/adaptive_scaffold.dart';
import 'package:glorifi/src/utils/glorifi_assets.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive_extensions.dart';
import 'package:glorifi/src/widgets/shared/app_button.dart';
import 'package:http/http.dart';

import '../../../controllers/support/email_support_controller.dart';
import '../../../controllers/support/faq_categories_controller.dart';
import '../../../utils/constants.dart';

class EmailSentErrorScreen extends StatelessWidget {
  final controller = Get.put(EmailSupportController());
  late FAQCategoriesController fAQCategoriesController;

  EmailSentErrorScreen({Key? key}) : super(key: key) {
    fAQCategoriesController = Get.find<FAQCategoriesController>();
  }

  @override
  Widget build(BuildContext context) {
    var params = fAQCategoriesController.isBottomSheet
        ? fAQCategoriesController.emailSupportRequestParams
        : Get.arguments;
    return AdaptiveScaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: GlorifiColors.lightWhite,
      body: AdaptiveBuilder(
        builder: (context, sizingInfo) {
          print('isDesktop: ${sizingInfo.isDesktop}');
          return Column(
            mainAxisAlignment: sizingInfo.isDesktop
                ? MainAxisAlignment.center
                : MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: sizingInfo.isDesktop
                      ? 400.w
                      : sizingInfo.isTablet
                          ? 34.5.w
                          : 24.w,
                ),
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: 1024),
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
                                alignment: Alignment.center,
                                child: SvgPicture.asset(
                                  GlorifiAssets.circleX,
                                  height:
                                      sizingInfo.isDesktop ? 160.h : 70.h,
                                  color: GlorifiColors.midnightBlue,
                                ),
                              ).paddingOnly(
                                top: 160.h,
                                bottom: 50.h,
                              ),
                              Container(
                                alignment: sizingInfo.isDesktop
                                    ? Alignment.center
                                    : Alignment.centerLeft,
                                child: Text(
                                  'An unexpected error has occurred.',
                                  textAlign: TextAlign.start,
                                  style: headlineSemiBold31Primary(
                                    color: GlorifiColors.darkBlue,
                                  ),
                                ),
                              ).paddingOnly(
                                bottom: sizingInfo.isDesktop ? 10.h : 40.h,
                              ),
                              Container(
                                alignment: sizingInfo.isDesktop
                                    ? Alignment.center
                                    : Alignment.centerLeft,
                                child: Text(
                                  'We are sorry something went wrong on our end. Please try again.',
                                  textAlign: TextAlign.start,
                                  style: smallRegular16Primary(
                                    color: GlorifiColors.darkBlue,
                                  ),
                                ),
                              ).paddingOnly(
                                bottom: sizingInfo.isDesktop ? 70.h : 40.h,
                              ),
                            ],
                          )),
                    ],
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  AppButton(
                    onTap: () async {
                      var response = await DataHelperImpl.instance.apiHelper
                          .sendEmailToGenesys(params);

                      response.fold((l) => debugPrint('EXCEPTION: $l'), (r) {
                        if (r['success']) {
                          if (fAQCategoriesController.isBottomSheet) {
                            fAQCategoriesController.navigationStack.removeAt(0);
                            fAQCategoriesController.navigationStack
                                .insert(0, EmailSentSuccessScreen);
                            fAQCategoriesController.update();
                          } else {
                            Get.offAndToNamed(Routes.emailSentSuccessScreen);
                          }
                        } else {
                          return;
                        }
                      });
                    },
                    textStyle: bodyBold18Primary(
                      color: GlorifiColors.superLightGrey,
                    ),
                    label: 'Try Again',
                    backgroundColor: GlorifiColors.primaryButtonProgressColor,
                    height: 64,
                  ).paddingOnly(
                    bottom: 24.h,
                    left: 16.w,
                    right: 16.w,
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  InkWell(
                    child: Center(
                      child: Text(
                        'Cancel',
                        style: bodyBold18Primary(
                          color: GlorifiColors.darkBlueColor,
                        ),
                      ),
                    ),
                    onTap: () =>
                        navigateToContactSupport(controller.getCatogery),
                  ),
                  SizedBox(
                    height: 70.h,
                  )
                ],
              ).paddingSymmetric(
                horizontal: sizingInfo.isDesktop
                    ? 400.w
                    : sizingInfo.isTablet
                        ? 34.5.w
                        : 24.w,
              ),
            ],
          );
        },
      ),
    );
  }

  navigateToContactSupport(category) {
    if (fAQCategoriesController.isBottomSheet) {
      print(fAQCategoriesController.navigationStack);
      for (int i = 0; i < fAQCategoriesController.navigationStack.length; i++) {
        if (fAQCategoriesController.navigationStack[0] !=
            ContactSupportScreen) {
          fAQCategoriesController.navigationStack.removeAt(0);
          print(fAQCategoriesController.navigationStack);
        }
        if (fAQCategoriesController.navigationStack[0] ==
            ContactSupportScreen) {
          break;
        }
        print(fAQCategoriesController.navigationStack);
      }
      fAQCategoriesController.update();
    } else {
      Get.until((route) {
          var currentRoute = route.settings.name;
          debugPrint("Get.currentRoute --- $currentRoute");
          if(Get.currentRoute.contains('support_faqContactSupportScreen')) {
          return true;
          } else {
          return false;
          }
          });
    }
  }
}
