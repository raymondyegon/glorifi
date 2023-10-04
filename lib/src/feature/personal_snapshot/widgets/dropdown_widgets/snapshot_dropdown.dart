import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/feature/personal_snapshot/cash_on_hand_detail_v2/sections/account_page/account_details_page.dart';
import 'package:glorifi/src/feature/personal_snapshot/widgets/link_new_account_button.dart';
import 'package:glorifi/src/model/personal_snapshot/dropdown_account.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';

import 'snapshot_dropdown_account_item.dart';

class SnapshotDropdown extends StatelessWidget {
  final List<Widget> dropdownItems;
  final String name;

  SnapshotDropdown({
    Key? key,
    required this.name,
    required this.additionalWidget,
    required this.dropdownItems,
  }) : super(key: key);

  var _expanded = false.obs;
  final Widget additionalWidget;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5),
      child: Theme(
        data: ThemeData().copyWith(dividerColor: Colors.transparent),
        child: Column(
          children: [
            Obx(
              () => ExpansionTile(
                title: Text(
                  '${dropdownItems.length} ${name}',
                  style: TextStyle(
                    color: GlorifiColors.textColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                ),
                children: [...dropdownItems, additionalWidget],
                childrenPadding: EdgeInsets.symmetric(horizontal: 10),
                initiallyExpanded: false,
                trailing: Icon(_expanded.value ? Icons.remove : Icons.add,
                    color: Colors.grey),
                onExpansionChanged: (bool expanded) {
                  _expanded.value = expanded;
                },
              ),
            ),
            Divider(
              color: Color(0xFFD4DEF4),
            ),
          ],
        ),
      ),
    );
  }
}

List<SnapshotDropdownAccountItem> makeDropdownItems(
    List<DropDownAccount> accounts) {
  return [
    ...accounts.map(
      (account) {
        return SnapshotDropdownAccountItem(
          balance: account.balance,
          label: account.getLabel,
          onTap: () {
            Get.to(
              AccountDetailsPage(
                institution: account.getLabel,
                mask: "3332",
                accountId: account.accountId,
                showGraph: false,
              ),
            );
          },
        );
      },
    ),
  ];
}
