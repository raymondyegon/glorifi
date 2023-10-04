import 'package:flutter/material.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_sizing.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive.dart';

class Instruction extends StatelessWidget {
  final AdaptiveSizingInfo sizingInfo;

  const Instruction({
    Key? key,
    required this.sizingInfo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: sizingInfo.isWebMobile
              ? 24.h
              : sizingInfo.isNativeMobile
                  ? 24.h
                  : 64.h,
        ),
        Text(
          'Have a question? Message us and we\’ll get back to you quickly. We\’re here to help.',
          textAlign: TextAlign.start,
          style: smallRegular16Primary(color: GlorifiColors.midnightBlue),
        ),
      ],
    );
  }
}
