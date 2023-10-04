import 'package:get/get.dart';
import 'package:glorifi/src/controllers/credit_score_detail_screen_controller.dart';
import 'package:glorifi/src/structure/base_bindings.dart';

class CreditScoreDetailScreenBinding extends BaseBinding {
  @override
  void dependencies() {
    super.dependencies();
    Get.lazyPut<CreditScoreDetailScreenController>(
        () => CreditScoreDetailScreenController());
  }
}
