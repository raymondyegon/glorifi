import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/feature/support/support_widgets/faq_loading_shimmer.dart';
import 'package:glorifi/src/feature/support/support_widgets/support_content.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_base_widget.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_widgets/adaptive_grid.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_widgets/adaptive_scaffold.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive_extensions.dart';
import 'package:glorifi/src/widgets/appbars/glorifi_appbar.dart';
import 'package:glorifi/src/widgets/web/page_header.dart';
import 'package:intl/intl.dart';

import '../../../controllers/support/faq_categories_controller.dart';
import '../../../utils/login_status/login_status.dart';
import '../support_widgets/support_search_box.dart';

class FAQCategoryListingScreen extends StatelessWidget {
  static const String route = '/faqCategories';
  final String? categoryID, categoryTitle;

  late FAQCategoriesController controller;

  FAQCategoryListingScreen({Key? key, this.categoryID, this.categoryTitle})
      : super(key: key) {
    controller = Get.put(FAQCategoriesController(isBottomSheet: false));
  }

  @override
  Widget build(BuildContext context) {
    return AdaptiveBuilder(
      builder: (context, sizingInfo) {
        return AdaptiveScaffold(
          showSimpleAppBar: !controller.isLoggedIn,
          appBar: GlorifiAppBar(
            title: 'Support',
            leading: Leading(
              onTap: () {
                if (controller.isBottomSheet) {
                  controller.navigationStack.removeAt(0);
                  controller.update();
                } else {
                  Get.back();
                }
              },
            ),
          ),
          backgroundColor: GlorifiColors.productsBgWhite,
          body: SingleChildScrollView(
            child: GetBuilder<FAQCategoriesController>(
              init: FAQCategoriesController(),
              builder: (_) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (!sizingInfo.isNativeMobile)
                    PageHeader(
                      headerTitle: "Support",
                      showWebPageFont: true,
                      showTrailingButton: false,
                      horizontalPadding: sizingInfo.isDesktop
                          ? 200.w
                          : sizingInfo.isTablet
                              ? 34.5.w
                              : 24.5.w,
                    ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: sizingInfo.isDesktop
                          ? 295.w
                          : sizingInfo.isTablet
                              ? 34.5.w
                              : 24.5.w,
                    ),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: 1024),
                      child: AdaptiveGrid(
                        children: [
                          AdaptiveGridItem(
                            desktop: 100,
                            tablet: 100,
                            nativeMobile: 100,
                            webMobile: 100,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: sizingInfo.isDesktop
                                      ? 64.h
                                      : sizingInfo.isTablet
                                          ? 64.h
                                          : sizingInfo.isWebMobile
                                              ? 24.h
                                              : 28.h,
                                  horizontal: 0.h),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'What can we help you with today?',
                                    textAlign: TextAlign.start,
                                    style: headlineRegular31Primary(
                                      color: GlorifiColors.midnightBlue,
                                    ),
                                  ),
                                  SizedBox(height: 32.h),
                                  SupportSearchBox(),
                                ],
                              ),
                            ),
                          ),
                          ...List<AdaptiveGridItem>.generate(
                            controller.loading.value
                                ? 8
                                : controller.list.length,
                            (index) => AdaptiveGridItem(
                              desktop: 100,
                              tablet: 100,
                              webMobile: 100,
                              nativeMobile: 100,
                              child: controller.loading.value
                                  ? FaqListLoadingShimmer(
                                      height: 64.h,
                                      baseColor: Colors.white60,
                                      highlightColor:
                                          GlorifiColors.greyBgColor.withOpacity(
                                        0.3,
                                      ),
                                      rounded: true,
                                    ).paddingSymmetric(
                                      vertical: 8.h,
                                    )
                                  : SupportContent(
                                      sizingInfo: sizingInfo,
                                      assetPath: controller.setAsset(controller
                                          .list[index]
                                          .toString()
                                          .toLowerCase()),
                                      label: toBeginningOfSentenceCase(
                                          controller.list[index])!,
                                      onTap: () {
                                        controller.navigateToListingPage(index);
                                      },
                                    ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
