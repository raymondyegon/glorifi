import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/controllers/plaid_controller.dart';
import 'package:glorifi/src/feature/credit_card/widgets/add_external_item_tile.dart';
import 'package:glorifi/src/utils/responsive/responsive.dart';

import '../../credit_card/widgets/bank_account_tile.dart';
import '../controller/my_bank_controller.dart';

class LinkedBankAccounts extends StatelessWidget {
  const LinkedBankAccounts({
    Key? key,
    this.onTap,
  }) : super(key: key);

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<MyBankController>();
    PlaidController plaidController = Get.put(PlaidController());
    return Column(
      children: [
        SizedBox(height: 20.h),
        Obx(
          () => controller.externalFundingAccounts.isEmpty
              ? Offstage()
              : Column(
                  children: controller.externalFundingAccounts.map((account) {
                    return BankAccountTile(
                      onTap: onTap,
                      balance: '',
                      secretNumber: "*" + account.mask,
                      bankName: account.name,
                      accountType: account.institution,
                    );
                  }).toList(),
                ),
        ),
        SizedBox(height: 25.h),
        AddExternalItemTile(
          buttonText: "Add External Accounts",
          onTap: () async {
            await plaidController.openPlaid();
          },
          isAddIcon: true,
        ),
        SizedBox(height: 50.h),
      ],
    );
  }
}
