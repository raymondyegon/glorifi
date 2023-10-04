import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/controllers/support/faq_categories_controller.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_base_widget.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_widgets/adaptive_grid.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_widgets/adaptive_scaffold.dart';
import 'package:glorifi/src/utils/glorifi_assets.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive_extensions.dart';
import 'package:glorifi/src/utils/text_constants.dart';
import 'package:glorifi/src/widgets/buttons/app_button.dart';

import '../../../utils/constants.dart';

class EmailSuccessScreen extends StatelessWidget {
  late FAQCategoriesController fAQCategoriesController;

  EmailSuccessScreen({Key? key}) : super(key: key) {
    fAQCategoriesController = Get.find<FAQCategoriesController>();
  }

  @override
  Widget build(BuildContext context) {
    return AdaptiveScaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: GlorifiColors.midnightBlue,
      body: AdaptiveBuilder(
        builder: (context, sizingInfo) {
          return WillPopScope(
            onWillPop: () {
              Get.until((route) => !Get.currentRoute.contains('support_'));
              return Future.value(false);
            },
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: sizingInfo.isDesktop
                          ? 380.w
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
                            child: Container(
                              height: MediaQuery.of(context).size.height,
                              child: Column(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          alignment: Alignment.center,
                                          child: SvgPicture.asset(
                                            GlorifiAssets.send,
                                            height: sizingInfo.isDesktop
                                                ? 130.h
                                                : 70.h,
                                            color: GlorifiColors.white,
                                          ).paddingOnly(
                                            top: 160.h,
                                            bottom: 50.h,
                                          ),
                                        ),
                                        Container(
                                          alignment: sizingInfo.isDesktop
                                              ? Alignment.center
                                              : Alignment.centerLeft,
                                          child: Text(
                                            TextConstants
                                                .yourMessageHasBeenSent,
                                            textAlign: TextAlign.start,
                                            style: sizingInfo.isDesktop
                                                ? headlineSemiBold37Primary(
                                                    color: GlorifiColors.white)
                                                : headlineSemiBold31Primary(
                                                    color: GlorifiColors.white),
                                          ),
                                        ).paddingOnly(
                                          bottom: 8.h,
                                        ),
                                        Container(
                                          alignment: sizingInfo.isDesktop
                                              ? Alignment.center
                                              : Alignment.centerLeft,
                                          child: Text(
                                            TextConstants
                                                .willRespondToYourEmail,
                                            textAlign: TextAlign.start,
                                            style: sizingInfo.isDesktop
                                                ? leadRegular24Primary(
                                                    color: GlorifiColors.white,
                                                  )
                                                : smallRegular16Primary(
                                                    color: GlorifiColors.white,
                                                  ),
                                          ),
                                        ).paddingOnly(
                                          bottom: sizingInfo.isDesktop
                                              ? 36.h
                                              : 84.h,
                                        ),
                                      ],
                                    ),
                                  ),
                                  AppButton(
                                    onTap: () {
                                      if (fAQCategoriesController
                                          .isBottomSheet) {
                                        fAQCategoriesController.navigationStack
                                            .removeWhere((index) {
                                          return index >
                                              ContactSupportCategoryScreen;
                                        });
                                        fAQCategoriesController.update();
                                      } else {
                                        Get.until((route) => !Get.currentRoute
                                            .contains('support_'));
                                      }
                                    },
                                    textColor: GlorifiColors.white,
                                    textStyle: bodyBold18Primary(
                                      color: GlorifiColors.midnightBlue,
                                    ),
                                    label: TextConstants.backToSupport,
                                    backgroundColor: GlorifiColors.white,
                                    height: 64,
                                  ).paddingOnly(
                                    left: 0.h,
                                    top: 0.h,
                                    right: 0.h,
                                    bottom:
                                        sizingInfo.isDesktop ? 251.h : 148.h,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
