// ignore_for_file: use_raw_strings

import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/feature/personal_snapshot/cash_on_hand_detail_v2/sections/savings_checkings_page/checking_savings_card.dart';
import 'package:glorifi/src/feature/personal_snapshot/cash_on_hand_detail_v2/sections/top_carousel/coh_top_carousel.dart';
import 'package:glorifi/src/feature/personal_snapshot/cash_on_hand_detail_v2/sections/loading_shimmer.dart';
import 'package:glorifi/src/feature/personal_snapshot/widgets/layout/layout.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_base_widget.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive.dart';
import 'package:intl/intl.dart';
import 'cash_on_hand_controller.dart';

class CashOnHandScreen extends GetView<CashOnHandController> {
  const CashOnHandScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(CashOnHandController());

    return AdaptiveBuilder(
      builder: (context, sizingInfo) {
        return Layout(
          titleMobile: "Cash On Hand",
          body: controller.obx(
            (state) => ContentCashOnHand(children: [
              sizingInfo.isDesktop ? titleDesktop("Cash on Hand") : SizedBox(),
              SizedBox(height: sizingInfo.isDesktop ? 46.h : 0),
              // Top Carousel with Graphs
              Container(
                color: GlorifiColors.blackBlue,
                child: containerDesktop(
                  CohTopCarousel(sizingInfo: sizingInfo),
                  sizingInfo: sizingInfo,
                ),
              ),
              containerDesktop(
                CardsCashOnHand(
                  controller: controller,
                ),
                sizingInfo: sizingInfo,
              ),
            ]),
            onLoading: LoadingShimmer(),
            onEmpty: Text("Items Empty"),
            onError: (error) => Text("Check Back Soon"),
          ),
        );
      },
    );
  }
}

class ContentCashOnHand extends StatelessWidget {
  const ContentCashOnHand({
    Key? key,
    required this.children,
  }) : super(key: key);

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomLeft,
          colors: [GlorifiColors.blackBlue, GlorifiColors.bgColor],
          stops: [0.5, 0.5],
        ),
      ),
      child: ListView(
        children: children,
      ),
    );
  }
}

class CardsCashOnHand extends StatelessWidget {
  const CardsCashOnHand({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final CashOnHandController controller;

  @override
  Widget build(BuildContext context) {
    //Get Todays Date And Format
    final DateTime todaysDate = DateTime.now();
    final DateFormat formatter = DateFormat('MMMM dd');
    final String dateFormatted = formatter.format(todaysDate);

    return Container(
      color: GlorifiColors.bgColor,
      child: Column(
        children: [
          // Bar Under Carousel
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.only(top: 22.h, bottom: 40.h),
            child: Obx(
              () => DotsIndicator(
                key: GlobalKey(),
                dotsCount: controller.cardNumber.value,
                position: controller.indexNumber.value.toDouble(),
                decorator: DotsDecorator(
                  spacing: EdgeInsets.only(left: 2, right: 2),
                  activeSize: const Size(25.0, 8.0),
                  activeShape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0)),
                  color: Colors.grey,
                  activeColor: Color(0xFF1A336F),
                ),
              ),
            ),
          ),

          //Total Savings Balance Card
          Obx(
            () => CheckingSavingsCard(
              type: "checking",
              isLoading: controller.loading.value,
            ),
          ),

          //Total Checking Balance Card
          Obx(
            () => CheckingSavingsCard(
              type: "savings",
              isLoading: controller.loading.value,
            ),
          ),

          //Date Updated
          Padding(
            padding: const EdgeInsets.only(
              bottom: 5.0,
              top: 15,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "As of ",
                  style: tinyRegular10Primary(color: Color(0xFF535F75)),
                ),
                Text(
                  dateFormatted,
                  style: xSmallBold12Primary(color: Color(0xFF535F75)),
                ),
                Text(
                  " (Pull every day)",
                  style: tinyRegular10Primary(color: Color(0xFF535F75)),
                )
              ],
            ),
          ),
          //Carousel
          // CohBottomCarousel(),
        ],
      ),
    );
  }
}
