// ignore_for_file: invalid_use_of_protected_member
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/feature/insurance/controller/insurance_controller.dart';
import 'package:glorifi/src/feature/insurance/widgets/add_policy_button.dart';
import 'package:glorifi/src/feature/insurance/widgets/banner_widget.dart';
import 'package:glorifi/src/feature/insurance/widgets/insurance_tile.dart';
import 'package:glorifi/src/feature/insurance/widgets/pending_data_widget.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_base_widget.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_widgets/adaptive_grid.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_widgets/adaptive_scaffold.dart';
import 'package:glorifi/src/utils/glorifi_assets.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive_extensions.dart';
import 'package:glorifi/src/widgets/appbars/glorifi_appbar.dart';
import 'package:glorifi/src/widgets/web/page_header.dart';

import '../../font_style_global.dart';

class InsuranceScreen extends StatelessWidget {
  const InsuranceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //todo why this , when the controller is already in the bindings
    final controller = Get.find<InsuranceController>();

    Widget contentWidget() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          /*Pending Quote Listing*/
          SizedBox(
            height: 12.h,
          ),
          controller.pendingInsuranceData.isEmpty
              ? Offstage()
              : PendingDataWidget (
                  count: controller.pendingInsuranceData.length,
                  widgetList: List.generate(
                      controller.pendingInsuranceData.length, (index) {
                    final element = controller.pendingInsuranceData[index];
                    return InsuranceTile(
                        onTap: () {},
                        isActive: false,
                        status: "Resume",
                        startDate: element.getParsedDate(),
                        accountDetail: element.displayIndentifier?.getDetails(),
                        loanType: element.quoteName);
                  }),
                  isExpanded: controller.isPendingExpanded.value,
                  onExpandClick: () {
                    controller.isPendingExpanded.value =
                        !controller.isPendingExpanded.value;
                  },
                  title: "Pending Quick Quote",
                  pendingCount:
                      "${controller.pendingInsuranceData.length} Pending Quotes",
                ),
          if (controller.pendingInsuranceData.isNotEmpty)
            SizedBox(
              height: 24.h,
            ),
          PendingDataWidget(
            count: controller.activeInsuranceData.length,
            widgetList:
                List.generate(controller.activeInsuranceData.length, (index) {
              final element = controller.activeInsuranceData[index];
              //we are passing each string values directly to the widget since
              // we use the same widget for pending quotes also .
              return InsuranceTile(
                      onTap: () {
                        controller.gotoPolicyDetails(
                            policyType: element.policyName,
                            id: element.policyId.toString(),
                            name: element.policyName);
                      },
                      isActive: true,
                      status: "Active",
                      accountDetail:
                          element.displayIdentifier.getPolicyDetails(),
                      loanType: element.policyName)
                  .paddingOnly(top: 10.h);
            }),
            isExpanded: controller.isActiveExpanded.value,
            onExpandClick: () {
              controller.isActiveExpanded.value =
                  !controller.isActiveExpanded.value;
            },
            title: "My Policy",
            button: AddPolicyButton(
              onTap: controller.addPolicy,
            ),
          ),
          SizedBox(
            height: 28.h,
          ),
          /*My Policy Listing*/
        ],
      );
    }

    return AdaptiveBuilder(builder: (context, sizingInfo) {
      return AdaptiveScaffold(
          backgroundColor: GlorifiColors.productsBgWhite,
          appBar: GlorifiAppBar(
            title: "Insurance",
            trailing: Trailing(
              onTap: () {
                controller.navigateToFAQ();
              },
              text: "Support",
              textStyle: captionBold14Primary(
                color: GlorifiColors.darkOrange,
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (!sizingInfo.isNativeMobile)
                  PageHeader(
                      headerTitle: "Insurance",
                      headerButtonOnTap: controller.addPolicy,
                      horizontalPadding: sizingInfo.isDesktop
                          ? 200.w
                          : sizingInfo.isTablet
                              ? 34.5.w
                              : 24.5.w),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: sizingInfo.isDesktop
                        ? 200.w
                        : sizingInfo.isNativeMobile
                            ? 0.w
                            : 32.w,
                  ),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: 1024,
                    ),
                    child: AdaptiveGrid(
                      children: [
                        AdaptiveGridItem(
                          desktop: 60,
                          tablet: 100,
                          webMobile: 100,
                          nativeMobile: 100,
                          child: BannerWidget(
                              image: GlorifiAssets.insuranceBackground,
                              padding: sizingInfo.isDesktop
                                  ? EdgeInsets.symmetric(vertical: 32.h)
                                  : null,
                              borderRadius:
                                  !sizingInfo.isNativeMobile ? 8.r : 0,
                              onTap: controller.addPolicy,
                              bannerMainText: "Explore our insurance products",
                              bannerSubText: "See All Insurance",
                              mainAxisAlignment: MainAxisAlignment.end,
                              height: sizingInfo.isDesktop
                                  ? 400
                                  : sizingInfo.isTablet
                                      ? 350
                                      : 310),
                        ),
                        AdaptiveGridItem(
                          desktop: 40,
                          tablet: 100,
                          webMobile: 100,
                          nativeMobile: 100,
                          child: Obx(
                            () => Padding(
                              padding: EdgeInsets.only(
                                  left: sizingInfo.isDesktop ? 32.w : 0,
                                  top: sizingInfo.isTablet ? 32.h : 0),
                              child: contentWidget(),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ));
    });
  }
}
