import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/feature/cockpit/feed2.0/snapshot/snapshot_controller.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/routes/app_pages.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/widgets/tap/ripple.dart';
import 'package:intl/intl.dart';
import '../widgets/carousel_card_top_part.dart';
import '../widgets/snapshot_carousel_card.dart';

class CashOnHandCard extends StatelessWidget {
  const CashOnHandCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final snapshotController = Get.find<SnapshotController>();
    return Ripple(
      onTap: () => Get.toNamed(Routes.cashOnHand),
      child: SnapshotCarouselCard(
        isGraph: true,
        topPart: CarouselCardTopPart(
          svg: '',
          customContent: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 35.0),
                child: Center(
                  child: Text("Total Cash On Hand",
                      style: captionRegular14Primary(color: Color(0xFFF0F4FB))),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: Center(
                  child: Text(
                      "\$${NumberFormat.decimalPattern().format(snapshotController.currentCashOnHand).toString()}",
                      style: headlineBold52Secondary(color: Color(0xFFFFFFFF))
                          .copyWith(fontSize: 56)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 0.0, right: 0, top: 21),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Container(
                          width: 35,
                          height: 5,
                          decoration: BoxDecoration(
                            color: Color(0xFFC2D1EF),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ).paddingOnly(bottom: 11),
                        Text(
                          "Savings",
                          style: smallBold11Primary(color: Color(0xFFD0D8E7)),
                        ).paddingOnly(bottom: 4),
                        Text(
                          "\$${snapshotController.cashOnHandController.totalSavingsAmount.toString()}",
                          style: smallBold16Secondary(color: GlorifiColors.white),
                        ),
                      ],
                    ),
                    SizedBox(width: 60),
                    Column(
                      children: [
                        Container(
                          width: 35,
                          height: 5,
                          decoration: BoxDecoration(
                            color: Color(0xFF6490E8),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ).paddingOnly(bottom: 11),
                        Text(
                          "Checking",
                          style: smallBold11Primary(color: Color(0xFFD0D8E7)),
                        ).paddingOnly(bottom: 4),
                        Text(
                            "\$${snapshotController.cashOnHandController.totalCheckingAmount.toString()}",
                            style: smallBold16Secondary(color: Colors.white)),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
