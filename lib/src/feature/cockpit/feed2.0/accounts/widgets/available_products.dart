import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/feature/cockpit/feed2.0/accounts/controller/accounts_controller.dart';
import 'package:glorifi/src/feature/onboard/value/widget/value_pager_indicator.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_sizing.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive_extensions.dart';

class AvailableProducts extends GetView<AccountsController> {
  final AdaptiveSizingInfo sizingInfo;
  final selectedIndex;
  final List<Widget> children;

  const AvailableProducts({
    Key? key,
    required this.sizingInfo,
    required this.selectedIndex,
    required this.children,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: sizingInfo.isDesktop ? 24.h : 32.h),
        Text(
          'Available Products',
          style: font22W700Font(
            color: GlorifiColors.midnightBlue,
          ),
        ),
        Text(
          'Best-in-class products, made just for you.',
          style: captionSemiBold14Primary(
            color: GlorifiColors.darkGrey80,
          ),
        ).paddingSymmetric(
          vertical: 12.h,
        ),
        CarouselSlider(
          options: CarouselOptions(
            height: 400,
            initialPage: selectedIndex,
            autoPlay: false,
            enableInfiniteScroll: false,
            onPageChanged: (index, reason) {
              controller.availableProductsIndex.value = index;
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
            bottom: 27.h,
          ),
      ],
    ).paddingOnly(
      left: sizingInfo.isDesktop || sizingInfo.isTablet ? 12.w : 0,
    );
  }
}
