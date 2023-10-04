import 'package:get/get.dart';
import 'package:glorifi/src/feature/credit_card_2/payments/cc_payments_service.dart';
import 'package:glorifi/src/feature/credit_card_2/payments/models/cc_funding_accounts_model.dart';
import '../dashboard/models/cc_dashboard_model.dart';

enum CCPaymentType {
  StatementBalance,
  MinimumPayment,
  FixedAmount,
  CurrentBalance
}

String? ccPaymentTypeString(CCPaymentType ccPaymentType) {
  switch (ccPaymentType) {
    case CCPaymentType.StatementBalance:
      return "Statement balance";
    case CCPaymentType.MinimumPayment:
      return "Minimum balance";
    case CCPaymentType.FixedAmount:
      return "";
    case CCPaymentType.CurrentBalance:
      return "Current balance";
  }
}

String ccPaymentTypeDataValue(CCPaymentType ccPaymentType) {
  switch (ccPaymentType) {
    case CCPaymentType.StatementBalance:
      return "STATEMENT-BALANCE";
    case CCPaymentType.MinimumPayment:
      return "MINIMUM-PAYMENT";
    case CCPaymentType.FixedAmount:
      return "FIXED-AMOUNT";
    case CCPaymentType.CurrentBalance:
      return "CURRENT-BALANCE";
  }
}

class CCPaymentsController extends GetxController {
  CCDashboardModel accountModel;
  List<CCFundingAccountModel> fundingAccounts = <CCFundingAccountModel>[];
  Rx<DateTime> paymentDate = DateTime.now().obs;
  double? amount;
  Rx<CCPaymentType> paymentType = CCPaymentType.FixedAmount.obs;

  CCPaymentsService _service = CCPaymentsService();
  CCFundingAccountModel? selectedFundingAccount;
  bool isAutoPay = false;
  int? autoPayDate;
  CCPaymentsController({required this.accountModel});

  fetchFundingAccounts() async {
    List<CCFundingAccountModel> _fundingAccounts =
        await _service.getCCFundingAccounts();
    fundingAccounts.clear();
    fundingAccounts.addAll(_fundingAccounts);
  }

  Future<bool> ccSchedulePayment() async {
    return await _service.ccSchedulePayment(
        isAutoPay,
        paymentDate.value,
        selectedFundingAccount!,
        amount,
        accountModel,
        paymentType.value,
        autoPayDate);
  }
}
