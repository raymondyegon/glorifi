import 'package:flutter/material.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';

import '../../../font_style_global.dart';

class PullStampNote extends StatelessWidget {
  const PullStampNote({
    Key? key,
    required this.title,
    required this.subtitle,
    this.crossAxisAlignment = CrossAxisAlignment.start,
  }) : super(key: key);

  final String title;
  final String subtitle;
  final CrossAxisAlignment crossAxisAlignment;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: crossAxisAlignment,
            children: [
              Text(
                title,
                style: captionSemiBold14Primary()
                    .copyWith(color: GlorifiColors.midnightBlueColor),
              ),
              Text(
                subtitle,
                style: captionRegular14Primary()
                    .copyWith(color: GlorifiColors.midnightBlueColor),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
