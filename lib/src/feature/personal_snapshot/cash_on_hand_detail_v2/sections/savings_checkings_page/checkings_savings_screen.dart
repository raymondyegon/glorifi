import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/controllers/plaid_controller.dart';
import 'package:glorifi/src/feature/personal_snapshot/cash_on_hand_detail_v2/cash_on_hand_controller.dart';
import 'package:glorifi/src/feature/personal_snapshot/cash_on_hand_detail_v2/sections/loading_shimmer.dart';
import 'package:glorifi/src/feature/personal_snapshot/cash_on_hand_detail_v2/sections/savings_checkings_page/savings_checkings_controller.dart';
import 'package:glorifi/src/feature/personal_snapshot/cash_on_hand_detail_v2/sections/savings_checkings_page/account_balance_card.dart';
import 'package:glorifi/src/feature/personal_snapshot/cash_on_hand_detail_v2/sections/savings_checkings_page/total_checkings_savings_past_month.dart';
import 'package:glorifi/src/feature/personal_snapshot/widgets/layout/layout.dart';
import 'package:glorifi/src/feature/personal_snapshot/widgets/link_new_account_button.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_base_widget.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_sizing.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive.dart';
import 'package:glorifi/src/utils/responsive/responsive_extensions.dart';
import 'package:glorifi/src/utils/number_format_util.dart';

class CheckingsSavingsScreen extends GetView<SavingsCheckingsController> {
  CheckingsSavingsScreen({
    Key? key,
    required this.type,
  }) : super(key: key);

  //type will either be "checking" or "savings"

  final String? type;

  @override
  Widget build(BuildContext context) {
    Get.put(SavingsCheckingsController(type));
    final cashOnHandController = Get.find<CashOnHandController>();

    return AdaptiveBuilder(
      builder: (context, sizingInfo) {
        return Layout(
          titleMobile: type == "checking" ? "Total Checking" : "Total Savings",
          body: container(sizingInfo, cashOnHandController),
        );
      },
    );
  }

  Widget container(AdaptiveSizingInfo sizingInfo,
      CashOnHandController cashOnHandController) {
    return controller.obx(
      (state) => controller.obx(
        (state) => ContentCheckingsSavings(
          type: type,
          cashOnHandController: cashOnHandController,
          controller: controller,
          sizingInfo: sizingInfo,
        ),
        onLoading: LoadingShimmer(),
        onEmpty: Text("Items Empty"),
        onError: (error) => Text("Check Back Soon"),
      ),
    );
  }
}

class ContentCheckingsSavings extends StatelessWidget {
  const ContentCheckingsSavings({
    Key? key,
    required this.type,
    required this.cashOnHandController,
    required this.controller,
    required this.sizingInfo,
  }) : super(key: key);

  final String? type;
  final CashOnHandController cashOnHandController;
  final SavingsCheckingsController controller;
  final AdaptiveSizingInfo sizingInfo;

  @override
  Widget build(BuildContext context) {
    final PlaidController plaidController = Get.put(PlaidController());
    return Container(
      color: Color(0xFFF4F5F7),
      child: ListView(
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
          containerResponsive(
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
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
                      ? controller.history
                      : controller.accounts[controller.selectedAccount.value]
                          .thirtyDayBalance,
                ),
              ),
            ),
          ),
          containerResponsive(
            Container(
              height: 300,
              child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 20.0, right: 20, top: 40, bottom: 12),
                    child: Text(
                      '${type == "checking" ? "Checking" : "Savings"} Accounts',
                      style: headlineBold28Secondary(
                        color: Color(0xFF171A20),
                      ),
                    ),
                  ),

                  // List of Accounts
                  Column(
                    children: [
                      ...controller.accounts.map(
                        (account) {
                          var index = controller.accounts.indexOf(account);
                          return InkWell(
                            onTap: () {
                              // Get.to(
                              //   AccountDetailsPage(
                              //     institution: account.institution,
                              //     mask: account.mask,
                              //     accountId: account.accountId,
                              //   ),
                              // );
                              if (controller.selectedAccount.value == index)
                                controller.selectedAccount.value = -1;
                              else
                                controller.selectedAccount.value = index;
                            },
                            child: Obx(
                              () => AccountBalanceCard(
                                institution:
                                    controller.accounts[index].institution,
                                mask: controller.accounts[index].mask,
                                balance: controller.accounts[index].balance,
                                selected:
                                    controller.selectedAccount.value == index,
                                Logo: controller.accounts[index].logo,
                                accountId: controller.accounts[index].accountId,
                              ),
                            ),
                          );
                        },
                      ).toList()
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: LinkNewAccountButton(
                      onTap: () async {
                        await plaidController.openPlaid(
                            flowType: type == "checking"
                                ? PlaidFlowType.checking
                                : PlaidFlowType.savings);
                      },
                    ),
                  ),
                  if (!sizingInfo.isDesktop)
                    SizedBox(
                      height: 32.h,
                    )
                ],
              ),
            ),
          ),
          // Savings/Checkings Accounts Title
        ],
      ),
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
