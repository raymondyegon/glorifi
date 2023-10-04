import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/feature/insurance/widgets/insurance_appbar.dart';
import 'package:glorifi/src/feature/policy_detail/controller/policy_detail_controller.dart';
import 'package:glorifi/src/feature/policy_detail/widget/address_tile.dart';
import 'package:glorifi/src/feature/policy_detail/widget/policy_detail_tile.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_base_widget.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_widgets/adaptive_grid.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_widgets/adaptive_scaffold.dart';
import 'package:glorifi/src/utils/responsive/responsive.dart';
import 'package:glorifi/src/widgets/loading/glorifi_spinner.dart';

import '../../utils/glorifi_colors.dart';

class PolicyDetailScreen extends GetView<PolicyDetailController> {
  const PolicyDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AdaptiveBuilder(builder: (context, sizingInfo) {
      return AdaptiveScaffold(
        backgroundColor: GlorifiColors.bgColor,
        appBar: InsuranceAppBar(
          title: "Policy Information",
          iconVisibility: false,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: sizingInfo.isDesktop
                      ? 200.w
                      : sizingInfo.isTablet
                          ? 34.5.w
                          : 24.5.w,
                  vertical: sizingInfo.isNativeMobile ? 24.h : 50.h),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: 1024,
                ),
                child: controller.obx(
                    (_) => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              controller.name,
                              style: TextStyle(
                                  fontSize: 31.sp,
                                  height: 1.4,
                                  fontFamily: 'univers',
                                  fontWeight: FontWeight.normal,
                                  color: GlorifiColors.biscayBlue),
                            ),
                            SizedBox(
                              height: 16.h,
                            ),
                            AdaptiveGrid(
                              children: [
                                AdaptiveGridItem(
                                  nativeMobile: 100,
                                  tablet: 100,
                                  webMobile: 100,
                                  desktop: 50,
                                  child: Column(
                                    children: [
                                      AddressTile(
                                        firstHeading: "Property Address",
                                        secondHeading: "Status",
                                        firstData: controller.policyDetailData
                                                .value?.displayIdentifier
                                                .getPolicyDetails() ??
                                            "",
                                        secondData: controller.policyDetailData
                                                .value?.status ??
                                            "",
                                      ),
                                      SizedBox(
                                        height: 8.h,
                                      ),
                                      AddressTile(
                                        firstHeading: "Effective Date",
                                        secondHeading: "Exp Date",
                                        firstData: controller
                                                .policyDetailData.value
                                                ?.getEffectiveDate() ??
                                            "",
                                        secondData: controller
                                                .policyDetailData.value
                                                ?.getExpiryDate() ??
                                            "",
                                      ),
                                    ],
                                  ),
                                ),
                                AdaptiveGridItem(
                                  nativeMobile: 100,
                                  tablet: 100,
                                  webMobile: 100,
                                  desktop: 50,
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        left:
                                            sizingInfo.isDesktop ? 32.w : 0.0),
                                    child: Column(
                                      children: [
                                        !sizingInfo.isDesktop
                                            ? SizedBox(
                                                height: 16.h,
                                              )
                                            : Offstage(),
                                        PolicyDetailTile(
                                          data: controller.policyDetailData
                                                  .value?.policynumber
                                                  .toString() ??
                                              "",
                                          underWriter: controller
                                                  .policyDetailData
                                                  .value
                                                  ?.underwriter
                                                  .toString() ??
                                              "",
                                          isPolicy: true,
                                          title: "Policy",
                                          buttonLabel: "Policy Documents",
                                          buttonColor:
                                              GlorifiColors.cornflowerBlue,
                                          buttonStrokeColor:
                                              GlorifiColors.cornflowerBlue,
                                          onTap: controller
                                              .navigateToPolicyDetails,
                                        ),
                                        SizedBox(
                                          height: 16.h,
                                        ),
                                        if (controller.policyDetailData.value
                                                ?.showSubmitClaim() ??
                                            false)
                                          Column(
                                            children: [
                                              PolicyDetailTile(
                                                isPolicy: false,
                                                showContent: false,
                                                title: "Claims",
                                                buttonLabel: "Submit A Claim",
                                                buttonTextColor:
                                                    GlorifiColors.darkBlue,
                                                buttonColor:
                                                    GlorifiColors.white,
                                                buttonStrokeColor:
                                                    GlorifiColors.lightBlue,
                                                onTap: controller.submitClaim,
                                              ),
                                              SizedBox(
                                                height: 16.h,
                                              ),
                                            ],
                                          ),
                                        PolicyDetailTile(
                                          data: "555 555-5555",
                                          isPolicy: false,
                                          title: "Support",
                                          buttonLabel: "Insurance FAQs",
                                          buttonTextColor:
                                              GlorifiColors.darkBlue,
                                          buttonColor: GlorifiColors.white,
                                          buttonStrokeColor:
                                              GlorifiColors.lightBlue,
                                          onTap: controller.navigateToFAQ,
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                    onLoading: Center(
                        child: GlorifiSpinner(
                      size: 50,
                    ))),
              ),
            ),
          ),
        ),
      );
    });
  }
}
