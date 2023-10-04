import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/feature/cockpit/feed2.0/snapshot/sections/carousel/cards/plain_cards/add_address_card.dart';
import 'package:glorifi/src/feature/cockpit/feed2.0/snapshot/sections/carousel/cards/graph_cards/cash_on_hand_card.dart';
import 'package:glorifi/src/feature/cockpit/feed2.0/snapshot/sections/carousel/cards/plain_cards/complete_profile_card.dart';
import 'package:glorifi/src/feature/cockpit/feed2.0/snapshot/sections/carousel/cards/graph_cards/credit_score_detail_card.dart';
import 'package:glorifi/src/feature/cockpit/feed2.0/snapshot/sections/carousel/cards/plain_cards/get_credit_score_card.dart';
import 'package:glorifi/src/feature/cockpit/feed2.0/snapshot/sections/carousel/cards/graph_cards/home_value_card.dart';
import 'package:glorifi/src/feature/cockpit/feed2.0/snapshot/sections/carousel/cards/plain_cards/link_account_card.dart';
import 'package:glorifi/src/feature/cockpit/feed2.0/snapshot/sections/carousel/cards/link_more_accounts_card/link_more_accounts_card.dart';
import 'package:glorifi/src/feature/cockpit/feed2.0/snapshot/sections/carousel/cards/graph_cards/retirement_card.dart';
import 'package:glorifi/src/feature/cockpit/feed2.0/snapshot/sections/carousel/cards/graph_cards/total_debt_card.dart';
import 'package:glorifi/src/feature/cockpit/feed2.0/snapshot/sections/carousel/snapshot_carousel_controller.dart';
import 'package:glorifi/src/feature/cockpit/feed2.0/snapshot/sections/snapshot_widget/snapshot_widget.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_base_widget.dart';
import 'package:glorifi/src/utils/glorifi_assets.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive_extensions.dart';
import 'package:glorifi/src/widgets/loading/shimmer.dart';

import 'cards/graph_cards/net_worth_card.dart';

class SnapshotCarousel extends GetView<SnapshotCarouselController> {
  const SnapshotCarousel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final SnapshotCarouselController controller =
        Get.put(SnapshotCarouselController());

