import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/feature/cockpit/feed2.0/products/controllers/product_controller.dart';
import 'package:glorifi/src/feature/cockpit/feed2.0/products/model/product_model.dart';
import 'package:glorifi/src/feature/onboard/value/widget/value_pager_indicator.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';

class InsuranceOptionsSlider extends GetView<ProductsController> {
  final ProductionOptionList productionOptionList;
  const InsuranceOptionsSlider({
    Key? key,
    required this.productionOptionList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => Column(
          children: [
            CarouselSlider(
              options: CarouselOptions(
                height: Get.width - 100,
                initialPage: 0,
                autoPlay: false,
                enableInfiniteScroll: false,
                onPageChanged: (index, reason) {
                  controller.creditCardsSliderIndex.value = index;
                },
              ),
              items: productionOptionList.options.map(
                (productItem) {
                  return Container(
                    width: Get.width - 100,
                    height: Get.width - 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: GlorifiColors.white,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          productItem.imageUrl,
                          width: (Get.width - 100) * 0.25,
                        ),
                        Text(
                          productItem.title.toUpperCase(),
                          style: customGlorifiStyle(
                              fontFamily: 'Arvo',
                              weight: FontWeight.bold,
                              size: 28,
                              color: GlorifiColors.darkBlueColor),
                        ).paddingOnly(top: 30, bottom: 20),
                        Text(
                          productItem.content,
                          textAlign: TextAlign.center,
                          style: smallRegular16Primary(
                              color: GlorifiColors.ebonyBlue),
                        ),
                      ],
                    ).paddingAll(20),
                  );
                },
              ).toList(),
            ),
            ValuePagerIndicator(
              pageCount: productionOptionList.options.length,
              currentIndex: controller.creditCardsSliderIndex.value,
            ).paddingOnly(top: 40),
          ],
        ));
  }
}
