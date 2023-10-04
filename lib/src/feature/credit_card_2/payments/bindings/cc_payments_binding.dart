import 'package:get/get.dart';
import 'package:glorifi/src/feature/credit_card_2/payments/cc_payments_service.dart';

class CCPaymentBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CCPaymentsService());
  }
}
