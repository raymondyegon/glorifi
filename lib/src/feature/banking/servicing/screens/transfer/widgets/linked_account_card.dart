// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/feature/banking/servicing/screens/transfer/widgets/account_card_shimmer.dart';
import 'package:glorifi/src/feature/banking/servicing/screens/transfer/transfer_controller.dart';
import 'package:intl/intl.dart';

class LinkedAccountCard extends GetView<TransferController> {
  const LinkedAccountCard({
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
        itemCount: controller.linkedAccountsModelList.length,
        itemBuilder: (context, index) {
          //Trimed Account Number
          var accountNumber = controller.linkedAccountsModelList[index].mask;

          //Account Name
          var accountName = controller.linkedAccountsModelList[index].name;

          //Institution
          var institution =
              controller.linkedAccountsModelList[index].institution;

          return InkWell(
            onTap: () {
              //Set Selected Account Type Glorifi or Plaid
              if (fromOrTo == "from") {
                controller.selectedFromAccountType.value = "Linked";
                controller.selectedLinkedAccountFrom!.value =
                    controller.linkedAccountsModelList[index];

                //Set Available Balance to ensure enough is available
                controller.availableBalanceInFromAccount.value =
                    controller.linkedAccountsModelList[index].balance!;
              }
              if (fromOrTo == "to") {
                controller.selectedToAccountType.value = "Linked";
                controller.selectedLinkedAccountTo!.value =
                    controller.linkedAccountsModelList[index];
              }

              Get.back();
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
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
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        accountName,
                        style: TextStyle(
                          color: Color(0xFF1F3B73),
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          fontFamily: "OpenSans",
                        ),
                      ),
                      Text(
                        institution,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: Color(0xFF36495A),
                          fontSize: 16,
                          fontFamily: "OpenSans",
                        ),
                      )
                    ],
                  ),
                  Text(
                    "*$accountNumber",
                      style: TextStyle(
                        color: Color(0xFF36495A),
                        fontSize: 16,
                        fontFamily: "OpenSans",
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
