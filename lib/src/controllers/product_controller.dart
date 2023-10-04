import 'package:get/get.dart';
import 'package:glorifi/src/routes/app_pages.dart';
import 'package:glorifi/src/structure/base_controller.dart';

class ProductController extends BaseController {
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {}

  @override
  void update([List<Object>? ids, bool condition = true]) {}

  @override
  void onClose() {}

  void navigateToBanking() {
    //Get.toNamed(Routes.myBanking);
    Get.toNamed(Routes.openBankAccount);
  }

  void navigateToInsurance() {
    Get.toNamed(Routes.insurance);
  }

  void navigateToMortgage() {
    Get.toNamed(Routes.mortgage);
  }
}
