import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/feature/cockpit/feed2.0/snapshot/sections/carousel/cards/widgets/carousel_card_top_part.dart';
import 'package:glorifi/src/feature/cockpit/feed2.0/snapshot/sections/carousel/cards/widgets/snapshot_carousel_card.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/utils/glorifi_assets.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/widgets/tap/ripple.dart';

import 'draw_dotted_horizontal_line.dart';

class GraphWithCurvedLineCard extends StatelessWidget {
  GraphWithCurvedLineCard({
    Key? key,
    required this.routeName,
    required this.title,
    required this.amount,
    required this.subtitle,
    required this.subtitleColor,
  }) : super(key: key);

  final String routeName;
  final String title;
  final String amount;
  final String subtitle;
  final Color subtitleColor;

  @override
  Widget build(BuildContext context) {
    return Ripple(
      onTap: () => Get.toNamed(routeName),
      child: SnapshotCarouselCard(
        isGraph: true,
        topPart: _drawGridLines(
          child: CarouselCardTopPart(
            svg: '',
            customContent: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: captionRegular14Primary(color: Color(0xFFF0F4FB)).copyWith(fontSize: 13),
                  ).paddingOnly(top: 20),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 4,
                      bottom: 4,
                    ),
                    child: Text(
                      "\$$amount",
                      style: headlineBold52Secondary(color: GlorifiColors.white)
                          .copyWith(fontSize: 45),
                    ),
                  ),
                  Text(subtitle,
                      style: captionBold14Primary(color: subtitleColor)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Widget _drawGridLines({double space = 30, required Widget child}) {
  return LayoutBuilder(
    builder: (BuildContext context, BoxConstraints constraints) {
      double width = constraints.maxWidth;
      const dashWidth = 10.0;
      final dashCount = (width / (2 * dashWidth)).floor();

      return Stack(children: <Widget>[
        ...List.generate(
          dashCount,
          (index) => Positioned(
            top: index * space,
            child: Container(
              width: width,
              child: Center(
                child: CustomPaint(painter: DrawDottedHorizontalLine(index),),
              ),
            ),
          ),
        ),
        child,
        Positioned(
          left: 0,
          bottom: 0,
          child: SvgPicture.asset(
            GlorifiAssets.curvedLine,
            color: Color(0xFF6490E7),
          ),
        ),
        Positioned(
          left: 190,
          bottom: 55,
          child: Container(
            width: 15.0,
            height: 15.0,
            decoration: BoxDecoration(
                color: Color(0xFF6490E7),
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 2)),
          ),
        ),
      ]);
    },
  );
}
