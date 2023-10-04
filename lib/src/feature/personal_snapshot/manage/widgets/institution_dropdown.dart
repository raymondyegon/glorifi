import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';

class InstitutionDropdown extends StatelessWidget {
  final List<Widget> dropdownItems;
  final String institution;

  InstitutionDropdown(
      {Key? key, required this.institution, required this.dropdownItems})
      : super(key: key);

  var _expanded = false.obs;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5),
      child: Column(
        children: [
          Obx(
            () => ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              child: Container(
                margin: const EdgeInsets.symmetric(
                  vertical: 10,
                ),
                child: ExpansionTile(
                  backgroundColor: Colors.white,
                  collapsedBackgroundColor: Colors.white,
                  title: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Text(
                      institution,
                      style:
                          bodyBold18Primary(color: GlorifiColors.almostBlack),
                    ),
                  ),
                  children: [
                    Divider(color: Colors.grey),
                    ...dropdownItems,
                    //LinkNewAccountButton(),
                  ],
                  childrenPadding: EdgeInsets.only(
                    left: 20,
                  ),
                  initiallyExpanded: false,
                  trailing: Icon(_expanded.value ? Icons.remove : Icons.add,
                      color: Colors.black),
                  onExpansionChanged: (bool expanded) {
                    _expanded.value = expanded;
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// List<SnapshotDropdownAccountItem> makeDropdownItems(
//     List<DropDownAccount> accounts) {
//   return [
//     ...accounts.map(
//       (account) {
//         return SnapshotDropdownAccountItem(
//           balance: account.balance,
//           label: account.getLabel,
//           onTap: () {
//             Get.to(
//               AccountDetailsPage(
//                 institution: account.getLabel,
//                 mask: "3332",
//                 accountId: account.accountId,
//                 showGraph: false,
//               ),
//             );
//           },
//         );
//       },
//     ),
//   ];
// }