    return AdaptiveBuilder(builder: (context, sizingInfo) {
      return StatefulWrapper(
        onInit: controller.onInit,
        child: Obx(() {
          if (controller.accountFlagsController.error.isTrue &&
              !controller.isLoading) {
            return Container();
          } else {
            WidgetsBinding.instance?.addPostFrameCallback((_) {
              controller.setCards();
            });
          }

          final double _height = sizingInfo.isDesktop ? 339 : 484;

          if (sizingInfo.isDesktop || sizingInfo.isTablet) {
            return Container(
              height: _height,
              child: controller.isLoading
                  ? Container(
                      width: double.infinity,
                      child: ShimmeryPlaceHolder(
                        radius: 8,
                      ),
                    )
                  : Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (controller.cards.length == 1)
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                color: GlorifiColors.white,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(8),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    offset: Offset(0, 0),
                                    color: Colors.black.withOpacity(0.1),
                                    blurRadius: 55,
                                  ),
                                ],
                              ),
                              width: double.infinity,
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: _getCard(controller.cards[0])),
                            ),
                          ),
                        if (controller.cards.length > 1)
                          Expanded(
                            child: ScrollConfiguration(
                              behavior: MaterialScrollBehavior().copyWith(
                                dragDevices: {
                                  PointerDeviceKind.mouse,
                                  PointerDeviceKind.touch,
                                  PointerDeviceKind.stylus,
                                  PointerDeviceKind.unknown
                                },
                              ),
                              child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: GlorifiColors.white,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(8),
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      offset: Offset(0, 0),
                                      color: Colors.black.withOpacity(0.1),
                                      blurRadius: 0,
                                    ),
                                  ],
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: CarouselSlider(
                                    carouselController:
                                        controller.carouselController,
                                    options: CarouselOptions(
                                      initialPage: controller.current.value,
                                      viewportFraction: 1,
                                      autoPlay: false,
                                      enableInfiniteScroll: false,
                                      onPageChanged: (index, reason) {
                                        controller.onPageChanged(index, reason);
                                      },
                                    ),
                                    items:
                                        controller.cards.map(_getCard).toList(),
                                  ),
                                ),
                              ),
                            ),
                          ),

                        // PROGRESS INDICATOR
                        if (controller.cards.length > 1)
                          Container(
                            width: 400,
                            height: 80,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconButton(
                                  onPressed: controller
                                      .carouselController.previousPage,
                                  icon: SvgPicture.asset(
                                    GlorifiAssets.behindArrow,
                                    color: GlorifiColors.silver,
                                    height: 36,
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  child: DotsIndicator(
                                    dotsCount: controller.cards.length,
                                    position: controller.current.value
                                                .toDouble() >
                                            controller.cards.length - 1
                                        ? controller.cards.length - 1
                                        : controller.current.value.toDouble(),
                                    decorator: DotsDecorator(
                                      spacing:
                                          EdgeInsets.only(left: 4, right: 4),
                                      size: const Size.square(8.0),
                                      activeSize: const Size(25.0, 8.0),
                                      activeShape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5.0)),
                                      color: Colors.grey,
                                      activeColor:
                                          GlorifiColors.blueMidnightBlue,
                                    ),
                                  ),
                                ),
                                IconButton(
                                  onPressed:
                                      controller.carouselController.nextPage,
                                  icon: SvgPicture.asset(
                                      GlorifiAssets.nextArrow,
                                      color: GlorifiColors.silver,
                                      height: 36),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
            );
          } else {
            return controller.cards.length == 0 && !controller.isLoading
                ? Container()
                : Container(
                    margin: EdgeInsets.only(
                        bottom: controller.cards.length == 1 ? 0 : 22),
                    height: 310,
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Positioned(
                          top: -50,
                          left: 0,
                          right: 0,
                          child: controller.isLoading
                              ? Container(
                                  height: 395,
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 55),
                                  child: Center(
                                    child: Container(
                                      width: Get.width * 0.9,
                                      decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                            offset: Offset(0, 0),
                                            color:
                                                Colors.black.withOpacity(0.1),
                                            blurRadius: 55,
                                          ),
                                        ],
                                      ),
                                      child: ShimmeryPlaceHolder(
                                        radius: 8,
                                      ),
                                    ),
                                  ),
                                )
                              : Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    if (controller.cards.length == 1)
                                      Container(
                                        width: double.infinity,
                                        height: 395,
                                        margin: EdgeInsets.fromLTRB(
                                            16.w, 0, 16.w, 0),
                                        child: _getCard(controller.cards[0]),
                                      ),
                                    if (controller.cards.length > 1)
                                      ScrollConfiguration(
                                        behavior:
                                            MaterialScrollBehavior().copyWith(
                                          dragDevices: {
                                            PointerDeviceKind.mouse,
                                            PointerDeviceKind.touch,
                                            PointerDeviceKind.stylus,
                                            PointerDeviceKind.unknown
                                          },
                                        ),
                                        child: CarouselSlider(
                                          options: CarouselOptions(
                                            initialPage:
                                                controller.current.value,
                                            height: 395,
                                            viewportFraction: .90,
                                            autoPlay: false,
                                            enableInfiniteScroll: false,
                                            onPageChanged: (index, reason) {
                                              controller.onPageChanged(
                                                  index, reason);
                                            },
                                          ),
                                          items: controller.cards
                                              .map(_getCard)
                                              .toList(),
                                        ),
                                      ),
                                  ],
                                ),
                        ),
                        // PROGRESS INDICATOR
                        if (controller.cards.length > 1 &&
                            !controller.isLoading)
                          Positioned(
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                DotsIndicator(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  dotsCount: controller.cards.length,
                                  position:
                                      controller.current.value.toDouble() >
                                              controller.cards.length - 1
                                          ? controller.cards.length - 1
                                          : controller.current.value.toDouble(),
                                  decorator: DotsDecorator(
                                    spacing: EdgeInsets.only(left: 2, right: 2),
                                    shape: CircleBorder(),
                                    activeShape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(8))),
                                    size: Size(8, 8),
                                    activeSize: Size(25, 8),
                                    color: GlorifiColors.carouselIndicatorGrey,
                                    activeColor:
                                        GlorifiColors.darkBlueTint[500],
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  );
          }
        }),
      );
    });
  }

  Widget _getCard(CarouselCardType type) {
    switch (type) {
      case CarouselCardType.LinkAccounts:
        return LinkAccountCard();
      case CarouselCardType.LinkMoreAccounts:
        return LinkMoreAccounts();
      case CarouselCardType.EnableCreditScore:
        return GetCreditScoreCard();
      case CarouselCardType.CreditScoreDetail:
        return CreditScoreDetailCard();
      case CarouselCardType.Address:
        return AddAddressCard();
      case CarouselCardType.CompleteProfile:
        return CompleteProfileCard();
      case CarouselCardType.HomeValue:
        return HomeValueCard();
      case CarouselCardType.NetWorth:
        return NetWorthCard();
      case CarouselCardType.Retirement:
        return RetirementCard();
      case CarouselCardType.CashOnHand:
        return CashOnHandCard();
      case CarouselCardType.TotalDebt:
        return TotalDebtCard();
    }
  }
}
