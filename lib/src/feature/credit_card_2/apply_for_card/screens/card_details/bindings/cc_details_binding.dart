import 'package:get/get.dart';
import 'package:glorifi/src/feature/credit_card_2/apply_for_card/screens/card_details/controller/cc_details_controller.dart';

class CCDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CCDetailsController(), fenix: true);
  }
}
