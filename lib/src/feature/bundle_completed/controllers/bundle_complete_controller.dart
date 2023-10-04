import 'package:get/get.dart';
import 'package:glorifi/src/feature/bundle_completed/arguments/bundle_complete_argument.dart';

class BundleCompleteController extends GetxController {
  late final BundleCompleteArgument argumentData;

  @override
  void onInit() {
    argumentData = Get.arguments;
    super.onInit();
  }
}
