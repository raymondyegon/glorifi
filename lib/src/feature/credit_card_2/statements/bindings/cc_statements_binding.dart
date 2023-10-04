import 'package:get/get.dart';
import 'package:glorifi/src/feature/credit_card_2/statements/controller/cc_statements_controller.dart';

class CCStatementsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut( ()=>CCStatementsController());
  }
}