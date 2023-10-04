import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:glorifi/src/feature/personal_snapshot/cash_on_hand_detail_v2/sections/loading_shimmer.dart';
import 'package:glorifi/src/feature/personal_snapshot/net_worth_detail_v2/net_worth_controller.dart';
import 'package:glorifi/src/feature/personal_snapshot/net_worth_detail_v2/sections/add_home_button.dart';
import 'package:glorifi/src/feature/personal_snapshot/net_worth_detail_v2/sections/top/net_worth_graph_container.dart';
import 'package:glorifi/src/feature/personal_snapshot/net_worth_detail_v2/sections/top/net_worth_total.dart';
import 'package:glorifi/src/feature/personal_snapshot/widgets/dropdown_widgets/snapshot_dropdown.dart';
import 'package:glorifi/src/feature/personal_snapshot/widgets/dropdown_widgets/snapshot_dropdown_section.dart';
import 'package:glorifi/src/feature/personal_snapshot/widgets/link_new_account_button.dart';
import '../../../widgets/appbars/glorifi_appbar.dart';

class NetWorthDetailScreen extends GetView<NetWorthController> {
  const NetWorthDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GlorifiAppBar(
        title: "Net Worth",
        textStyle: TextStyle(
          fontFamily: "Univers", // TODO: Add Univers font in asset
          fontWeight: FontWeight.w700,
          fontSize: 22,
          color: Color(0xFFF4F5F7),
        ),
        leadingIconDefaultColor: Colors.white,
        elevation: 0,
        bgColor: Color(0xFF141B3F),
      ),
      body: Container(
        color: Color(0xFFF4F5F7),
        child: ListView(
          children: [
            // Top Blue Section
            Container(
              color: Color(0xFF141B3F),
              child: Column(
                children: [
                  NetworthTotal(controller.netWorthDetail!.value.totalAmount),
                  NetWorthGraphContainer(controller.graphData),
                ],
              ),
            ),

            // Assets Section
            SnapshotDropdownSection(
              title: "Assets",
              dropdowns: [
                SnapshotDropdown(
                  name: 'Depository Accounts',
                  dropdownItems: [
                    ...makeDropdownItems(controller
                        .netWorthDetail!.value.assets.depositoryAccounts),
                  ],
                  additionalWidget: LinkNewAccountButton(),
                ),
                SnapshotDropdown(
                  name: 'Investment Accounts',
                  dropdownItems: [
                    ...makeDropdownItems(controller
                        .netWorthDetail!.value.assets.investmentAccounts),
                  ],
                  additionalWidget: LinkNewAccountButton(),
                ),
                SnapshotDropdown(
                  name: 'Home',
                  dropdownItems: [
                    ...makeDropdownItems(
                      controller.netWorthDetail!.value.assets.homeAccounts,
                    ),
                  ],
                  additionalWidget: AddHomeButton(),
                ),
              ],
            ),

            // Assets Section
            SnapshotDropdownSection(
              title: "Liabilities",
              dropdowns: [
                SnapshotDropdown(
                  name: 'Credit Accounts',
                  dropdownItems: [
                    ...makeDropdownItems(controller
                        .netWorthDetail!.value.liabilities.creditAccounts),
                  ],
                  additionalWidget: LinkNewAccountButton(),
                ),
                SnapshotDropdown(
                  name: 'Installment Accounts',
                  dropdownItems: [
                    ...makeDropdownItems(controller
                        .netWorthDetail!.value.liabilities.loanAccounts),
                  ],
                  additionalWidget: LinkNewAccountButton(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
