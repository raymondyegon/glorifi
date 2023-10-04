import 'package:flutter/material.dart';
import 'package:glorifi/src/feature/personal_snapshot/total_debt_detail/debt_graph_page/debt_graph_legends.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/widgets/charts/chart_data_models.dart';

class DebtGraph extends StatelessWidget {
  final String title;
  final List<GraphData> graphData;
  final double interestRate;
  final double remainingDebt;
  final double approvedDebt;

  const DebtGraph({
    Key? key,
    required this.title,
    required this.graphData,
    required this.interestRate,
    required this.remainingDebt,
    required this.approvedDebt,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(20),
      child: Container(
        height: 450,
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            Text(
              title,
              style: headlineBold30Secondary(),
            ),

            // Graph
            Container(
              width: double.infinity,
              height: 250,
              color: Colors.grey,
              child: Text('Graph goes here'),
            ),

            DebtGraphLegends(
              remainingDebt: 11400,
              approvedAmt: 40000,
              interestRate: interestRate,
            )
          ],
        ),
      ),
    );
  }
}
