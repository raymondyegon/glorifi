import 'package:get/get.dart';
import 'package:glorifi/src/structure/base_controller.dart';
import 'package:glorifi/src/utils/responsive/responsive_extensions.dart';

class CreditUsageData {
  late String creditStatus;
  late int percentage;

  late var totalCredit;
  late var usedCredit;

  CreditUsageData(
    this.creditStatus,
    this.percentage,
    this.totalCredit,
    this.usedCredit,
  );
}

class CreditUsageController extends BaseController {
  bool isLinkCard = false;
  late CreditUsageData creditUsageData;

  @override
  void onInit() {
    // ignore: todo
    // TODO: implement onInit
    creditUsageData = CreditUsageData('', 0, 0.0, 0.0);
    super.onInit();
  }

  linkCreditCard() {
    isLinkCard = true;
    creditUsageData = CreditUsageData('Good', 15, 6500.0, 300.0);
    update();
  }

  getTotalCreditWidth(var totalCredit) {
    return totalCredit == 0.0 ? 1.5.w : Get.width / 1.7;
  }

  getTotalDebitCreditWidth(
      var totalCredit, var debitCredit, var totalCreditWidth) {
    var diff = (debitCredit / totalCredit) * 100;
    var minValue = (totalCreditWidth * diff) / 100;
    return totalCredit == 0.0 ? 1.5.w : minValue;
  }

  @override
  void onClose() {
    // ignore: todo
    // TODO: implement onClose
    super.onClose();
  }
}
