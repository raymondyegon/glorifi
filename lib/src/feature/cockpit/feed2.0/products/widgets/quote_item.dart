import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/feature/cockpit/feed2.0/products/controllers/product_controller.dart';
import 'package:glorifi/src/feature/cockpit/feed2.0/products/model/product_model.dart';
import 'package:glorifi/src/feature/cockpit/feed2.0/products/widgets/side_divider.dart';
import 'package:glorifi/src/feature/onboard/value/widget/value_pager_indicator.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';

class QuoteItem extends StatelessWidget {
  final ProductQuoteList productQuoteList;
  const QuoteItem({Key? key, required this.productQuoteList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ProductsController controller = Get.find<ProductsController>();
    return Obx(() => Column(
          children: [
            SideDivider().paddingOnly(top: 82),
            Text(
              productQuoteList.title.toUpperCase(),
              textAlign: TextAlign.center,
              style: customGlorifiStyle(
                fontFamily: "Arvo",
                weight: FontWeight.w700,
                size: 28,
                color: GlorifiColors.white,
              ),
            ).paddingOnly(top: 32),
            CarouselSlider(
              options: CarouselOptions(
                initialPage: controller.sliderIndex.value,
                viewportFraction: 1,
                autoPlay: false,
                enableInfiniteScroll: false,
                onPageChanged: (index, reason) {
                  controller.sliderIndex.value = index;
                },
              ),
              items: productQuoteList.productQuotes.map(
                (e) {
                  return Column(
                    children: [
                      Text(e.content,
                          textAlign: TextAlign.center,
                          style: leadSemiBold18Primary(
                            color: GlorifiColors.white,
                          )).paddingOnly(top: 27),
                      Text(
                        e.customer,
                        style: captionRegular14Primary(
                          color: GlorifiColors.white,
                        ),
                      ).paddingOnly(top: 10),
                    ],
                  );
                },
              ).toList(),
            ),
            ValuePagerIndicator(
              pageCount: productQuoteList.productQuotes.length,
              currentIndex: controller.sliderIndex.value,
            ).paddingOnly(top: 42),
          ],
        ).paddingOnly(left: 32, right: 32));
  }
}
