// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/feature/banking/servicing/screens/transfer/eligible_accounts_model.dart';
import 'package:glorifi/src/feature/banking/servicing/screens/transfer/widgets/account_card_shimmer.dart';
import 'package:glorifi/src/feature/banking/servicing/screens/transfer/transfer_controller.dart';
import 'package:intl/intl.dart';

class GlorifiAccountCard extends GetView<TransferController> {
  const GlorifiAccountCard({
    Key? key,
    required this.fromOrTo,
  }) : super(
          key: key,
        );
  final String? fromOrTo;

  @override
  Widget build(BuildContext context) {
    //Format to US Currency Dollar Format
    final usCurrency = NumberFormat("#,##0.00", "en_US");

    Get.find<TransferController>();
    return controller.obx(
      (state) => ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: fromOrTo == "from"
            ? controller.glorifiAccountsModelListFrom.length
            : controller.glorifiAccountsModelListTo.length,
        itemBuilder: (context, index) {
          List<GlorifiAccounts> glorifiAccountsModelList = fromOrTo == "from"
              ? controller.glorifiAccountsModelListFrom
              : controller.glorifiAccountsModelListTo;
          //Get Account Balance as Double
          var accountBalance =
              double.parse(glorifiAccountsModelList[index].currentBalance);
          //Trim Account Name Strings
          var accountNameRaw = glorifiAccountsModelList[index].accountName;
          final splitString = accountNameRaw.split(' ');
          final accountName = splitString[1];
          //Trim Account Numbers
          var rawAccountNumber = glorifiAccountsModelList[index].accountNumber;
          var accountNumber =
              rawAccountNumber.substring(rawAccountNumber.length - 4);
          return InkWell(
            onTap: () {
              if (fromOrTo == "from") {
                controller.selectedFromAccountType.value = "Glorifi";

                controller.selectedGlorifiAccountFrom!.value =
                    glorifiAccountsModelList[index];

                //Set Available Balance to ensure enough is available
                controller.availableBalanceInFromAccount.value = double.parse(
                    glorifiAccountsModelList[index].currentBalance);
                print(controller.availableBalanceInFromAccount);
              }
              if (fromOrTo == "to") {
                controller.selectedToAccountType.value = "Glorifi";
                controller.selectedGlorifiAccountTo!.value =
                    glorifiAccountsModelList[index];
              }

              Get.back();
            },
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xFF152951),
                borderRadius: BorderRadius.all(
                  Radius.circular(7),
                ),
              ),
              height: 87,
              margin: const EdgeInsets.symmetric(
                vertical: 7,
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 32,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        accountName,
                        style: TextStyle(
                          color: Color(0xFFFCFCFC),
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          fontFamily: "OpenSans",
                        ),
                      ),
                      Text(
                        "*$accountNumber",
                        style: TextStyle(
                          color: Color(0xFFFCFCFC),
                          fontSize: 16,
                          fontFamily: "OpenSans",
                        ),
                      )
                    ],
                  ),
                  Text(
                    "\$${usCurrency.format(accountBalance)}",
                    style: TextStyle(
                      color: Color(0xFFFCFCFC),
                      fontSize: 26,
                      fontFamily: "univers",
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        addRepaintBoundaries: false,
      ),
      onLoading: AccountCardShimmer(),
      onEmpty: Text("Items Empty"),
      onError: (error) => Text("Check Back Soon"),
    );
  }
}
