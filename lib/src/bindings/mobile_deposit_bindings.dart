import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:glorifi/src/feature/banking/consent/controller/check_deposit_controller.dart';
import 'package:glorifi/src/feature/banking/controller/glorifi_gradient_progress_indicator_controller.dart';
import 'package:glorifi/src/feature/banking/controller/my_bank_controller.dart';
import 'package:glorifi/src/feature/banking/deposit_check/controller/mobile_deposit_controller.dart';
import 'package:glorifi/src/feature/banking/deposit_check_view_review/controller/check_print_controller.dart';
import 'package:glorifi/src/feature/banking/deposit_check_view_review/controller/deposited_check_controller.dart';
import 'package:glorifi/src/feature/banking/deposit_check_view_review/controller/deposited_check_images_controller.dart';
import 'package:glorifi/src/structure/base_bindings.dart';

class MobileDepositBindings extends BaseBinding {
  @override
  void dependencies() {
    super.dependencies();
    Get.lazyPut<MobileDepositController>(() => MobileDepositController());
    Get.lazyPut<CheckDepositController>(() => CheckDepositController());

    Get.lazyPut<DepositedCheckController>(() => DepositedCheckController());
    Get.lazyPut<DepositedCheckImagesController>(
        () => DepositedCheckImagesController());
    Get.lazyPut<CheckPrintController>(() => CheckPrintController());
    Get.lazyPut<GlorifiGradientProgressIndicatorController>(
        () => GlorifiGradientProgressIndicatorController());
    Get.lazyPut<MyBankController>(() => MyBankController());
  }
}
