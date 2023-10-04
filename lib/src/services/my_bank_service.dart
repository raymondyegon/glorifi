import 'dart:developer';

import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:glorifi/src/core/data_helper.dart';
import 'package:glorifi/src/core/logger.dart';
import 'package:glorifi/src/core/mock/mock_data.dart';
import 'package:glorifi/src/feature/banking/model/banking_banner_model.dart';
import 'package:glorifi/src/feature/banking/model/connected_account_model.dart';
import 'package:glorifi/src/feature/banking/model/glorifi_accounts_model.dart';
import 'package:glorifi/src/feature/banking/servicing/screens/transfer/eligible_accounts_model.dart';
import 'package:glorifi/src/feature/cockpit/feed2.0/accounts/widgets/linked_account_list.dart';
import 'package:glorifi/src/feature/credit_card_2/dashboard/models/cc_dashboard_model.dart';
import 'package:glorifi/src/model/linked_institutions_model.dart';
import 'package:glorifi/src/utils/snackbar_util.dart';


class MyBankService extends GetxService {
  MyBankService();
  final _apiHelper = DataHelperImpl.instance.apiHelper;

  Future<BankingBannerModel?> getBankingBanner() async {
    final response = await _apiHelper.getBankingBanner();
    return response.fold((l) {
      Log.error(l.errorMessage);
    }, (r) {
      return r;
    });
  }

  Future<ConnectedAccountModel?> getConnectedAccounts() async {
    final response = await _apiHelper.getConnectedAccounts();
    return response.fold((l) {
      Log.error(l.errorMessage);
      apiExceptionMessage(l.errorCode);
    }, (r) {
      return r;
    });
  }

  Future<List<LinkedAccounts>> getExternalFundingAccounts() async {
    final res = await _apiHelper.getEligibleTransferAccounts();
    return res.fold((l) => [], (r) {
      return (r as EligibleAccountsModel).data.linkedAccounts;
    });
  }

  Future<CCDashboardModel?> getCreditCardAccount(bool isMockEnabled) async {
    final _api = isMockEnabled ? MockData() : _apiHelper;
    try {
      final response = await _api.getCreditCardAccount();
      if (response != null) {
        return CCDashboardModel.fromJson(response as Map<String, dynamic>);
      }
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  Future<GlorifiAccountResponse?> getConnectedGloriFiAccounts() async {
    final response = await _apiHelper.getConnectedGloriFiAccounts();
    return response.fold((l) {
      Log.error(l.errorMessage);
      apiExceptionMessage(l.errorCode, toast: true);
    }, (r) {
      return r;
    });
  }
}
