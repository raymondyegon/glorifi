import 'package:flutter/material.dart';
import 'package:glorifi/src/feature/personal_snapshot/cash_on_hand_detail_v2/sections/savings_checkings_page/savings_checkings_controller.dart';

import 'package:glorifi/src/feature/personal_snapshot/cash_on_hand_detail_v2/sections/savings_checkings_page/savings_checkings_graph.dart';

class TotalCheckingsSavingsPastMonth extends StatelessWidget {
  final String? type;
  List<ChartData> data;

  TotalCheckingsSavingsPastMonth(this.type, this.data);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(8),
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: Text(
              "Total " +
                  (type! == "checking" ? "Checking" : "Savings") +
                  " In The Past 30 days",
              style: TextStyle(
                fontFamily: "Univers",
                fontWeight: FontWeight.w700,
                fontSize: 26,
                color: Color(0XFF171A20),
              ),
            ),
          ),
          SavingsCheckingsGraph(
            data: data,
            type: type,
          ),
        ],
      ),
    );
  }
}
