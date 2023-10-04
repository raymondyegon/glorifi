import 'package:flutter/material.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';

import '../../../../font_style_global.dart';
import '../../../../utils/glorifi_values.dart';

class VerifyingInformationWidget extends StatelessWidget {
  final String name;
  final String subtitle;

  const VerifyingInformationWidget({
    Key? key,
    required this.name,
    this.subtitle = "We are verifying your information.",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(GlorifiValues.smallPadding),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 70,
              height: 70,
              child: CircularProgressIndicator(
                color: GlorifiColors.bloodOrange,
                backgroundColor: GlorifiColors.white.withOpacity(0.1),
                strokeWidth: 10,
              ),
            ),
            SizedBox(height: GlorifiValues.largeMargin),
            Text(
              "Thanks, $name",
              style: headlineRegular31Secondary(
                color: GlorifiColors.white,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: GlorifiValues.margin),
            Text(
              subtitle,
              style: smallRegular16Primary(
                color: GlorifiColors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
