import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/feature/personal_snapshot/cash_on_hand_detail_v2/cash_on_hand_controller.dart';
import 'package:glorifi/src/feature/personal_snapshot/cash_on_hand_detail_v2/sections/loading_shimmer.dart';
import 'package:glorifi/src/feature/personal_snapshot/cash_on_hand_detail_v2/sections/savings_checkings_page/savings_checkings_controller.dart';
import 'package:glorifi/src/feature/personal_snapshot/cash_on_hand_detail_v2/sections/savings_checkings_page/account_balance_card.dart';
import 'package:glorifi/src/feature/personal_snapshot/cash_on_hand_detail_v2/sections/savings_checkings_page/total_checkings_savings_past_month.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_base_widget.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_sizing.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_widgets/adaptive_scaffold.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive.dart';
import 'package:glorifi/src/widgets/appbars/glorifi_appbar.dart';
import 'package:glorifi/src/utils/number_format_util.dart';

class AccountsDetailScreen extends GetView<SavingsCheckingsController> {
  AccountsDetailScreen({
    Key? key,
    required this.type,
  }) : super(key: key);

  //type will either be "checking" or "savings"

  final String? type;

  @override
  Widget build(BuildContext context) {
    final accountController = Get.put(SavingsCheckingsController(type));
    final cashOnHandController = Get.find<CashOnHandController>();

    return AdaptiveBuilder(
      builder: (context, sizingInfo) {
        if (sizingInfo.isDesktop) {
          return AdaptiveScaffold(
            backgroundColor: GlorifiColors.productsBgWhite,
            appBar: GlorifiAppBar(
              title: '',
            ),
            body: controller.obx(
              (state) => ContainerAccountsDetails(
                type: type,
                cashOnHandController: cashOnHandController,
                controller: controller,
                accountController: accountController,
                sizingInfo: sizingInfo,
              ),
              onLoading: Center(
                child: Container(
                  width: 1024,
                  child: LoadingShimmer(),
                ),
              ),
              onEmpty: Text("Items Empty"),
              onError: (error) => Text("Check Back Soon"),
            ),
          );
        }

        return Scaffold(
          appBar: GlorifiAppBar(
            title: type == "checking"
                ? "Total Checking Accounts"
                : "Total Savings Accounts",
            textStyle: leadSemiBold18Primary(color: GlorifiColors.black),
            elevation: 0,
            bgColor: Color(0xFFF4F5F7),
          ),
          body: controller.obx(
            (state) => Container(
              color: Color(0xFFF4F5F7),
              child: ContainerAccountsDetails(
                type: type,
                cashOnHandController: cashOnHandController,
                controller: controller,
                accountController: accountController,
                sizingInfo: sizingInfo,
              ),
            ),
            onLoading: LoadingShimmer(),
            onEmpty: Text("Items Empty"),
            onError: (error) => Text("Check Back Soon"),
          ),
        );
      },
    );
  }
}

class ContainerAccountsDetails extends StatelessWidget {
  const ContainerAccountsDetails({
    Key? key,
    required this.type,
    required this.cashOnHandController,
    required this.controller,
    required this.accountController,
    required this.sizingInfo,
  }) : super(key: key);

  final String? type;
  final CashOnHandController cashOnHandController;
  final SavingsCheckingsController controller;
  final SavingsCheckingsController accountController;
  final AdaptiveSizingInfo sizingInfo;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        if (sizingInfo.isDesktop)
          containerResponsive(
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  type == "checking"
                      ? "Total Checking Accounts"
                      : "Total Savings Accounts",
                  style: headlineBold26Secondary(
                    color: GlorifiColors.almostBlack,
                  ),
                ),
              ],
            ),
            height: 122.h,
          ),
        // //Total Amount Card
        // CohTotalAmountCard(type: type),
        containerResponsive(
          Row(
            mainAxisAlignment: sizingInfo.isDesktop
                ? MainAxisAlignment.start
                : MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                type == "checking"
                    ? cashOnHandController.totalCheckingAmount.value
                        .formatCurrencyWithZero()
                    : cashOnHandController.totalSavingsAmount.value
                        .formatCurrencyWithZero(),
                style: TextStyle(
                  color: Color(0xFF171A20),
                  fontFamily: 'Univers',
                  fontSize: 45,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: sizingInfo.isDesktop ? 46.h : 0),
        Container(
          color: Colors.white,
          child: containerResponsive(
            Obx(
              () => TotalCheckingsSavingsPastMonth(
                type,
                controller.selectedAccount.value == -1
                    ? accountController.history
                    : accountController
                        .accounts[controller.selectedAccount.value]
                        .thirtyDayBalance,
              ),
            ),
          ),
        ),

        containerResponsive(
          Padding(
            padding: const EdgeInsets.only(
                left: 20.0, right: 20, top: 40, bottom: 12),
            child: Text(
              'Added Accounts',
              style: headlineBold26Primary(color: Color(0xFF171A20)),
            ),
          ),
        ),

        containerResponsive(
          Column(
            children: [
              ...accountController.accounts.map(
                (account) {
                  var index = accountController.accounts.indexOf(account);
                  return InkWell(
                    onTap: () {
                      if (controller.selectedAccount.value == index)
                        controller.selectedAccount.value = -1;
                      else
                        controller.selectedAccount.value = index;
                    },
                    child: Obx(
                      () => AccountBalanceCard(
                        institution:
                            accountController.accounts[index].institution,
                        mask: accountController.accounts[index].mask,
                        balance: accountController.accounts[index].balance,
                        selected:
                            accountController.selectedAccount.value == index,
                        Logo: accountController.accounts[index].logo,
                        accountId: accountController.accounts[index].accountId,
                      ),
                    ),
                  );
                },
              ).toList()
            ],
          ),
        ),

        containerResponsive(
          Container(
            margin: EdgeInsets.all(20),
            decoration: BoxDecoration(
                color: Color(0xFFF1F4FB),
                borderRadius: BorderRadius.all(
                  Radius.circular(12),
                ),
                border: Border.all(color: Color(0xFFB7C9EC))),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(100),
                      ),
                    ),
                    child: Transform.rotate(
                      angle: 90 * 3.14 / 120,
                      child: Icon(
                        Icons.link_outlined,
                        size: 27,
                        color: GlorifiColors.midnightBlue,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 8.0,
                  ),
                  Text(
                    'Link New Account',
                    style: TextStyle(color: GlorifiColors.midnightBlue),
                  ),
                  Spacer(),
                  Icon(
                    Icons.chevron_right,
                    size: 27,
                    color: GlorifiColors.midnightBlue,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget containerResponsive(Widget child, {double? height}) {
    return Center(
      child: Container(
        width: sizingInfo.isDesktop ? 1024.w : double.maxFinite,
        height: height,
        child: child,
      ),
    );
  }
}
