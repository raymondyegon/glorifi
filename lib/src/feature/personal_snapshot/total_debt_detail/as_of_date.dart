import 'package:flutter/widgets.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:intl/intl.dart';

class AsOfDate extends StatelessWidget {
  final DateTime date;
  static final _formatter = DateFormat('MMMM dd');
  const AsOfDate({Key? key, required this.date}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "As of ",
          style: tinyRegular10Primary(color: Color(0xFF535F75)),
        ),
        Text(
          _formatter.format(date),
          style: xSmallBold12Primary(color: Color(0xFF535F75)),
        ),
        Text(
          " (updates daily)",
          style: tinyRegular10Primary(color: Color(0xFF535F75)),
        )
      ],
    );
  }
}
