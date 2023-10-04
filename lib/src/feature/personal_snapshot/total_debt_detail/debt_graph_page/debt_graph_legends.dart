import 'package:flutter/material.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/utils/number_format_util.dart';

class DebtGraphLegends extends StatelessWidget {
  const DebtGraphLegends(
      {Key? key,
      required this.remainingDebt,
      required this.approvedAmt,
      required this.interestRate})
      : super(key: key);

  final double remainingDebt;
  final double approvedAmt;
  final double interestRate;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              DebtGraphLabel("Remaining Debt", remainingDebt),
              DebtGraphLabel("Approved Debt", approvedAmt),
            ],
          ),
          SizedBox(height: 5),
          Row(children: [
            Text(
              'Interest rate: ',
              style: smallSemiBold11Primary(color: Color(0xFF444E60)),
            ),
            Text(
              '${interestRate * 100}%',
              style: smallBold11Primary(color: Color(0xFF444E60)),
            )
          ]),
        ],
      ),
    );
  }
}

Widget DebtGraphLabel(String label, double value) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        label,
        style: smallSemiBold11Primary(color: Color(0xFF444E60)),
      ),
      Text(
        value.formatSimpleCurrencyZeroDecimal(),
        style: smallBold16Primary(color: Color(0xFF171A20)),
      ),
    ],
  );
}
