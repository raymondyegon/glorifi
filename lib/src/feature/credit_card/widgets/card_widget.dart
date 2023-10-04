import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glorifi/src/utils/glorifi_assets.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive_extensions.dart';

import '../../../font_style_global.dart';

class CardWidget extends StatelessWidget {
  const CardWidget(
      {Key? key,
      required this.color,
      required this.onTap,
      required this.cardHeading,
      required this.textColor,
      required this.cardDesc})
      : super(key: key);

  final Color color, textColor;
  final VoidCallback onTap;
  final cardHeading, cardDesc;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    GlorifiAssets.glorifiLogo,
                    width: 27,
                    height: 9,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    cardHeading,
                    style: captionSemiBold14Primary(
                      color: textColor,
                    ),
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 40.h,
                ),
                child: Text(
                  cardDesc,
                  textAlign: TextAlign.start,
                  style: headlineBold26Secondary(
                    color: textColor,
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Open Now",
                          style: captionSemiBold14Primary(
                            color: textColor,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        SvgPicture.asset(GlorifiAssets.arrowForward,
                            color: GlorifiColors.bloodOrange),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
