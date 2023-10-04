import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:glorifi/src/feature/cockpit/feed2.0/products/controllers/product_controller.dart';
import 'package:glorifi/src/feature/cockpit/feed2.0/products/widgets/details_page.dart';
import 'package:glorifi/src/feature/cockpit/feed2.0/products/widgets/head_item.dart';
import 'package:glorifi/src/feature/cockpit/feed2.0/products/widgets/picture_content_item.dart';
import 'package:glorifi/src/feature/cockpit/feed2.0/products/widgets/products_buttons.dart';
import 'package:glorifi/src/feature/cockpit/feed2.0/products/widgets/quote_item.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/utils/glorifi_assets.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/utils/responsive/responsive.dart';
import 'package:glorifi/src/widgets/buttons/primary_buton_dark.dart';
import 'package:glorifi/src/widgets/buttons/primary_button.dart';
import 'package:glorifi/src/widgets/tap/ripple.dart';
import 'package:lottie/lottie.dart';

class ProductsScreen extends StatelessWidget {
  final bool showCloseButton;
  final initialIndex;

  const ProductsScreen({
    Key? key,
    this.initialIndex = 0,
    this.showCloseButton = false,
  }) : super(key: key);

  Widget _TabItem({onTap: VoidCallback, isActive: bool, text: String}) {
    return Ripple(
      onTap: onTap,
      child: Text(
        text,
        style: isActive
            ? captionBold14Primary(color: GlorifiColors.white)
            : xSmallRegular12Primary(color: GlorifiColors.white),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    final controller = Get.put(ProductsController());
    controller.tabIndex.value = initialIndex;
    controller.changeTab(initialIndex);
    ScrollController _scrollController = ScrollController();
    Widget ProductTap() {
      return Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: FractionalOffset.topCenter,
            end: FractionalOffset.bottomCenter,
            colors: [
              GlorifiColors.midnightBlue,
              GlorifiColors.midnightBlue,
              GlorifiColors.midnightBlue.withOpacity(0.8),
              GlorifiColors.midnightBlue.withOpacity(0.5),
              GlorifiColors.midnightBlue.withOpacity(0.0),
            ],
            stops: [0.0, 0.3, 0.5, 0.8, 1.0],
          ),
        ),
        height: showCloseButton ? 192 : 166,
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              if (showCloseButton)
                Ripple(
                  onTap: Get.back,
                  child: SvgPicture.asset(GlorifiAssets.closeCircle),
                ).paddingOnly(top: 44, right: 24, bottom: 16),
              if (!showCloseButton) Spacer(),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: controller.tabList.map((e) {
                    return _TabItem(
                        isActive: controller.tabList.indexOf(e) ==
                            controller.tabIndex.value,
                        text: e,
                        onTap: () {
                          controller.changeTab(controller.tabList.indexOf(e));
                          _scrollController.animateTo(
                              _scrollController.position.minScrollExtent,
                              duration: Duration(milliseconds: 500),
                              curve: Curves.ease);
                        });
                  }).toList()),
            ],
          ),
        ),
      );
    }

    return Obx(() => Container(
          color: GlorifiColors.midnightBlue,
          child: Stack(
            children: [
            DetailsPage(
              model: controller.productValue.value,
              scrollController: _scrollController,
              includeBottomPadding: showCloseButton == false,
                onEarlyAccessTap: () async {
                  final result = await controller.onEarlyAccessTap();
                  if (result == true) {
                    Get.bottomSheet(_addedToList());
                    // TODO: Update Gain Early Access to be Youre on the list
                  } else {
                    _showRequestError(context);
                  }
              },
              alreadyRequestedAccess: controller.requestedStatus,
            ),
            ProductTap(),
            
          ],
        ),
      ),
    );
  }

  Widget _addedToList() {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          Lottie.asset(
            'assets/json/complete.json',
            width: 200.h,
            repeat: false,
          ),
          Text(
            'You’ve been added!',
            style: leadBold24Primary(),
          ).paddingOnly(bottom: 48.h),
          Text(
            'We\'ll notify you by email when this feature is ready for you.',
            style: smallRegular16Primary(),
            textAlign: TextAlign.center,
          ),
          Spacer(),
          PrimaryDarkButton(
            title: 'Close',
            onTap: () {
              Get.back();
            },
          )
        ]),
      ),
    );
  }

  _showRequestError(BuildContext context) {
    showDialog(context: context, builder: (ctx) => _alertDialog());
  }

  Widget _alertDialog() {
    return AlertDialog(
      title: Text(
          "There was an error processing your request. Please try again later."),
      titleTextStyle: bodyRegular18Primary(color: GlorifiColors.black),
      actions: [
        TextButton(
          child: Text(
            "Ok",
            style: TextStyle(color: GlorifiColors.black),
          ),
          onPressed: Get.back,
        ),
      ],
    );
  }
}
