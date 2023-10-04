import 'package:flutter/material.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';

import '../../../../font_style_global.dart';

class MarketingCard extends StatelessWidget {
  const MarketingCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 12),
              Text('MARKETING', style: _getTitleStyle()),
              const SizedBox(height: 12),
              Text(
                'If you would like to unsubscribe, do so from the email',
                style: _getDescriptionTextStyle(),
              ),
              const SizedBox(height: 36),
            ],
          ),
        ),
      ),
    );
  }

  TextStyle _getTitleStyle() => captionBold14Primary(
        color: GlorifiColors.darkBlue,
      );

  TextStyle _getDescriptionTextStyle() => smallRegular16Primary(
        color: GlorifiColors.darkBlue,
      );
}
