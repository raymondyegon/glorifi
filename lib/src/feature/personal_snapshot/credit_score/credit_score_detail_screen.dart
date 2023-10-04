import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/controllers/credit_score_detail_screen_controller.dart';
import 'package:glorifi/src/feature/cockpit/feed2.0/snapshot/sections/snapshot_widget/snapshot_widget.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_widgets/adaptive_scaffold.dart';
import 'package:glorifi/src/utils/date_util.dart';
import 'package:glorifi/src/utils/responsive/responsive_extensions.dart';
import 'package:glorifi/src/widgets/tiles/account_tile.dart';
import '../../../font_style_global.dart';
import '../../../utils/glorifi_colors.dart';
import '../../../widgets/appbars/glorifi_appbar.dart';
import '../../../widgets/charts/credit_score_chart.dart';
import '../../../widgets/loading/glorifi_spinner.dart';
import '../../../widgets/tiles/expandable_two_line_tile/expandable_two_line_list_tile.dart';
import '../personal_snapshot_constants.dart';
import '../widgets/detail_screen_layout_widget.dart';
import 'package:glorifi/src/utils/number_format_util.dart';

class CreditScoreDetailScreen extends GetView<CreditScoreDetailScreenController> {
  CreditScoreDetailScreen({Key? key}) : super(key: key);

