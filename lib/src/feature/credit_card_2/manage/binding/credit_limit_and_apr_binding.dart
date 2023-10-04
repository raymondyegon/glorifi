import 'package:get/get.dart';
import 'package:glorifi/src/feature/credit_card_2/manage/controller/credit_limit_and_apr_controller.dart';

class CreditLimitAndAprBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ViewCreditLimitAndAprController(), fenix: true);
  }
}