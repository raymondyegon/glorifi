import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/widget_extensions.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive_extensions.dart';

class ContactSupportFooter extends StatelessWidget {
  final String? scheduleHours;
  const ContactSupportFooter({Key? key, this.scheduleHours}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Hours of Operation',
          style: headlineBold21Primary(
            color: GlorifiColors.darkBlue,
          ),
        ).paddingOnly(
          bottom: 16.h,
        ),
        RichText(
          text: TextSpan(
            text: 'Our Support agents are available\n',
            style: bodySemiBold18Primary(
              color: GlorifiColors.midnightBlue,
            ),
            children: <InlineSpan>[
              TextSpan(
                text: scheduleHours,
                style: smallRegular16Primary(
                  color: GlorifiColors.midnightBlue,
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
