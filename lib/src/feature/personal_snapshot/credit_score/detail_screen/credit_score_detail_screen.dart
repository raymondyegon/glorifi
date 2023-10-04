import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/controllers/credit_score_detail_screen_controller.dart';
import 'package:glorifi/src/feature/personal_snapshot/credit_score/detail_screen/widgets/credit_activity_widget.dart';
import 'package:glorifi/src/feature/personal_snapshot/credit_score/detail_screen/widgets/credit_score_actions_carousel.dart';
import 'package:glorifi/src/feature/personal_snapshot/credit_score/detail_screen/widgets/credit_score_container.dart';
import 'package:glorifi/src/feature/personal_snapshot/credit_score/detail_screen/widgets/expandable_tile_v2.dart';
import 'package:glorifi/src/feature/personal_snapshot/credit_score/detail_screen/widgets/title_widget.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_widgets/adaptive_scaffold.dart';
import 'package:glorifi/src/utils/glorifi_assets.dart';
import 'package:glorifi/src/utils/number_format_util.dart';
import 'package:glorifi/src/utils/responsive/responsive_extensions.dart';
import 'package:glorifi/src/widgets/tiles/account_tile.dart';

import '../../../../font_style_global.dart';
import '../../../../utils/glorifi_colors.dart';
import '../../../../widgets/appbars/glorifi_appbar.dart';
import '../../../../widgets/loading/glorifi_spinner.dart';

