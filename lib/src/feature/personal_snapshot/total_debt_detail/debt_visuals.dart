import 'package:flutter/widgets.dart';
import 'package:glorifi/src/feature/personal_snapshot/widgets/SnapshotBalance.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_sizing.dart';
import 'package:glorifi/src/utils/number_format_util.dart';
import 'package:glorifi/src/utils/responsive/responsive.dart';
import 'package:glorifi/src/widgets/charts/semicircle/semicircle_graph.dart';

class DebtVisuals extends StatelessWidget {
  final double totalDebt, installmentDebt, creditDebt;
  final AdaptiveSizingInfo sizingInfo;
  DebtVisuals(
      {Key? key,
      required this.totalDebt,
      required this.installmentDebt,
      required this.creditDebt,
      required this.sizingInfo,
    })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFF141B3F),
      height: sizingInfo.isDesktop ? 650 : 450,
      child: Column(
        children: [
          SizedBox(height: sizingInfo.isDesktop ? 46.h : 0),
          Text('The sum of all your short and long term debt.',
              textAlign: TextAlign.center,
              style: captionSemiBold14Primary(color: Color(0xFFD0D8E7))),
          SizedBox(height: 43),
          Text('Across All Linked Accounts.',
              textAlign: TextAlign.center,
              style: captionSemiBold14Primary(color: Color(0xFFF0F4FB))),
          SnapshotBalance(balance: totalDebt, fontSize: 45),
          Spacer(),
          Container(
            width: sizingInfo.isDesktop ? 795 : double.maxFinite,
            child: SemicircleGraph(
                amount1: installmentDebt,
                label1: "Installment Debt",
                amount2: creditDebt,
                label2: "Credit Debt"),
          )
        ],
      ),
    );
  }
}
