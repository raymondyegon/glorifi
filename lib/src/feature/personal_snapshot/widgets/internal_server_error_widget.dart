import 'package:flutter/material.dart';
import 'package:glorifi/src/feature/personal_snapshot/home_value/common_widget.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive_extensions.dart';

class InternalServerErrorWidget extends StatelessWidget {
  const InternalServerErrorWidget({
    required this.onTap,
    Key? key,
  }) : super(key: key);

  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          '500 Error',
          style: headlineRegular31Secondary(
            color: GlorifiColors.darkBlue,
          ),
        ),
        SizedBox(height: 24.h),
        Text(
          'Sorry something is broken',
          style: bodyBold18Primary(
            color: GlorifiColors.midnightBlueColor,
          ),
        ),
        SizedBox(height: 16.h),
        Text(
          'But here is a fun fact: George Washington never actually had wooden teeth. He wore dentures made from other materials including ivory, gold, lead, and even animal and human teeth.',
          textAlign: TextAlign.center,
          style: smallRegular16Primary(
            color: GlorifiColors.midnightBlueColor,
          ),
        ),
        SizedBox(height: 50.h),
        glorifiButton(
          text: 'Retry',
          onTap: onTap ?? () => {},
        ),
      ],
    );
  }
}
