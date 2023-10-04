import 'package:flutter/material.dart';
import 'package:glorifi/src/feature/highlights/highlight_model.dart';
import 'package:glorifi/src/feature/highlights/types/base_highlight.dart';
import 'package:glorifi/src/utils/responsive/responsive.dart';

class BankAccountHighlight extends StatelessWidget {
  final BankAccountHighlightModel highlight;

  const BankAccountHighlight(
      {Key? key, required BankAccountHighlightModel this.highlight})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseHighlight(
      highlight: highlight,
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _getAmount('Savings', highlight.savings),
            _divider(),
            _getAmount('Checking', highlight.checking),
          ],
        ),
        Padding(
            padding: EdgeInsets.only(top: 20.h),
            child: Text(
              "Link Another Account",
              style: TextStyle(fontSize: 15.sp, color: Colors.white),
            ))
      ]),
    );
  }
}

Widget _divider() {
  return Container(
      height: 70.h,
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: VerticalDivider(
        color: Colors.white,
        thickness: 2,
      ));
}

Widget _getAmount(account_type, amount) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      Text(
        'Total\n in ' + account_type,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 15.sp, color: Colors.white),
      ),
      Text(
        amount,
        style: TextStyle(fontSize: 20.sp, color: Colors.white, height: 1.5),
      )
    ],
  );
}
