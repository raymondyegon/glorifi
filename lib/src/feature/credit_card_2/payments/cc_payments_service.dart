import 'dart:developer';

import 'package:get/get.dart';
import 'package:glorifi/src/core/data_helper.dart';
import 'package:glorifi/src/core/mock/mock_data.dart';
import 'package:glorifi/src/feature/credit_card_2/dashboard/models/cc_dashboard_model.dart';
import 'package:glorifi/src/feature/credit_card_2/payments/cc_payments_controller.dart';
import 'package:glorifi/src/feature/credit_card_2/payments/models/cc_funding_accounts_model.dart';

class CCPaymentsService extends GetxService {
  // final _dataHelper = DataHelperImpl.instance.apiHelper;
  final _dataHelper = MockData();

  Future<List<CCFundingAccountModel>> getCCFundingAccounts() async {
    try {
      final res = await _dataHelper.getCCFundingAccounts();
      return res['data']
          .map<CCFundingAccountModel>(
              (json) => CCFundingAccountModel.fromJson(json))
          .toList();
    } catch (e) {
      log(e.toString());
      return [];
    }
  }

  Future<bool> ccSchedulePayment(
      bool isAutoPay,
      DateTime paymentDate,
      CCFundingAccountModel selectedFundingAccount,
      double? amount,
      CCDashboardModel accountModel,
      CCPaymentType paymentType,
      int? autoPayDate) async {
    try {
      final resCreate = await _dataHelper.ccCreateACHPayment(
          accountModel.accountNumber, selectedFundingAccount);
      if (resCreate['id'] == null) {
        return false;
      }
      if (isAutoPay) {
        var res = await _dataHelper.ccScheduleAutoPayment(resCreate['id'],
            amount, accountModel.accountNumber, paymentType, autoPayDate!);
        return res['id'] != null; // response will have id if it is successful
      } else {
        var res = await _dataHelper.ccSchedulePayment(
            paymentDate, resCreate['id'], amount!, accountModel.accountNumber);
        return res['id'] != null; // response will have id if it is successful
      }
    } catch (e) {
      log(e.toString());
      return false;
    }
  }
}
