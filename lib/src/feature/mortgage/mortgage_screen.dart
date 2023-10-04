import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/feature/mortgage/controllers/mortgage_controller.dart';
import 'package:glorifi/src/feature/mortgage/widgets/mortgage_account_card.dart';
import 'package:glorifi/src/feature/mortgage/widgets/mortgage_application_tile.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_widgets/adaptive_scaffold.dart';
import 'package:glorifi/src/utils/glorifi_assets.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive_extensions.dart';
import 'package:glorifi/src/utils/text_constants.dart';
import 'package:glorifi/src/widgets/appbars/glorifi_appbar.dart';
import 'package:glorifi/src/widgets/web/page_header.dart';

import '../../utils/adaptive/adaptive_base_widget.dart';
import '../../utils/adaptive/adaptive_sizing.dart';
import '../../utils/adaptive/adaptive_widgets/adaptive_grid.dart';
import '../../widgets/appbars/glorifi_appbar.dart';
import '../support/support_widgets/faq_loading_shimmer.dart';

class MortgageScreen extends StatelessWidget {
  MortgageScreen({Key? key}) : super(key: key) {
    Get.delete<MortgageController>();
    controller = Get.put(MortgageController());
  }

  late final MortgageController controller;

  @override
  Widget build(BuildContext context) {
    return AdaptiveBuilder(builder: (context, sizingInfo) {
      return AdaptiveScaffold(
        backgroundColor: GlorifiColors.productsBgWhite,
        appBar: GlorifiAppBar(
          title: 'Mortgage',
          trailing: Trailing(
            text: 'Support',
            rightMargin: 2.w,
            onTap: controller.navigateToFAQ,
          ),
        ),
        body: _getPageBody(sizingInfo),
      );
    });
  }

  Widget _getPageBody(AdaptiveSizingInfo sizingInfo) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(
        horizontal: sizingInfo.isDesktop
            ? 200.w
            : sizingInfo.isTablet
                ? 0
                : 24.w,
      ).copyWith(
        top: (sizingInfo.isDesktop)
            ? (controller.activeMortgageData.isNotEmpty ? 50.h : 40.h)
            : 16.h,
        bottom: (!sizingInfo.isDesktop) ? 16.h : 0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (!sizingInfo.isNativeMobile)
            PageHeader(
              headerTitle: "Mortgage",
              headerButtonTitle: "Support",
              headerButtonOnTap: controller.navigateToFAQ,
            ),
          Obx(() => ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 800),
              child: AdaptiveGrid(
                gridSpacing: (sizingInfo.isDesktop)
                    ? 32.w
                    : (sizingInfo.isNativeMobile || sizingInfo.isWebMobile)
                        ? 16.h
                        : 0,
                children: [
                  AdaptiveGridItem(
                    webMobile: 100,
                    nativeMobile: 100,
                    desktop: 100,
                    tablet: 100,
                    child: mortgageData(sizingInfo),
                  ),
                  AdaptiveGridItem(
                    nativeMobile: 100,
                    webMobile: 100,
                    desktop: 33.33,
                    child: MortgageAccountCard(
                      title: TextConstants.pre_approval,
                      onTap: controller.navigateMortgagePreApply,
                      image: GlorifiAssets.mortgageLoanBg,
                      showCompanyLLC: !sizingInfo.isDesktop,
                      cardVisibility: controller.activeMortgageData.length >= 10 ? false : true,
                    ),
                  ),
                  AdaptiveGridItem(
                    nativeMobile: 100,
                    webMobile: 100,
                    desktop: 33.33,
                    child: MortgageAccountCard(
                      title: TextConstants.dream_home,
                      onTap: controller.navigateMortgagePreApply,
                      image: GlorifiAssets.homeLoanBg,
                      showCompanyLLC: !sizingInfo.isDesktop,
                      cardVisibility: controller.activeMortgageData.length >= 10 ? false : true,
                    ),
                  ),
                  AdaptiveGridItem(
                    nativeMobile: 100,
                    webMobile: 100,
                    desktop: 33.33,
                    child: MortgageAccountCard(
                      title: TextConstants.refinance,
                      onTap: controller.navigateMortgagePreApply,
                      image: GlorifiAssets.houseRefinanceBg,
                      showCompanyLLC: !sizingInfo.isDesktop,
                      cardVisibility: controller.activeMortgageData.length >= 10 ? false : true,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget mortgageData(AdaptiveSizingInfo sizingInfo) {
    return Obx(
      () => controller.isLoading.value
          ? Column(
              children: [
                ...List.generate(
                  3,
                  (index) => FaqListLoadingShimmer(
                    height: 64.h,
                    baseColor: Colors.white60,
                    highlightColor: GlorifiColors.greyBgColor.withOpacity(
                      0.3,
                    ),
                    rounded: true,
                  ).paddingSymmetric(
                    vertical: 10.h,
                  ),
                )
              ],
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (controller.activeMortgageData.isNotEmpty)
                  Padding(
                    padding: EdgeInsets.only(
                      // top: 37.h,
                      left: (sizingInfo.isDesktop) ? 8.w : 16.w,
                      bottom: (sizingInfo.isDesktop) ? 32.h : 17.h,
                    ),
                    child: Text(
                      'Applications',
                      style: (sizingInfo.isDesktop)
                          ? headlineRegular31Secondary(
                              color: GlorifiColors.cornflowerBlue)
                          : bodyRegular18Secondary(
                              color: GlorifiColors.cornflowerBlue),
                    ),
                  ),
                ...List.generate(
                  controller.activeMortgageData.length,
                  (index) {
                    final element = controller.activeMortgageData[index];
                    return MortgageApplicationTile(
                      element: element,
                    );
                  },
                ),
                SizedBox(
                  height: (controller.activeMortgageData.isNotEmpty &&
                          !sizingInfo.isDesktop)
                      ? 16.h
                      : 0,
                ),
                Visibility(
                  visible:
                      controller.activeMortgageData.length >= 10 ? true : false,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(8.r),
                      ),
                      color: GlorifiColors.altoGrey,
                    ),
                    child: Text(
                      TextConstants.mortgage_maximum,
                      style: smallSemiBold16Primary(
                        color: GlorifiColors.greyProfile,
                      ),
                    ).paddingSymmetric(
                      horizontal: 24.w,
                      vertical: 33.h,
                    ),
                  ),
                ),
                SizedBox(
                  height: (controller.activeMortgageData.isNotEmpty &&
                          !sizingInfo.isDesktop)
                      ? 55.h
                      : 0,
                ),
              ],
            ),
    );
  }
}
