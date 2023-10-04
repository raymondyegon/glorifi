import 'package:get/get.dart';
import 'package:glorifi/src/routes/app_pages.dart';
import 'package:glorifi/src/structure/base_controller.dart';

class OnBoardingController extends BaseController {
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

  void navigateToProducts() {
    Get.toNamed(Routes.products);
  }
}
