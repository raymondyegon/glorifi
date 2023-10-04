import 'package:flutter/material.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_sizing.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive_extensions.dart';

import 'benefit_item.dart';

class YourBenefit extends StatelessWidget {
  final List<String> benefits;
  final AdaptiveSizingInfo sizingInfo;

  const YourBenefit({
    Key? key,
    required this.benefits,
    required this.sizingInfo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Your Benefits",
          style: (sizingInfo.isNativeMobile || sizingInfo.isWebMobile)
              ? bodyBold18Secondary(color: GlorifiColors.superLightGrey)
              : headlineBold21Secondary(
                  color: GlorifiColors.superLightGrey,
                ),
        ),
        SizedBox(
          height: 32.h,
        ),
        ...List.generate(
          benefits.length,
          (index) => BenefitItem(
            sizingInfo: sizingInfo,
            title: benefits[index],
          ),
        ),
      ],
    );
  }
}
