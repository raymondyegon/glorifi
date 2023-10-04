// ignore_for_file: use_raw_strings

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../personal_snapshot/total_debt_detail/total_debt_controller.dart';
import '../../../snapshot_controller.dart';
import 'widgets/carousel_card_top_part.dart';
import 'widgets/snapshot_carousel_card.dart';

class TotalDebtCard extends StatelessWidget {
  const TotalDebtCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final snapshotController = Get.find<SnapshotController>();
    return SnapshotCarouselCard(
      isGraph: true,
      topPart: _drawGridLines(
        child: CarouselCardTopPart(
          svg: '',
          customContent: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Total Debt",
                  style: TextStyle(
                    color: Color(0xFFF0F4FB),
                    fontSize: 13.25,
                    fontFamily: "OpenSans",
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 4,
                    bottom: 4,
                  ),
                  child: Text(
                    "\$${snapshotController.currentDebt.toString()}",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontFamily: "univers",
                      fontSize: 45,
                    ),
                  ),
                ),
                Text(
                  "\$9K Balance Increase",
                  style: TextStyle(
                    color: Color(0xFFFA3E3E),
                    fontFamily: "OpenSans",
                    fontWeight: FontWeight.w700,
                    fontSize: 13.25,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

_drawGridLines({double space = 30, required Widget child}) {
  return LayoutBuilder(
    builder: (BuildContext context, BoxConstraints constraints) {
      double width = constraints.maxWidth;
      double height = constraints.maxHeight;
      const dashWidth = 10.0;
      final dashCount = (width / (2 * dashWidth)).floor();
      var v = Container(
        width: width,
        height: 2,
        color: Color(0xFF444E60).withOpacity(.5),
      );
      return Stack(children: <Widget>[
        ...List.generate((height / space).round(),
            (index) => Positioned(top: index * space, child: v)),
        child,
      ]);
    },
  );
}
