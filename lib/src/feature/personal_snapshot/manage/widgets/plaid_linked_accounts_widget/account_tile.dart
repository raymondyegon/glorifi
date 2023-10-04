import 'package:flutter/material.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive_extensions.dart';

import '../../../../../font_style_global.dart';

class AccountTile extends StatelessWidget {
  const AccountTile({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.onTap,
  }) : super(key: key);

  final String title;
  final String subtitle;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          horizontal: 14.w,
          vertical: 24.h,
        ),
        decoration: BoxDecoration(
          color: GlorifiColors.white,
          border: Border(
            bottom: BorderSide(
              color: GlorifiColors.greyD8,
            ),
          ),
        ),
        child: Row(children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: smallBold16Primary(
                    color: GlorifiColors.blueMidnightBlue,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  subtitle,
                  style: xSmallRegular12Primary(
                    color: GlorifiColors.blueMidnightBlue,
                  ),
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
