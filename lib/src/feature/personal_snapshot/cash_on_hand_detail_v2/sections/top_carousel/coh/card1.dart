// ignore_for_file: use_raw_strings

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/feature/personal_snapshot/widgets/SnapshotBalance.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/feature/personal_snapshot/cash_on_hand_detail_v2/cash_on_hand_controller.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_sizing.dart';
import 'package:glorifi/src/widgets/charts/semicircle/semicircle_graph.dart';

class Card1 extends StatelessWidget {
  const Card1({Key? key, required this.sizingInfo}) : super(key: key);
  final AdaptiveSizingInfo sizingInfo;

  @override
  Widget build(BuildContext context) {
    final cashOnHandController = Get.find<CashOnHandController>();
    return Obx(
      () => Container(
        width: sizingInfo.isDesktop ? 795 : double.maxFinite,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 48.0),
              child: Text(
                "Total amount of any cash across all your connected accounts.",
                textAlign: TextAlign.center,
                style: captionSemiBold14Primary(color: Color(0xFFD0D8E7)),
              ),
            ),
            SizedBox(
              height: 40.0,
            ),
            Text(
              "Total",
              style: smallBold16Primary(color: Color(0xFFF0F4FB)),
              textAlign: TextAlign.center,
            ),
            SnapshotBalance(
              balance: cashOnHandController.totalAmount.value,
              fontSize: 50,
            ),
            Spacer(),
            SemicircleGraph(
              amount1: cashOnHandController.totalCheckingAmount.value,
              label1: 'Checking',
              amount2: cashOnHandController.totalSavingsAmount.value,
              label2: 'Savings',
            ),
          ],
        ),
      ),
    );
  }
}
