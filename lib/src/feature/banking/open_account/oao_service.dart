import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:glorifi/src/core/data_helper.dart';
import 'package:glorifi/src/core/mock/mock_data.dart';
import 'package:glorifi/src/feature/banking/open_account/model/oao_debit_card.dart';
import 'package:glorifi/src/feature/banking/open_account/model/oao_deposit_account.dart';
import 'package:glorifi/src/feature/banking/open_account/model/oao_disclosure.dart';
import 'package:glorifi/src/feature/banking/open_account/model/oao_funding_accounts_model.dart';
import 'package:glorifi/src/feature/banking/open_account/model/oao_member_application.dart';
import 'package:us_states/us_states.dart';

class OAOService extends GetxService {
  final _dataHelper = DataHelperImpl.instance.apiHelper;
  // final _dataHelper = MockData();

  // TODO: Dry this out - WC
  Future<List> getCheckingProducts() async {
    try {
      final res = await _dataHelper.getCheckingProducts();
      return (res['data'] as List).map((d) => OAODepositAccount.fromJson(d)).toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<List> getSavingsProducts() async {
    try {
      final res = await _dataHelper.getSavingsProducts();
      return (res['data'] as List).map((d) => OAODepositAccount.fromJson(d)).toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<List> getCdProducts() async {
    try {
      final res = await _dataHelper.getCDProducts();
      return (res['data'] as List)
          .map((d) => OAODepositAccount.fromJson(d))
          .where((element) => element.group == "CD") // server is returning other types too
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<List> verifyAddress(PartialAddress address) async {
    try {
      final res = await _dataHelper.verifyAddress(address);
      if (res['data']['deliverable'] != null && res['data']['deliverable'] != "deliverable") {
        return res['data']["deliverable_analysis"].map((message) => message["value"]).toList();
      }
      List? errors = res["data"]["Errors"];

      if (errors != null && errors.length > 0) {
        return errors;
      }
      return [];
    } catch (e) {
      rethrow;
    }
  }

  Future<List> getDebitCardOptions() async {
    try {
      final res = await _dataHelper.getDebitCards();
      return (res['data'] as List).map((d) => OAODebitCard.fromJson(d)).toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<OAOFundingAccountsModel?> getFundingAccounts(bool isCD) async {
    try {
      final res = await _dataHelper.getFundingAccounts();
      return OAOFundingAccountsModel.fromJson(res['data'], isCD);
    } catch (e) {
      rethrow;
    }
  }

  // nil if success. Error message if failed?
  Future<String?> orderDebitCard(OAOMemberApplication application) async {
    try {
      final payload = {
        "accountNumber": application.accountId,
        "expediteShippingFlag": application.expeditedShipping.value
      };
      final res = await _dataHelper.orderDebitCard(application.selectedCard.value.cardProductToken, payload);

      return res['success'] == true ? null : res['message'];
    } catch (e) {
      rethrow;
    }
  }

  // TODO: Maybe a model, error tuple would be more reliable
  Future<Map> submitApplication(OAOMemberApplication application) async {
    final res = await _dataHelper.submitApplication(application.selectedProduct!.name);
    final data = {
      "accountNumber": res["data"]["acctNbr"],
      "routingNumber": res["data"]["finInstAba"],
      "accountId": res["data"]["acctId"]
    };
    return data;
  }

  Future<Map> submitApplicationAndMakeDeposit(
      {required OAOMemberApplication application,
      required double amount,
      required String acctId,
      required String linkedAccountId,
      required bool isInternal}) async {
    final Map<String, dynamic> body;

    if (isInternal) {
      body = {
        'originator': {'acctId': linkedAccountId},
        'counterParty': {'acctId': acctId},
        'amount': amount
      };
    } else {
      body = {
        'originator': {'acctId': acctId},
        'counterParty': {'linkedAccountId': linkedAccountId},
        'amount': amount
      };
    }

    final res = await _dataHelper.submitApplicationAndMakeDeposit(application.selectedProduct!.name, body);
    final data = {
      "accountNumber": res["data"]["acctNbr"],
      "routingNumber": res["data"]["finInstAba"],
      "accountId": res["data"]["acctId"],
      "status": res["status"]
    };
    return data;
  }

  Future<Map> createUser(OAOMemberApplication application) async {
    final payload = application.toCreateBankingUserPayload();
    return await _dataHelper.createBankingUser(payload);
  }

  // Checks if a user already has other products, creating a prefilled application
  Future<OAOMemberApplication?> attemptQuickApply(OAODepositAccount product) async {
    try {
      final res = await _dataHelper.getExistingBankingUser() as Map<String, dynamic>;
      return OAOMemberApplication.fromJson(res['data'], product);
    } catch (e) {
      return null;
    }
  }

  Future<List<OAODisclosure>> getDisclosures(OAODepositAccount product) async {
    final res = await _dataHelper.getProductDisclosures(product.name);
    return (res['data'] as List).map((d) => OAODisclosure.fromJson(d)).toList();
  }

  Future makeDeposit(
      {required double amount,
      required String acctId,
      required String linkedAccountId,
      required bool isInternal}) async {
    late final res;
    if (isInternal) {
      res = await _dataHelper.makeDepositInternal(amount: amount, acctId: acctId, linkedAccountId: linkedAccountId);
    } else {
      res = await _dataHelper.makeDepositIncoming(amount: amount, acctId: acctId, linkedAccountId: linkedAccountId);
    }
    return res;
  }
}
