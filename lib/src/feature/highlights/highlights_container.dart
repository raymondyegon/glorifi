import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:glorifi/src/feature/highlights/highlight_controller.dart';
import 'package:glorifi/src/feature/highlights/highlight_model.dart';
import 'package:glorifi/src/feature/highlights/types/bank_account_highlight.dart';
import 'package:glorifi/src/feature/highlights/types/base_highlight.dart';
import 'package:glorifi/src/feature/highlights/types/credit_score_highlight.dart';
import 'package:glorifi/src/feature/highlights/types/standard_highlight.dart';
import 'package:glorifi/src/widgets/loading/shimmer.dart';
import 'package:glorifi/src/feature/onboard/value/widget/value_pager_indicator.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_base_widget.dart';
import 'package:glorifi/src/utils/glorifi_assets.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive.dart';

class HighlightContainer extends GetView<HighlightController> {
  const HighlightContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget _highlightCard(int pagePosition, {isFirst: true}) {
      int index = isFirst ? pagePosition * 2 : pagePosition * 2 + 1;
      Widget child;

      if (controller.showPlaceHolders) {
        child = ShimmeryPlaceHolder(
          radius: CARD_RADIUS,
        );
      } else if (index >= controller.count) {
        // there is an odd number of cards so add invisible card
        child = SizedBox.shrink();
      } else {
        // we store two cards on each PageView
        child = _cardForHighlight(controller.getHighlightByIndex(index));
      }

      return Container(width: .44.sw, child: child);
    }

    Widget _mobileNative = Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
              height: 256.h,
              width: 1.sw,
              child: Obx(() => PageView.builder(
                  itemCount:
                      controller.showPlaceHolders ? 1 : controller.numPages,
                  onPageChanged: (index) {
                    controller.current.value = index;
                  },
                  pageSnapping: true,
                  itemBuilder: (context, pagePosition) {
                    return Container(
                      padding: EdgeInsets.symmetric(vertical: .02.sw),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _highlightCard(pagePosition),
                            _highlightCard(pagePosition, isFirst: false),
                          ]),
                    );
                  }))),
          Obx(() => controller.loadingComplete
              ? Padding(
                  padding: EdgeInsets.only(left: 0.1.sw, top: 20.h),
                  child: ValuePagerIndicator(
                    pageCount: controller.numPages,
                    currentIndex: controller.current.value,
                    center: false,
                  ))
              : SizedBox(
                  height: 10.h,
                ))
        ]);

    /// Widgets
    Widget _rightArrow = InkWell(
      onTap: () {
        controller.carouselController.previousPage();
      },
      child: Container(
        height: 40.h,
        width: 40.w,
        padding: EdgeInsets.all(12.sp),
        decoration: BoxDecoration(
          color: GlorifiColors.white,
          shape: BoxShape.circle,
        ),
        child: SvgPicture.asset(GlorifiAssets.rightArrow),
      ),
    );
    Widget _leftArrow = InkWell(
      onTap: () {
        controller.carouselController.nextPage();
      },
      child: Container(
        height: 40.h,
        width: 40.w,
        padding: EdgeInsets.all(12.sp),
        decoration: BoxDecoration(
          color: GlorifiColors.white,
          shape: BoxShape.circle,
        ),
        child: RotatedBox(
          quarterTurns: 2,
          child: SvgPicture.asset(GlorifiAssets.rightArrow),
        ),
      ),
    );

    return AdaptiveBuilder(builder: (context, sizingInfo) {
      if (kIsWeb && sizingInfo.screenSize.width < 700) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _leftArrow,
              SizedBox(width: 16.w),
              Expanded(
                child: _carousel(
                  CarouselOptions(
                    autoPlay: false,
                    aspectRatio: 1.48,
                    viewportFraction: 1,
                    onPageChanged: (index, reason) {
                      controller.current.value = index;
                    },
                  ),
                ),
              ),
              SizedBox(width: 16.w),
              _rightArrow,
            ],
          ),
        );
      } else if (sizingInfo.isTablet) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 27.5.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _leftArrow,
              SizedBox(width: 16.w),
              Expanded(
                child: _carousel(
                  CarouselOptions(
                    autoPlay: false,
                    aspectRatio: 2.89,
                    viewportFraction: .60,
                    onPageChanged: (index, reason) {
                      controller.current.value = index;
                    },
                  ),
                ),
              ),
              SizedBox(width: 16.w),
              _rightArrow,
            ],
          ),
        );
      } else if (sizingInfo.isDesktop) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 150.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _leftArrow,
              SizedBox(width: 16.w),
              Expanded(
                child: _carousel(
                  CarouselOptions(
                    autoPlay: false,
                    aspectRatio: 3,
                    viewportFraction: 0.375,
                    onPageChanged: (index, reason) {
                      controller.current.value = index;
                    },
                  ),
                ),
              ),
              SizedBox(width: 16.w),
              _rightArrow,
            ],
          ),
        );
      } else {
        return _mobileNative;
      }
    });
  }

  Widget _carousel(CarouselOptions options, {int count: 2}) {
    return Obx(() => CarouselSlider.builder(
        itemCount: controller.count < count ? count : controller.count,
        itemBuilder: (context, index, realIndex) {
          return controller.count < count
              ? ShimmeryPlaceHolder()
              : _cardForHighlight(controller.getHighlightByIndex(index));
        },
        options: options));
  }

  Widget _cardForHighlight(highlight) {
    switch (highlight.cardType) {
      case CardType.video:
      // TODO: use a different video controller
      // return VideoHighlight(highlight: highlight);
      case CardType.standard:
        return StandardHighlight(highlight: highlight);
      case CardType.bankAccount:
        return BankAccountHighlight(highlight: highlight);
      case CardType.creditScore:
        return CreditScoreHighlight(highlight: highlight);
      default:
        return Container();
    }
  }
}