  final Widget loader = Center(
    child: Padding(
      padding: EdgeInsets.only(top: 20.h),
      child: GlorifiSpinner(),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return AdaptiveScaffold(
      backgroundColor: GlorifiColors.bgBoxColor,
      appBar: GlorifiAppBar(
        title: "Credit Score",
        textStyle: bodySemiBold18Primary(
          color: GlorifiColors.ebonyBlue,
        ),
      ),
      body: StatefulWrapper(
        onInit: controller.getCreditScore,
        child: controller.obx(
            (state) => DetailScreenLayoutWidget(
                  headerText:
                      'The VantageScore credit score is a number between 300–850 that depicts your creditworthiness. Lender credit scores may differ.',
                  mainValueDescription: 'Across All Linked Accounts',
                  title: "Credit Score",
                  chart: Padding(
                    padding: EdgeInsets.only(
                      top: 54.h,
                      bottom: 96.h,
                    ),
                    child: CreditScoreChart(
                      creditScore: controller.creditScoreModel.value.data?.creditScore ?? 0,
                      label: controller.creditScoreModel.value.data?.creditBucket ?? "",
                      recentlyAddedPoints: controller.creditScoreModel.value.data?.creditDelta != null
                          ? int.parse(controller.creditScoreModel.value.data!.creditDelta!)
                          : null,
                    ),
                  ),
                  lastPullInfo:
                      'As of ${controller.creditScoreModel.value.data?.asOfDate.todMMM()} (pull $kCashOnHandPullRate)',
                  dataSourceLabel: kCreditScoreDataSourceText,
                  bottomContent: [
                    // TileButtonWidget(
                    //   title: "Compare Credit Score",
                    //   callback: () {
                    //     controller.openComparison();
                    //   },
                    //   icon: "assets/icons/medal.svg",
                    // ),
                    // SizedBox(
                    //   height: 32.h,
                    // ),
                    controller.obx((state) => getInsights(), onLoading: loader)
                  ],
                ),
            onLoading: loader),
      ),
    );
  }

  getInsights() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "What Affects Your Credit?",
          style: smallBold16Primary(color: GlorifiColors.black),
        ),
        SizedBox(
          height: 16.h,
        ),
        getInfoBox(
            title: "Credit Payment History",
            percentage: controller.creditScoreModel.value.data?.creditHistory?.value != null
                ? controller.creditScoreModel.value.data!.creditHistory!.value!
                : "0%",
            status: controller.creditScoreModel.value.data?.creditHistory?.bucket ?? ""),
        SizedBox(
          height: 16.h,
        ),
        getInfoBox(
            title: "Revolving Utilization",
            percentage: controller.creditScoreModel.value.data?.creditUtilization?.value != null
                ? "${controller.creditScoreModel.value.data?.creditUtilization?.value}%"
                : "0%",
            status: controller.creditScoreModel.value.data?.creditUtilization?.bucket ?? ""),
        SizedBox(
          height: 16.h,
        ),
        getInfoBox(
            title: "Total Credit",
            percentage: controller.creditScoreModel.value.data?.creditTotal?.value != null
                ? controller.creditScoreModel.value.data!.creditTotal!.value!
                : r'\$0',
            status: controller.creditScoreModel.value.data?.creditTotal?.bucket ?? ""),
        SizedBox(
          height: 16.h,
        ),
        ExpandableTwoLineListTile(
          title: 'Total Accounts',
          subtitle:
              "${controller.creditScoreModel.value.data!.creditAccounts!.openAccounts.length + controller.creditScoreModel.value.data!.creditAccounts!.closedAccounts.length} | ${controller.creditScoreModel.value.data?.creditTotal?.bucket}",
          leftPadding: 16,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Divider(height: 1, color: GlorifiColors.bgBoxColor),
              ListView.builder(
                  itemCount: 1,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) => Column(
                        children: [getOpened(), getClosed()],
                      )),
            ],
          ),
        )
      ],
    );
  }

  getOpened() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          alignment: Alignment.centerLeft,
          height: 50.h,
          padding: EdgeInsets.only(left: 16.w, right: 16.w),
          child: Text(
            "Opened",
            style: xSmallBold12Primary(),
          ),
        ),
        ListView.builder(
            itemBuilder: (context, index) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 16.w, right: 16.w),
                      child: AccountTile(
                        title: controller.creditScoreModel.value.data!.creditAccounts!
                            .openAccounts[index].institution,
                        desc: controller
                            .creditScoreModel.value.data!.creditAccounts!.openAccounts[index].name,
                        amount: controller.creditScoreModel.value.data!.creditAccounts!
                            .openAccounts[index].balance,
                        allowPadding: false,
                      ),
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    getTitleValue(
                      title: "Total Credit",
                      value: controller.creditScoreModel.value.data!.creditAccounts!
                          .openAccounts[index].totalCredit
                          .toInt()
                          .formatSimpleCurrencyZeroInt(),
                    ),
                    SizedBox(
                      height: 4.h,
                    ),
                    getTitleValue(
                      title: "Credit Payment History",
                      value: controller.creditScoreModel.value.data!.creditAccounts!
                          .openAccounts[index].creditHistory,
                    ),
                    SizedBox(
                      height: 4.h,
                    ),
                    getTitleValue(
                      title: "Revolving Utilization",
                      value: controller.creditScoreModel.value.data!.creditAccounts!
                          .openAccounts[index].creditUtilization,
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    Divider(
                      color: GlorifiColors.bgBoxColor,
                      height: 1,
                    ),
                    if (index !=
                        controller
                                .creditScoreModel.value.data!.creditAccounts!.openAccounts.length -
                            1)
                      SizedBox(
                        height: 16.h,
                      ),
                  ],
                ),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: controller.creditScoreModel.value.data!.creditAccounts!.openAccounts.length),
      ],
    );
  }

  getClosed() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          alignment: Alignment.centerLeft,
          height: 50.h,
          padding: EdgeInsets.only(left: 16.w, right: 16.w),
          child: Text(
            "Closed",
            style: xSmallBold12Primary(),
          ),
        ),
        ListView.builder(
            itemBuilder: (context, index) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 16.w, right: 16.w),
                      child: AccountTile(
                        title: controller.creditScoreModel.value.data!.creditAccounts!
                            .closedAccounts[index].institution,
                        desc: controller.creditScoreModel.value.data!.creditAccounts!
                            .closedAccounts[index].name,
                        amount: 0,
                        allowPadding: false,
                        showAmount: false,
                      ),
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    if (index !=
                        controller.creditScoreModel.value.data!.creditAccounts!.closedAccounts
                                .length -
                            1)
                      Divider(
                        height: 1,
                        color: GlorifiColors.bgBoxColor,
                      ),
                    if (index !=
                        controller.creditScoreModel.value.data!.creditAccounts!.closedAccounts
                                .length -
                            1)
                      SizedBox(
                        height: 16.h,
                      ),
                  ],
                ),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount:
                controller.creditScoreModel.value.data!.creditAccounts!.closedAccounts.length),
      ],
    );
  }

  Widget getInfoBox({required String title, required String percentage, required String status}) {
    return Container(
      width: double.maxFinite,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
      ),
      padding: EdgeInsets.only(
        top: 24.h,
        bottom: 24.h,
        left: 16.w,
        right: 24.w,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: captionBold14Primary(color: GlorifiColors.midnightBlueColor),
          ),
          SizedBox(
            height: 4.h,
          ),
          Text(
            "$percentage | $status",
            style: smallRegular16Primary(color: GlorifiColors.midnightBlueColor),
          )
        ],
      ),
    );
  }

  getTitleValue({String title = "", String value = ""}) {
    return Padding(
      padding: EdgeInsets.only(left: 16.w, right: 16.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: captionRegular14Primary(),
          ),
          Text(
            value,
            style: captionRegular14Primary(),
          ),
        ],
      ),
    );
  }
}
