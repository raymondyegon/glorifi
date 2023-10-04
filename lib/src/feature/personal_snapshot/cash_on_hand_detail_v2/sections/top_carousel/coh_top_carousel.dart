import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/feature/personal_snapshot/cash_on_hand_detail_v2/cash_on_hand_controller.dart';
import 'package:glorifi/src/feature/personal_snapshot/cash_on_hand_detail_v2/sections/top_carousel/coh/card1.dart';
import 'package:glorifi/src/feature/personal_snapshot/cash_on_hand_detail_v2/sections/top_carousel/coh_v_networth/card2.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_sizing.dart';

class CohTopCarousel extends StatelessWidget {
  const CohTopCarousel({Key? key, required this.sizingInfo}) : super(key: key);

  final AdaptiveSizingInfo sizingInfo;

  @override
  Widget build(BuildContext context) {
    CashOnHandController cashOnHandController = Get.find();

    return Container(
      height: sizingInfo.isDesktop ? 610 : 410,
      color: Color(0xFF141B3F),
      child: CarouselSlider(
        options: CarouselOptions(
          // initialPage: controller.current.value,
          viewportFraction: 1,
          height: sizingInfo.isDesktop ? null : 420,
          autoPlay: false,
          enableInfiniteScroll: false,

          onPageChanged: (index, reason) {
            cashOnHandController.updateIndex(index);
          },
        ),
        items: [
          // Card 1
          Card1(sizingInfo: sizingInfo),
          // Card 2
          Card2(),
        ],
      ),
    );
  }
}
