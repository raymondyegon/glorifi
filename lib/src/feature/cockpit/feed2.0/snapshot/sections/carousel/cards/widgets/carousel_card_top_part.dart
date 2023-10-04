import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';

class CarouselCardTopPart extends StatelessWidget {
  final String? title;
  final String? description;
  final String svg;
  final Color svgColor;
  final Widget? customContent;

  const CarouselCardTopPart({
    Key? key,
    this.title,
    this.description,
    this.customContent,
    required this.svg,
    this.svgColor = GlorifiColors.blueFocusedItem,
  })  : assert(title != null && description != null || customContent != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return customContent != null
        ? customContent!
        : Container(
            width: double.maxFinite,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 48,
                  width: 48,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: GlorifiColors.lightBlueBg,
                  ),
                  child: Center(
                    child: SvgPicture.asset(
                      svg,
                      color: svgColor,
                      height: 24,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  title!,
                  textScaleFactor: 1,
                  style: headlineSemiBold20Primary(
                    color: GlorifiColors.almostBlack,
                  ),
                ),
                SizedBox(height: 6),
                Expanded(
                  child: Text(
                    description!,
                    textScaleFactor: 1,
                    style: captionSemiBold14Primary(
                      color: GlorifiColors.ebonyBlue,
                    ),
                  ),
                ),
              ],
            ),
          );
  }
}
