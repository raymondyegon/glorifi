import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/controllers/account_flags_controller.dart';
import 'package:glorifi/src/controllers/plaid_controller.dart';
import 'package:glorifi/src/feature/cockpit/feed2.0/snapshot/sections/snapshot_widget/snapshot_widget.dart';
import 'package:glorifi/src/feature/cockpit/feed_sections/personal_snapshot/link_data_flow/link_data_flow_controller.dart';
import 'package:glorifi/src/feature/feature_flag/feature_flag_manager.dart';
import 'package:glorifi/src/feature/personal_snapshot/home_value/success_address_screen.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/routes/app_pages.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_base_widget.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_sizing.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_widgets/adaptive_scaffold.dart';
import 'package:glorifi/src/utils/glorifi_assets.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive.dart';
import 'package:glorifi/src/utils/text_constants.dart';
import 'package:glorifi/src/widgets/appbars/glorifi_appbar.dart';
import 'package:glorifi/src/widgets/loading/glorifi_spinner.dart';

class FinancialDataScreen extends StatelessWidget {
  const FinancialDataScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AdaptiveBuilder(builder: (context, sizingInfo) {
      return AdaptiveScaffold(
        backgroundColor: GlorifiColors.productsBgWhite,
        appBar: GlorifiAppBar(
          title: 'Add My Financial Data',
          textStyle: bodySemiBold18Primary(
            color: GlorifiColors.textColor,
          ),
          //elevation: 2,
        ),
        body: FinancialData(sizingInfo: sizingInfo),
      );
    });
  }
}

class FinancialData extends StatelessWidget {
  const FinancialData({Key? key, required this.sizingInfo}) : super(key: key);

  final AdaptiveSizingInfo sizingInfo;

  Widget _loading() {
    return Center(
      child: GlorifiSpinner(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final _linkDataFlowController = Get.put(LinkDataFlowController());
    PlaidController plaidController = Get.put(PlaidController());

    return StatefulWrapper(
      onInit: () {
        WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
          Get.put(AccountFlagsController()).loadData();
        });
      },
      child: Obx(
        () => _linkDataFlowController.accountFlagsController.isLoading.value ||
                _linkDataFlowController.homeValueController.loading.value
            ? _loading()
            : SingleChildScrollView(
                padding: EdgeInsets.only(bottom: 32.h),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal:
                              sizingInfo.isDesktop || sizingInfo.isTablet
                                  ? 10.w
                                  : 0.w),
                      child: ConstrainedBox(
                        constraints: BoxConstraints(maxWidth: 1024),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical:
                                  sizingInfo.isNativeMobile ? 24.h : 40.h),
                          child: Container(
                            width: double.infinity,
                            child: Text(
                              TextConstants.manage_snapshot_heading,
                              style: leadRegular24Secondary(
                                color: GlorifiColors.cornflowerBlue,
                              ).copyWith(
                                height: 32 / 24,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          bottom: sizingInfo.isNativeMobile ? 16.h : 32.h),
                      child: _FinancialDataOptionCard(
                        success: _linkDataFlowController.accountFlagsController
                            .flags.value.hasPlaidLinkedAcct,
                        iconPath: GlorifiAssets.link,
                        title: _linkDataFlowController.accountFlagsController
                                .flags.value.hasPlaidLinkedAcct
                            ? 'Link Another Bank Account'
                            : "Link External Bank Account",
                        description:
                            "Add checking and savings balances and retirement accounts.",
                        caption: "You can link and unlink anytime.",
                        isLoading: plaidController.isLoading.value,
                        onPressed: () async {
                          await plaidController.openPlaid();
                        },
                      ),
                    ),
                    if (FeatureFlagManager.snapshotCreditScoreEnabled)
                      Padding(
                        padding: EdgeInsets.only(
                            bottom: sizingInfo.isNativeMobile ? 16.h : 32.h),
                        child: _FinancialDataOptionCard(
                          success: _linkDataFlowController
                              .accountFlagsController
                              .flags
                              .value
                              .hasCreditPermission,
                          iconPath: GlorifiAssets.medal,
                          title: _linkDataFlowController.accountFlagsController
                                  .flags.value.hasCreditPermission
                              ? 'My Credit Score'
                              : "Get Your Free Credit Score",
                          // caption : "We’ve partnered with Equifax to retrieve your Soft Credit Report. It will not affect your credit score.",
                          description: _linkDataFlowController
                                  .accountFlagsController
                                  .flags
                                  .value
                                  .hasCreditPermission
                              ? "You can view your credit score, open and closed accounts, loans and debt."
                              : "We are retrieving your VantageScore from Equifax. It will not impact your credit score.",
                          onPressed: () {
                            _linkDataFlowController.accountFlagsController.flags
                                    .value.hasCreditPermission
                                ? Get.toNamed(
                                    Routes.creditScoreDetailScreen,
                                  )
                                : _linkDataFlowController.creditScore();
                          },
                        ),
                      ),
                    if (FeatureFlagManager.snapshotHomeValueEnabled)
                      Padding(
                        padding: EdgeInsets.only(
                            bottom: sizingInfo.isNativeMobile ? 16.h : 32.h),
                        child: _FinancialDataOptionCard(
                          success: _linkDataFlowController
                              .accountFlagsController.flags.value.hasAddr,
                          iconPath: GlorifiAssets.home2,
                          title: _linkDataFlowController
                                  .accountFlagsController.flags.value.hasAddr
                              ? "My Home Address"
                              : "Add My Home Address",
                          description: _linkDataFlowController
                                  .accountFlagsController.flags.value.hasAddr
                              ? _linkDataFlowController.address()
                              : 'See your home property value over time.',
                          onPressed: () {
                            _linkDataFlowController
                                    .accountFlagsController.flags.value.hasAddr
                                ? _linkDataFlowController
                                    .goToHomeDetailsScreen()
                                : _linkDataFlowController.goToHomeAddress(
                                    AddressFlowType.addFromFinancialData);
                          },
                        ),
                      ),
                  ],
                ),
              ),
      ),
    );
  }
}

class _FinancialDataOptionCard extends StatelessWidget {
  const _FinancialDataOptionCard({
    Key? key,
    required this.iconPath,
    required this.title,
    required this.description,
    required this.onPressed,
    this.caption,
    this.success = false,
    this.isLoading = false,
  }) : super(key: key);

  final String iconPath;
  final String title;
  final String description;
  final String? caption;
  final VoidCallback onPressed;
  final bool success;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isLoading ? null : onPressed,
      child: Container(
        padding: EdgeInsets.all(25.sp),
        decoration: BoxDecoration(
          color: GlorifiColors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            isLoading
                ? GlorifiSpinner(size: 24)
                : SvgPicture.asset(
                    iconPath,
                    height: 24,
                    width: 24,
                    color: success
                        ? GlorifiColors.denimGreen
                        : GlorifiColors.biscayBlue,
                  ),
            SizedBox(width: 16.w),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: smallBold16Secondary(
                      color: success
                          ? GlorifiColors.denimGreen
                          : GlorifiColors.biscayBlue,
                    ).copyWith(
                      fontSize: 18.0.sp,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Text(
                    description,
                    style: bodyRegular18Primary(
                      color: GlorifiColors.ebonyBlue,
                    ),
                  ),
                  if (caption != null) ...[
                    SizedBox(height: 8.h),
                    Text(
                      "$caption",
                      style: smallRegular16Primary(
                        color: GlorifiColors.ebonyBlue,
                      ),
                    ),
                  ],
                  SizedBox(height: 16.h),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
