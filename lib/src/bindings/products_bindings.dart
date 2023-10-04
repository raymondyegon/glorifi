import 'package:get/get.dart';
import 'package:glorifi/src/controllers/product_controller.dart';
import 'package:glorifi/src/structure/base_bindings.dart';

class ProductBindings extends BaseBinding {
  @override
  void dependencies() {
    super.dependencies();
    Get.lazyPut<ProductController>(() => ProductController());
  }
}
