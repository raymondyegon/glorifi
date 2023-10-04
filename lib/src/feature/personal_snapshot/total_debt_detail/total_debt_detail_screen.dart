import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/feature/personal_snapshot/total_debt_detail/as_of_date.dart';
import 'package:glorifi/src/feature/personal_snapshot/total_debt_detail/debt_graph_page/debt_graph_page.dart';
import 'package:glorifi/src/feature/personal_snapshot/total_debt_detail/debt_visuals.dart';
import 'package:glorifi/src/feature/personal_snapshot/total_debt_detail/total_debt_controller.dart';
import 'package:glorifi/src/feature/personal_snapshot/widgets/dropdown_widgets/snapshot_dropdown.dart';
import 'package:glorifi/src/feature/personal_snapshot/widgets/dropdown_widgets/snapshot_dropdown_account_item.dart';
import 'package:glorifi/src/feature/personal_snapshot/widgets/layout/layout.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_base_widget.dart';
import 'package:glorifi/src/feature/personal_snapshot/widgets/link_new_account_button.dart';

class TotalDebtDetailScreen extends GetView<TotalDebtController> {
  const TotalDebtDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AdaptiveBuilder(builder: (context, sizingInfo) {
      return Layout(
        titleMobile: "Total Debt",
        body: Obx(() {
          final detail = controller.totalDebtDetail.value;
          return ListView(
            children: [
              sizingInfo.isDesktop ? titleDesktop("Total Debt") : SizedBox(),
              DebtVisuals(
                totalDebt: detail.totalDebt,
                installmentDebt: detail.installmentDebt,
                creditDebt: detail.creditDebt,
                sizingInfo: sizingInfo,
              ),
              SizedBox(
                height: 6,
              ),
              AsOfDate(date: DateTime.now()),
              SizedBox(
                height: 30,
              ),
              containerDesktop(
                Divider(
                  height: 1,
                  color: const Color(0xFFD4DEF4),
                ),
                sizingInfo: sizingInfo,
              ),
              containerDesktop(
                SnapshotDropdown(
                  name: 'Installment Debts',
                  dropdownItems: [
                    ...controller.totalDebtDetail.value.installmentDebtAccounts
                        .map(
                      (account) {
                        return SnapshotDropdownAccountItem(
                          label: account.getLabel,
                          balance: account.balance,
                          onTap: () {
                            // Get.to(
                            //   DebtGraphPage(
                            //     title: "Installment Debts",
                            //     debtList: controller.totalDebtDetail.value
                            //         .installmentDebtAccounts,
                            //   ),
                            // );
                          },
                        );
                      },
                    ),
                  ],
                  additionalWidget: LinkNewAccountButton(),
                ),
                sizingInfo: sizingInfo,
              ),
              containerDesktop(
                SnapshotDropdown(
                  name: 'Credit Debts',
                  dropdownItems: [
                    ...controller.totalDebtDetail.value.creditDebtAccounts.map(
                      (account) {
                        return SnapshotDropdownAccountItem(
                          label: account.getLabel,
                          balance: account.balance,
                          onTap: () {
                            Get.to(
                              DebtGraphPage(
                                title: "Installment Debts",
                                debtList: controller.totalDebtDetail.value
                                    .installmentDebtAccounts,
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ],
                  additionalWidget: LinkNewAccountButton(),
                ),
                sizingInfo: sizingInfo,
              ),
            ],
          );
        }),
      );
    });
  }
}
