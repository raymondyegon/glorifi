import 'package:flutter/material.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive_extensions.dart';

class BankingFinanceTile extends StatelessWidget {
  const BankingFinanceTile(
      {Key? key,
      this.onTap,
      required this.title,
      required this.subTitle,
      this.isMobile = false,
      this.isVerified = false})
      : super(key: key);

  final VoidCallback? onTap;
  final String title, subTitle;
  final bool isVerified, isMobile;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          textAlign: TextAlign.start,
          style: isMobile
              ? smallRegular16Primary(color: GlorifiColors.hintColor)
              : bodyBold18Primary(color: GlorifiColors.cornflowerBlue),
        ),
        InkWell(
          onTap: onTap,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                subTitle,
                style:
                    smallSemiBold16Primary(color: GlorifiColors.cornflowerBlue),
              ),
              if (!isVerified)
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 5.w,
                    ),
                    Icon(
                      Icons.error_outline,
                      size: 10,
                      color: GlorifiColors.redError,
                    ),
                  ],
                ),
            ],
          ),
        )
      ],
    );
  }
}
