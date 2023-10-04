import 'package:get/get.dart';
import 'package:glorifi/src/feature/legal/controllers/legal_controller.dart';

class LegalBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(LegalController());
  }
}