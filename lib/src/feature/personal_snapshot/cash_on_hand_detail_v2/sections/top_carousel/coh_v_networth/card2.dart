import 'package:flutter/material.dart';
import 'package:glorifi/src/feature/personal_snapshot/cash_on_hand_detail_v2/cash_on_hand_controller.dart';

import 'package:get/get.dart';
import 'package:glorifi/src/feature/personal_snapshot/cash_on_hand_detail_v2/sections/top_carousel/coh_v_networth/coh_vs_networth_graph.dart';

class Card2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cashOnHandController = Get.find<CashOnHandController>();
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 25),
      child: Column(
        children: [
          Text(
            "vs",
            style: TextStyle(
              fontFamily: "Arvo",
              fontWeight: FontWeight.w700,
              fontSize: 26,
              color: Color(0xFF7487A4),
            ),
          ),
          Text(
            "Net Worth",
            style: TextStyle(
              fontFamily: "Univers",
              fontWeight: FontWeight.w700,
              fontSize: 22,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 10),
          Text(
            'Best practice would be 15% of your net worth in cash',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: "Univers",
              fontWeight: FontWeight.w500,
              fontSize: 14,
              color: Color(0xFFCFD8E6),
            ),
          ),
          Spacer(),
          CohVsNetWorthGraph(
            cohData: cashOnHandController.cohData,
            networthData: cashOnHandController.netWorthData,
          ),
          Spacer(),
        ],
      ),
    );
  }
}
