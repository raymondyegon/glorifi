import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/feature/banking/servicing/screens/transfer/transfer_controller.dart';
import 'package:intl/intl.dart';

class SelectedAccountLinked extends GetView<TransferController> {
  const SelectedAccountLinked({
    Key? key,
    required this.fromOrTo,
  }) : super(
          key: key,
        );
  final String? fromOrTo;

  @override
  Widget build(BuildContext context) {
    final usCurrency = NumberFormat("#,##0.00", "en_US");
    Get.find<TransferController>();
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Text(
            fromOrTo == "from"
                ? controller.selectedLinkedAccountFrom!.value!.name
                : controller.selectedLinkedAccountTo!.value!.name,
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
              fromOrTo == "from"
                  ? '*${controller.selectedLinkedAccountFrom!.value!.mask}'
                  : '*${controller.selectedLinkedAccountTo!.value!.mask}',
              style: TextStyle(
                fontFamily: "OpenSans",
                fontSize: 16,
                color: Color(0xFF131A3D),
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 8.0),
            //   child: Icon(
            //     Icons.circle,
            //     size: 5,
            //   ),
            // ),
            // Text(fromOrTo == "from"?
            //   "\$${usCurrency.format(controller.selectedLinkedAccountFrom!.value!.balance)}":  "\$${usCurrency.format(controller.selectedLinkedAccountTo!.value!.balance)}",
            //   style: TextStyle(
            //     fontFamily: "OpenSans",
            //     fontSize: 16,
            //     color: Color(0xFF131A3D),
            //   ),
            // ),
          ],
        ),
      ],
    );
  }
}
