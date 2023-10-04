import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SnapshotBalance extends StatelessWidget {
  final double balance;
  final double fontSize;

  SnapshotBalance({Key? key, required this.balance, required this.fontSize})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    NumberFormat dollarFormatter = NumberFormat("#,##0.00", "en_US");
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 2),
          child: Text(
            r'$',
            style: TextStyle(
              fontSize: fontSize - 20 > 10 ? fontSize - 20 : 12,
              fontWeight: FontWeight.w700,
              fontFamily: "Univers",
              color: Colors.white,
            ),
          ),
        ),
        Text(
          dollarFormatter.format(balance),
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.w700,
            fontFamily: "UniversWide",
            color: Colors.white,
          ),
        )
      ],
    );
  }
}
