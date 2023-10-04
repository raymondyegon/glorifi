import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/feature/cockpit/feed2.0/accounts/controller/accounts_controller.dart';
import 'package:glorifi/src/feature/onboard/value/widget/value_pager_indicator.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive_extensions.dart';

class ComingSoonCarousel extends GetView<AccountsController> {
  final List<Widget> children;
  final selectedIndex;

  const ComingSoonCarousel({
    Key? key,
    required this.children,
    required this.selectedIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Coming Soon',
          style: font22W700Font(color: GlorifiColors.midnightBlue),
        ).paddingSymmetric(
          vertical: 8.h,
        ),
        Text(
          'Be first to know about our newest products',
          style: captionSemiBold14Primary(
            color: GlorifiColors.darkGrey80,
          ),
        ).paddingOnly(
          bottom: 30.h,
        ),
        CarouselSlider(
          options: CarouselOptions(
            height: 400,
            initialPage: selectedIndex,
            autoPlay: false,
            enableInfiniteScroll: false,
            onPageChanged: (index, reason) {
              controller.comingSoonIndex.value = index;
            },
          ),
          items: children,
        ),
        if (children.length > 1)
          ValuePagerIndicator(
            pageCount: children.length,
            currentIndex: selectedIndex,
          ).paddingOnly(
            top: 42,
          ),
      ],
    );
  }
}
