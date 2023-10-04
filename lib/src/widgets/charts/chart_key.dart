import 'package:flutter/material.dart';
import 'package:glorifi/src/feature/personal_snapshot/widgets/SnapshotBalance.dart';
import 'package:glorifi/src/font_style_global.dart';


class GraphKey extends StatelessWidget {
  double quantity;
  String label;
  Color color;
  GraphKey(
      {Key? key,
      required this.quantity,
      required this.label,
      required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext buildContext) {
    return Column(children: [
      SizedBox(
        height: 4,
        width: 27,
        child: DecoratedBox(
          decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.all(Radius.circular(10))),
        ),
      ),
      SizedBox(height: 10),
      Text(
        label,
        textAlign: TextAlign.center,
        style: xSmallBold12Primary(color: const Color(0xFFD0D8E7)),
      ),
      SnapshotBalance(
        balance: quantity,
        fontSize: 18,
      ),
    ]);
  }
}
