import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive.dart';

import 'benefits.dart';

class SimpleCreditCardBenefits extends StatelessWidget {
  final List<String> benefits;
  final Color textColor;
  final Color iconColor;

  const SimpleCreditCardBenefits({
    required this.benefits,
    this.textColor = GlorifiColors.darkBlue,
    this.iconColor = GlorifiColors.darkBlue,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ...List.generate(
          benefits.length,
          (index) => Benefits(
            benefit: benefits[index],
            textColor: textColor,
            iconColor: iconColor,
          ).marginOnly(
            bottom: 8.h,
          ),
        )
      ],
    );
  }
}
