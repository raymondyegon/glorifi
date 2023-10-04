import 'package:flutter/material.dart';
import 'package:glorifi/src/feature/personal_snapshot/widgets/amount_with_description.dart';

import '../../../font_style_global.dart';

class TextStatistics extends StatelessWidget {
  TextStatistics({
    this.amount,
    required this.description,
    this.amountSubtitle = 'Across All Linked Accounts',
    Key? key,
  }) : super(key: key);

  final double? amount;
  final String description;
  final String? amountSubtitle;

  @override
  Widget build(BuildContext context) {
    return amount != null
        ? AmountWithDescription(
            amount: amount!,
            description: amountSubtitle,
          )
        : TextDescription(
            content: description,
          );
  }
}

class TextPoints extends StatelessWidget {
  const TextPoints({
    required this.value,
    required this.text,
    required this.description,
    Key? key,
  }) : super(key: key);

  final String value;
  final String text;
  final String description;

  @override
  Widget build(BuildContext context) {
    return value.isNotEmpty
        ? Row(
            children: [
              Text(
                value,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 31,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(width: 50),
              ElevatedButton(
                onPressed: () => {},
                child: Text(
                  text,
                  style: TextStyle(
                    color: Color(0xff212C37),
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                  side: BorderSide(
                    width: 1,
                    color: Colors.black,
                  ),
                  shadowColor: Colors.transparent,
                ),
              ),
            ],
          )
        : TextDescription(
            content: description,
          );
  }
}

class TextDescription extends StatelessWidget {
  const TextDescription({
    required this.content,
    Key? key,
  }) : super(key: key);

  final String content;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          child: Text(
            content,
            style: smallRegular16Primary(),
          ),
        ),
      ],
    );
  }
}
