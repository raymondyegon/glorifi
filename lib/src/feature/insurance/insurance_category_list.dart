import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/feature/insurance/controller/insurance_category_controller.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_base_widget.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_widgets/adaptive_grid.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_widgets/adaptive_scaffold.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive_extensions.dart';
import 'package:glorifi/src/widgets/appbars/glorifi_appbar.dart';
import 'package:glorifi/src/widgets/web/page_header.dart';

import 'insurance_category_list_tile.dart';

class InsuranceCategoryList extends StatelessWidget {
  const InsuranceCategoryList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<InsuranceCategoryController>();
    return AdaptiveBuilder(builder: (context, sizingInfo) {
      return AdaptiveScaffold(
        backgroundColor: GlorifiColors.productsBgWhite,
        appBar: GlorifiAppBar(
          title: "Insurance",
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Obx(
              () => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (sizingInfo.isDesktop)
                    PageHeader(
                        headerTitle: "Explore",
                        showTrailingButton: false,
                        horizontalPadding: sizingInfo.isDesktop
                            ? 200.w
                            : sizingInfo.isTablet
                                ? 34.5.w
                                : 24.5.w),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: sizingInfo.isDesktop
                            ? 200.w
                            : sizingInfo.isTablet
                                ? 34.5.w
                                : 24.5.w,
                        vertical: !sizingInfo.isNativeMobile ? 50.h : 24.5.h),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        maxWidth: 1024,
                      ),
                      child: AdaptiveGrid(
                        children: [
                          AdaptiveGridItem(
                            desktop: 100,
                            webMobile: 100,
                            tablet: 100,
                            nativeMobile: 100,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "What kind of insurance are you interested in?",
                                  style: headlineRegular26Secondary(
                                    color: GlorifiColors.biscayBlue,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          ...List<AdaptiveGridItem>.generate(
                              controller.insuranceCategory.length, (index) {
                            return AdaptiveGridItem(
                              desktop: 33,
                              webMobile: 100,
                              tablet: 100,
                              nativeMobile: 100,
                              child: InsuranceCategoryListTile(
                                title: controller.insuranceCategory[index].name,
                                insuranceCategoryItems:
                                    controller.insuranceCategory[index].items,
                              ).paddingOnly(
                                  right: sizingInfo.isDesktop ? 35.w : 0),
                            );
                          })
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
