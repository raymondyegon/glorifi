import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/feature/onboard/all_products/controllers/all_products_controller.dart';
import 'package:glorifi/src/feature/onboard/all_products/widget/item_product.dart';
import 'package:glorifi/src/routes/app_pages.dart';
import 'package:glorifi/src/widgets/tap/ripple.dart';

class AllProductsView extends GetView<AllProductsController> {
  const AllProductsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          floatingActionButton: _getCloseFab(),
          floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
          body: SingleChildScrollView(
            child: Column(children: [
              ItemProduct(data: controller.bankingData, onTap: onButtonTap),
              ItemProduct(data: controller.mortgageData, onTap: onButtonTap),
              ItemProduct(data: controller.insuranceData, onTap: onButtonTap),
              ItemProduct(data: controller.creditCardData, onTap: onButtonTap),
            ]),
          )),
    );
  }

  Widget _getCloseFab() {
    return Ripple(
      onTap: Get.back,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: const Icon(Icons.close, color: Colors.white),
      ),
    );
  }

  void onButtonTap() => Get.toNamed(Routes.createProfilePlus);
}
