import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_sizing.dart';
import 'package:glorifi/src/utils/glorifi_assets.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive_extensions.dart';
import 'package:glorifi/src/widgets/tap/ripple.dart';

class LegalItemView extends StatelessWidget {
  final String title;
  final bool isLastElement;
  final Color titleColor;
  final Color arrowColor;
  final AdaptiveSizingInfo sizingInfo;
  final Function()? onTap;

  const LegalItemView({
    Key? key,
    required this.title,
    required this.isLastElement,
    this.titleColor = GlorifiColors.textColor,
    this.arrowColor = GlorifiColors.biscayBlue,
    required this.sizingInfo,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Ripple(
          onTap: onTap,
          child: Container(
            padding: EdgeInsets.only(
              top: 10.h,
              bottom: !isLastElement ? 11.h : 0,
            ),
            margin: EdgeInsets.zero,
            child: Row(
              children: [
                Text(title, style: smallRegular16Primary(color: titleColor)),
                Spacer(),
                Padding(
                  padding: EdgeInsets.only(
                    right: sizingInfo.isDesktop ? 3.w : 10.w,
                  ),
                  child: SvgPicture.asset(
                    GlorifiAssets.forwardArrow,
                    height: 10.h,
                    width: 10.w,
                    fit: BoxFit.cover,
                    color: arrowColor,
                  ),
                ),
              ],
            ),
          ),
        ),
        !isLastElement
            ? Divider(height: 1, color: GlorifiColors.altoGrey)
            : SizedBox(),
      ],
    );
  }
}
