import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/controllers/plaid_controller.dart';
import 'package:glorifi/src/feature/personal_snapshot/cash_on_hand_detail/cash_on_hand_controller.dart';
import 'package:glorifi/src/feature/personal_snapshot/personal_snapshot_constants.dart';
import 'package:glorifi/src/feature/personal_snapshot/widgets/detail_screen_layout_widget.dart';
import 'package:glorifi/src/utils/date_util.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive_extensions.dart';
import 'package:glorifi/src/widgets/charts/horizontal_bar_chart.dart';

import '../../../font_style_global.dart';
import '../../../glorifi-widgets/main_account_tile.dart';
import '../../../utils/adaptive/adaptive_base_widget.dart';
import '../../../utils/adaptive/adaptive_widgets/adaptive_scaffold.dart';
import '../../../widgets/appbars/glorifi_appbar.dart';

class CashOnHandScreen extends GetView<CashOnHandControllerV1> {
  final PlaidController plaidController = Get.put(PlaidController());

  CashOnHandScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AdaptiveBuilder(builder: (context, sizingInfo) {
      return AdaptiveScaffold(
        backgroundColor: GlorifiColors.bgBoxColor,
        appBar: GlorifiAppBar(
          title: "Cash on Hand",
          textStyle: bodySemiBold18Primary(
            color: GlorifiColors.ebonyBlue,
          ),
        ),
        body: Obx(() {
          return getDetailScreenWidget(sizingInfo);
        }),
      );
    });
  }

  Widget getDetailScreenWidget(sizingInfo) {
    return Center(
      child: DetailScreenLayoutWidget(
        statusApi: controller.statusApi.value,
        refresh: controller.getCashOnHandDetail,
        title: controller.cashOnHandModel.value.data?.title,
        headerText: controller.cashOnHandModel.value.data?.description,
        mainValue: controller.cashOnHandModel.value.data?.totalAmount,
        mainValueDescription: 'Across All Linked Accounts',
        chart: Padding(
          padding: EdgeInsets.only(
            top: 74.h,
            bottom: 96.h,
          ),
          child: HorizontalBarChart(
            data: controller.chartData,
          ),
        ),
        lastPullInfo:
            'As of ${controller.cashOnHandModel.value.data?.asOfDate!.todMMM()} (pull $kCashOnHandPullRate)',
        dataSourceLabel: "",
        isLoading: controller.loading.value,
        bottomContent: [
          // TileButtonWidget(
          //   title: "Compare Cash on Hand",
          //   callback: () {
          //     controller.openComparison();
          //   },
          //   icon: "assets/icons/personal_snapshot/compare_cash.svg",
          // ),
          // SizedBox(
          //   height: 30.h,
          // ),
          getAccountTiles()
        ],
      ),
    );
  }

  Widget getAccountTiles() {
    return Column(
      children: [
        if (controller.cashOnHandModel.value.data?.checkingAccounts != null)
          MainAccountTile(
              data: MainAccountTileData(
            title:
                '${controller.cashOnHandModel.value.data!.checkingAccounts.length} Checking ${controller.cashOnHandModel.value.data!.checkingAccounts.length > 1 ? "Accounts" : "Account"}',
            items: controller.cashOnHandModel.value.data!.checkingAccounts,
            buttonText: "Link Another Checking Account",
            buttonAction: () async {
              await plaidController.openPlaid();
            },
          )),
        if (controller.cashOnHandModel.value.data?.savingsAccounts != null)
          MainAccountTile(
              data: MainAccountTileData(
            title:
                '${controller.cashOnHandModel.value.data!.savingsAccounts.length} Savings ${controller.cashOnHandModel.value.data!.savingsAccounts.length > 1 ? "Accounts" : "Account"}',
            items: controller.cashOnHandModel.value.data!.savingsAccounts,
            buttonText: "Link Another Savings Account",
            buttonAction: () async {
              await plaidController.openPlaid();
            },
          )),
        if (controller.cashOnHandModel.value.data?.otherAccounts != null)
          MainAccountTile(
              data: MainAccountTileData(
            title:
                '${controller.cashOnHandModel.value.data!.otherAccounts.length} Other ${controller.cashOnHandModel.value.data!.otherAccounts.length > 1 ? "Accounts" : "Account"}',
            items: controller.cashOnHandModel.value.data!.otherAccounts,
            buttonText: "Link Another Account",
            buttonAction: () async {
              await plaidController.openPlaid();
            },
          )),
      ],
    );
  }
}
