import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:glorifi/src/feature/credit_card_2/transactions/controller/cc_transaction_detail_controller.dart';
import 'package:glorifi/src/feature/credit_card_2/transactions/service/cc_merchant_detail_service.dart';

class CCTransactionDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CCTransactionDetailController());
    Get.lazyPut(() => CCMerchantDetailService());
  }
}
