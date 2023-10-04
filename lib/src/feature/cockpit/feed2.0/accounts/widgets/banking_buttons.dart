import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive_extensions.dart';

class BankingButton extends StatelessWidget {
  final String asset;

  final VoidCallback onTap;
  final bool isDisabled;
  final String text;

  const BankingButton(
      {Key? key,
      required this.text,
      required this.onTap,
      required this.asset,
      required this.isDisabled})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isDisabled ? () {} : onTap,
      child: Column(
        children: [
          SvgPicture.asset(
            asset,
            color: isDisabled ? GlorifiColors.altoGrey : GlorifiColors.darkBlue,
          ),
          SizedBox(
            height: 5.h,
          ),
          Text(
            text,
            style: captionBold14Primary(
                color: isDisabled
                    ? GlorifiColors.altoGrey
                    : GlorifiColors.darkBlue),
          )
        ],
      ),
    );
  }
}
