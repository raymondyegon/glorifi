import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/controllers/plaid_controller.dart';
import 'package:glorifi/src/feature/banking/servicing/screens/transfer/transfer_controller.dart';
import 'package:glorifi/src/feature/banking/servicing/screens/transfer/widgets/glorifi_account_card.dart';
import 'package:glorifi/src/feature/banking/servicing/screens/transfer/widgets/linked_account_card.dart';
import 'package:glorifi/src/feature/banking/widgets/outlined_button_widget.dart';

class TransferAccountSelect extends StatelessWidget {
  const TransferAccountSelect({
    Key? key,
    required this.fromOrTo,
  }) : super(key: key);
  final String? fromOrTo;

  @override
  Widget build(BuildContext context) {
    Get.find<TransferController>();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Transfer",
          style: TextStyle(
            color: Color(0xFF131A3D),
            fontFamily: "OpenSans",
            fontSize: 20,
          ),
        ),
        iconTheme: IconThemeData(
          color: Color(0xFF131A3D), //change your color here
        ),
        backgroundColor: Color(0xFFE5E5E5),
        elevation: 0,
      ),
      body: Container(
        color: Color(0xFFE5E5E5),
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          horizontal: 20,
        ),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 30,
              ),
              child: Text(
                fromOrTo == "from"
                    ? "What Account Will You Be Transferring From?"
                    : "What Account Will You Be Transferring To?",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  fontFamily: "OpenSans",
                  color: Color(0xFF131A3D),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 48.0,
                bottom: 10,
              ),
              child: Divider(
                color: Color(0xFFDEDEDE),
                thickness: 4,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 18.0),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  "GloriFi Accounts",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    fontFamily: "OpenSans",
                    color: Color(0xFF03213D),
                  ),
                ),
              ),
            ),
            //List Of Glorifi Accounts
            GlorifiAccountCard(
              fromOrTo: fromOrTo,
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 20.0,
                bottom: 10,
              ),
              child: Divider(
                color: Color(0xFFDEDEDE),
                thickness: 4,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 18.0),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  "External Accounts",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    fontFamily: "OpenSans",
                    color: Color(0xFF03213D),
                  ),
                ),
              ),
            ),
            //List of Linked Accounts
            LinkedAccountCard(
              fromOrTo: fromOrTo,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
              child: Divider(
                color: Color(0xFFDEDEDE),
                thickness: 4,
              ),
            ),
            OutlinedButtonWidget(
              icon: Image.asset('assets/images/addIcon.png'),
              text: 'Link Account',
              onTap: () async {
                PlaidController _plaidController = Get.put(PlaidController());
                await _plaidController.openPlaid(
                    flowType: PlaidFlowType.transferLinking);
              },
            ),
          ],
        ),
      ),
    );
  }
}