class CreditScoreDetailScreen
    extends GetView<CreditScoreDetailScreenController> {
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
        bgColor: Color(0xFF141B3F),
        textStyle: TextStyle(
            color: Colors.white,
            fontFamily: 'Univers',
            fontWeight: FontWeight.w700),
        leadingIconDefaultColor: Colors.white,
      ),
      body: controller.obx(
        (state) => SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CreditScoreContainer(),
              SizedBox(height: 48.h),
              TitleWidget(title: 'Take Action'),
              CreditScoreActionsCarousel(),
              // SizedBox(height: 48.h),
              // TitleWidget(title: 'Your Credit Activity'),
              // CreditActivityWidget(),
              SizedBox(height: 48.h),
              TitleWidget(
                title: 'Key Factors',
                description: 'affecting your score',
              ),
              getInsights(),
              SizedBox(height: 48.h),
            ],
          ),
        ),
        onLoading: loader,
      ),
    );
  }

  getInsights() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          getInfoBox(
              title: "Credit Payment History",
              percentage: controller
                          .creditScoreModel.value.data?.creditHistory?.value !=
                      null
                  ? controller
                      .creditScoreModel.value.data!.creditHistory!.value!
                  : "0%",
              status: controller
                      .creditScoreModel.value.data?.creditHistory?.bucket ??
                  ""),
          getInfoBox(
              dotColor: GlorifiColors.blue6087,
              title: "Revolving Utilization",
              percentage: controller.creditScoreModel.value.data
                          ?.creditUtilization?.value !=
                      null
                  ? "${controller.creditScoreModel.value.data?.creditUtilization?.value}%"
                  : "0%",
              status: controller
                      .creditScoreModel.value.data?.creditUtilization?.bucket ??
                  ""),
          getInfoBox(
              dotColor: GlorifiColors.blue9AB3,
              title: "Total Credit",
              percentage: controller
                          .creditScoreModel.value.data?.creditTotal?.value !=
                      null
                  ? controller.creditScoreModel.value.data!.creditTotal!.value!
                  : r'\$0',
              status:
                  controller.creditScoreModel.value.data?.creditTotal?.bucket ??
                      ""),
          ExpandableTileV2(
            title: 'Total Accounts',
            description: (controller.creditScoreModel.value.data!
                        .creditAccounts!.openAccounts.length +
                    controller.creditScoreModel.value.data!.creditAccounts!
                        .closedAccounts.length)
                .toString(),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 20.w),
                  child: Divider(
                    height: 1,
                    color: GlorifiColors.lighterGrey,
                  ),
                ),
                ListView.builder(
                    itemCount: 1,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) => Column(
                          children: [getOpened(), getClosed()],
                        )),
              ],
            ),
          ),
        ],
      ),
    );
  }

  getOpened() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.only(
            left: 32.w,
            right: 16.w,
            top: 14.h,
            bottom: 12.h,
          ),
          child: Text(
            "Opened",
            style: bodyBold18Secondary(color: GlorifiColors.textDarkBlue),
          ),
        ),
        ListView.builder(
            itemBuilder: (context, index) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 32.w, right: 16.w),
                      child: AccountTile(
                        title: controller.creditScoreModel.value.data!
                            .creditAccounts!.openAccounts[index].name,
                        desc:
                            '${controller.creditScoreModel.value.data!.creditAccounts!.openAccounts[index].institution} ${controller.creditScoreModel.value.data!.creditAccounts!.openAccounts[index].mask}',
                        amount: controller.creditScoreModel.value.data!
                            .creditAccounts!.openAccounts[index].balance,
                        allowPadding: false,
                      ),
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    getTitleValue(
                      title: "Total Credit",
                      value: controller.creditScoreModel.value.data!
                          .creditAccounts!.openAccounts[index].totalCredit
                          .toInt()
                          .formatSimpleCurrencyZeroInt(),
                    ),
                    getTitleValue(
                      title: "Credit Payment History",
                      value: controller.creditScoreModel.value.data!
                          .creditAccounts!.openAccounts[index].creditHistory,
                    ),
                    getTitleValue(
                      title: "Revolving Utilization",
                      value: controller
                          .creditScoreModel
                          .value
                          .data!
                          .creditAccounts!
                          .openAccounts[index]
                          .creditUtilization,
                    ),
                    SizedBox(
                      height: 14.h,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 20.w),
                      child: Divider(
                        height: 1,
                        color: GlorifiColors.lighterGrey,
                      ),
                    ),
                    if (index !=
                        controller.creditScoreModel.value.data!.creditAccounts!
                                .openAccounts.length -
                            1)
                      SizedBox(
                        height: 16.h,
                      ),
                  ],
                ),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: controller.creditScoreModel.value.data!.creditAccounts!
                .openAccounts.length),
      ],
    );
  }

  getClosed() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.only(
            left: 32.w,
            right: 16.w,
            top: 14.h,
            bottom: 12.h,
          ),
          child: Text(
            "Closed",
            style: bodyBold18Secondary(color: GlorifiColors.textDarkBlue),
          ),
        ),
        ListView.builder(
            itemBuilder: (context, index) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 32.w, right: 16.w),
                      child: AccountTile(
                        title: controller.creditScoreModel.value.data!
                            .creditAccounts!.closedAccounts[index].name,
                        desc:
                            '${controller.creditScoreModel.value.data!.creditAccounts!.closedAccounts[index].institution} ${controller.creditScoreModel.value.data!.creditAccounts!.closedAccounts[index].mask}',
                        amount: 0,
                        allowPadding: false,
                        showAmount: false,
                      ),
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    if (index !=
                        controller.creditScoreModel.value.data!.creditAccounts!
                                .closedAccounts.length -
                            1)
                      Padding(
                        padding: EdgeInsets.only(left: 20.w),
                        child: Divider(
                          height: 1,
                          color: GlorifiColors.lighterGrey,
                        ),
                      ),
                    if (index !=
                        controller.creditScoreModel.value.data!.creditAccounts!
                                .closedAccounts.length -
                            1)
                      SizedBox(
                        height: 16.h,
                      ),
                  ],
                ),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: controller.creditScoreModel.value.data!.creditAccounts!
                .closedAccounts.length),
      ],
    );
  }

  Widget getInfoBox({
    Color dotColor = GlorifiColors.blueIcon,
    required String title,
    required String percentage,
    required String status,
    Function()? onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: onTap,
        child: Container(
          width: double.maxFinite,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.white,
          ),
          margin: EdgeInsets.only(bottom: 6.h),
          padding: EdgeInsets.only(
            top: 16.h,
            bottom: 16.h,
            left: 12.w,
            right: 22.w,
          ),
          child: Row(
            children: [
              Container(
                height: 8,
                width: 8,
                decoration: BoxDecoration(
                  color: dotColor,
                  shape: BoxShape.circle,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: captionBold14Primary(
                          color: GlorifiColors.almostBlack),
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    Text(
                      "$percentage | $status",
                      style: xSmallSemiBold12Primary(
                          color: GlorifiColors.textDarkBlue),
                    )
                  ],
                ),
              ),
              SvgPicture.asset(
                GlorifiAssets.infoCircle,
                color: GlorifiColors.darkBlueTint[500],
              )
            ],
          ),
        ),
      ),
    );
  }

  getTitleValue({String title = "", String value = ""}) {
    return Padding(
      padding: EdgeInsets.only(left: 32.w, right: 20.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: xSmallSemiBold12Primary(color: GlorifiColors.textDarkBlue),
          ),
          Text(
            value,
            style: captionBold14Secondary(color: GlorifiColors.cornflowerBlue)
                .copyWith(height: 24 / 14),
          ),
        ],
      ),
    );
  }
}
