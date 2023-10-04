import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/feature/cockpit/feed2.0/products/controllers/product_controller.dart';
import 'package:glorifi/src/feature/cockpit/feed2.0/products/model/product_model.dart';
import 'package:glorifi/src/feature/cockpit/feed2.0/products/widgets/picture_content_item.dart';
import 'package:glorifi/src/feature/onboard/value/widget/value_pager_indicator.dart';

class CreditCardsSlider extends GetView<ProductsController> {
  final ProductionOptionList productionOptionList;
  const CreditCardsSlider({
    Key? key,
    required this.productionOptionList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => Column(
          children: [
            CarouselSlider(
              options: CarouselOptions(
                height: 800,
                initialPage: 0,
                viewportFraction: 1,
                autoPlay: false,
                enableInfiniteScroll: false,
                onPageChanged: (index, reason) {
                  controller.creditCardsSliderIndex.value = index;
                },
              ),
              items: productionOptionList.options.map(
                (productItem) {
                  return Stack(
                    children: [
                      Image.asset(
                        productItem.imageUrl,
                      ),
                      Positioned(
                        top: 400,
                        child: Container(
                          width: Get.width,
                          child: ProductContentItem(
                              hint: productItem.hint.toUpperCase(),
                              title: productItem.title.toUpperCase(),
                              content: productItem.content),
                        ),
                      )
                    ],
                  );
                },
              ).toList(),
            ),
            ValuePagerIndicator(
              pageCount: productionOptionList.options.length,
              currentIndex: controller.creditCardsSliderIndex.value,
            ),
          ],
        ));
  }
}
