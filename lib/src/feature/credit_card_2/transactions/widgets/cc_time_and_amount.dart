import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:intl/intl.dart';

class CCTimeAndAmount extends StatelessWidget {
  const CCTimeAndAmount({
    Key? key,
    required this.time,
    required this.status,
    required this.amount,
    required this.date,
  }) : super(key: key);

  final String date;
  final String time;
  final String status;
  final double amount;

  @override
  Widget build(BuildContext context) {
    // ignore: use_raw_strings
    final usCurrency = NumberFormat("\$#,##0.00", "en_US");
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  date,
                  style: captionRegular14Primary(color: GlorifiColors.darkBlue),
                ),
                Text(
                  "·",
                  style: captionRegular14Primary(color: GlorifiColors.darkBlue),
                ),
                Text(
                  time,
                  style: captionRegular14Primary(color: GlorifiColors.darkBlue),
                )
              ],
            ),
            SizedBox(
              height: 8.0,
            ),
            Text(
              status == "pending" ? "Pending" : "",
              style: TextStyle(
                fontSize: 14, // Purposefully note added sp
                fontWeight: FontWeight.w600,
                fontStyle: FontStyle.italic,
                fontFamily: "OpenSans",
                color: GlorifiColors.darkBlue,
              ),
            ),
          ],
        ),
        Spacer(),
        Row(
          textBaseline: TextBaseline.alphabetic,
          crossAxisAlignment: CrossAxisAlignment.baseline,
          children: [
            // Text(
            //   "\$",
            //   style:
            //       headlineSemiBold26Primary(color: GlorifiColors.darkBlueColor),
            // ),
            Text(
              usCurrency.format(amount),
              style: headlineSemiBold37Primary(color: GlorifiColors.darkBlue),
            )
          ],
        )
      ],
    );
  }
}
