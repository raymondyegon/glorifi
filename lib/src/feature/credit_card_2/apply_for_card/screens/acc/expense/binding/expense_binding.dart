import 'package:get/get.dart';
import 'package:glorifi/src/feature/credit_card_2/apply_for_card/screens/acc/expense/controller/expense_controller.dart';

class ExpenseBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ExpenseController());
  }
}
