import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:glorifi/src/feature/credit_card_2/dashboard/cc_dashboard_controller.dart';
import 'package:glorifi/src/feature/credit_card_2/dashboard/models/cc_card_model.dart';
import 'package:glorifi/src/feature/onboard/value/widget/value_pager_indicator.dart';
import 'package:glorifi/src/routes/app_pages.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive.dart';

class CCDashboardCarousel extends GetView<CCDashboardController> {
  const CCDashboardCarousel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return controller.cards.length > 0
        ? Column(children: [
      CarouselSlider(
        options: CarouselOptions(
          initialPage: controller.carouselIndex.value,
          height: 87,
          viewportFraction: 1,
          autoPlay: false,
          enableInfiniteScroll: false,
          onPageChanged: (index, reason) {
            controller.carouselIndex.value = index;
          },
        ),
        items: controller.cards.map(_getCard).toList(),
      ),
      Obx(() => Padding(
          padding: EdgeInsets.only(top: 20.h),
          child: ValuePagerIndicator(
            pageCount: controller.cards.length,
            currentIndex: controller.carouselIndex.value,
            center: true,
          )))
          ])
        : SizedBox.shrink();
  }

  Widget _getCard(CCCardModel cardModel) {
    return InkWell(
      onTap: () {
        if (controller.carouselIndex.value == 0) {
          Get.toNamed(Routes.ccActivatePhysicalCard);
        }
      },
      child: Container(
        padding: EdgeInsets.all(10),
        width: 0.92.sw,
        child: Center(
            child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: GlorifiColors.darkBlueColor,
              ),
              child: SvgPicture.asset(
                'assets/images/credit_cart.svg',
                color: Colors.white,
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  cardModel.title,
                  style: TextStyle(
                      fontSize: 18,
                      color: GlorifiColors.darkBlueColor,
                      fontFamily: "Univers",
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 3,
                ),
                Container(
                    width: 0.6.sw,
                    child: Text(
                      cardModel.subText,
                      style: TextStyle(
                          fontSize: 10,
                          height: 14 / 10,
                          fontWeight: FontWeight.w500),
                    ))
              ],
            )
          ],
        )),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: GlorifiColors.lighterGrey),
          color: GlorifiColors.white,
        ),
      ),
    );
  }
}
