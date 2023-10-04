import 'package:flutter/material.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/number_format_util.dart';

import '../../../font_style_global.dart';

class AmountWithDescription extends StatelessWidget {
  const AmountWithDescription(
      {Key? key, required this.amount, this.description})
      : super(key: key);

  final double amount;
  final String? description;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Text(
                '${amount < 0 ? '-' : ''}${amount.abs().round().formatSimpleCurrencyWithDynamicInt()}',
                style: headlineBold31Secondary().copyWith(
                  letterSpacing: 1,
                ),
              ),
            ),
          ],
        ),
        if (description != null)
          Text(
            description!,
            style: captionSemiBold14Primary(
              color: GlorifiColors.midnightBlueColor,
            ),
          ),
      ],
    );
  }
}
