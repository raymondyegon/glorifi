import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/glorifi_values.dart';

import '../../../../font_style_global.dart';

class VerifiedWidget extends StatelessWidget {
  const VerifiedWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            'assets/images/glorifi_logo/brand_mark_bg.svg',
            width: 200,
          ),
          SizedBox(height: GlorifiValues.margin_32),
          Text(
            "Verified",
            style: headlineRegular31Secondary(
              color: GlorifiColors.white,
            ),
          )
        ],
      ),
    );
  }
}
