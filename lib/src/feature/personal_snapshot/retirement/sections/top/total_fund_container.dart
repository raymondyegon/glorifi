import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/feature/personal_snapshot/retirement/retirement_controller.dart';
import 'package:glorifi/src/feature/personal_snapshot/widgets/SnapshotBalance.dart';

class TotalFundContainer extends StatelessWidget {
  const TotalFundContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var retController = Get.find<RetirementController>();

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 40),
      child: Column(
        children: [
          Text(
            'Total Retirement Fund',
            style: TextStyle(color: Colors.white),
          ),
          SnapshotBalance(balance: retController.totalFund.value, fontSize: 45),
          // Text(
          //   'Save \$1500/Year to hit your goal',
          //   style: TextStyle(
          //     color: Color(0xFF1AD35E),
          //     fontFamily: "Univers",
          //   ),
          // ),
        ],
      ),
    );
  }
}
