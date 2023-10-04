import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/feature/banking/servicing/screens/transfer/transfer_controller.dart';

class SelectedAccountGlorifi extends GetView<TransferController> {
  const SelectedAccountGlorifi({
    Key? key,
    required this.fromOrTo,
  }) : super(
          key: key,
        );
  final String? fromOrTo;

  @override
  Widget build(BuildContext context) {
    convertAccountToLastFourDigitsGlorifi(fromOrTo) {
      if (fromOrTo == "from") {
        return controller.selectedGlorifiAccountFrom!.value!.accountNumber
            .substring(controller
                    .selectedGlorifiAccountFrom!.value!.accountNumber.length -
                4);
      } else {
        return controller.selectedGlorifiAccountTo!.value!.accountNumber
            .substring(controller
                    .selectedGlorifiAccountTo!.value!.accountNumber.length -
                4);
      }
    }

    ;
    Get.find<TransferController>();
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Text(
            fromOrTo == "from"
                ? controller.selectedGlorifiAccountFrom!.value!.accountName
                : controller.selectedGlorifiAccountTo!.value!.accountName,
            style: TextStyle(
              fontFamily: "OpenSans",
              fontWeight: FontWeight.w700,
              color: Color(0xFF03213D),
              fontSize: 16,
            ),
          ),
        ),
        Row(
          children: [
            Text(
              convertAccountToLastFourDigitsGlorifi(fromOrTo),
              style: TextStyle(
                fontFamily: "OpenSans",
                fontSize: 16,
                color: Color(0xFF131A3D),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Icon(
                Icons.circle,
                size: 5,
              ),
            ),
            Text(
              fromOrTo == "from"
                  ? controller.selectedGlorifiAccountFrom!.value!.currentBalance
                  : controller.selectedGlorifiAccountTo!.value!.currentBalance,
              style: TextStyle(
                fontFamily: "OpenSans",
                fontSize: 16,
                color: Color(0xFF131A3D),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
