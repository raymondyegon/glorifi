import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:glorifi/src/core/data_helper.dart';
import 'package:glorifi/src/core/mock/mock_data.dart';
import 'package:glorifi/src/feature/banking/open_account/model/oao_member_application.dart';
import 'package:glorifi/src/feature/banking/servicing/model/ebs_account_detail_model.dart';
import 'package:glorifi/src/feature/banking/servicing/model/ebs_manage_pin_response.dart';
import 'package:glorifi/src/feature/banking/servicing/model/ebs_statement.dart';
import 'package:glorifi/src/feature/banking/servicing/model/ebs_transaction.dart';

class EBSService extends GetxService {
  final _apiHelper = DataHelperImpl.instance.apiHelper;
  // final _apiHelper = MockData();

  Future<EBSAccountDetailModel?> getAccountDetails(String id) async {
    try {
      final response = await _apiHelper.getAccountDetails(id);
      final model = EBSAccountDetailModel.fromJson(response['data']);
      return model.accountStatus != "None" ? model : null;
    } catch (e) {
      return null;
    }
  }

  Future<EBSTransactions> getTransactions(String id, int start, int limit) async {
    final res = await _apiHelper.getAccountTransactions(id, start, limit);
    return EBSTransactions.fromJson(res['data']);
  }

  Future<bool> activateCard(String id) async {
    final res = await _apiHelper.cardTransition(id, "activate");
    return res['data']['cardTransitionStatusCode'] == 200;
  }

  Future<bool> suspendCard(String id) async {
    final res = await _apiHelper.cardTransition(id, "suspend");
    return res['data']['cardTransitionStatusCode'] == 200;
  }

  Future<bool> unsuspendCard(String id) async {
    final res = await _apiHelper.cardTransition(id, "unsuspend");
    return res['data']['cardTransitionStatusCode'] == 200;
  }

  Future<PartialAddress> fetchUserAddress({bool mailingAddress = true}) async {
    final res = await _apiHelper.getExistingBankingUser() as Map<String, dynamic>;
    final temp = OAOMemberApplication.fromJson(res['data'], null);
    return mailingAddress ? temp.mailingAddress : temp.address;
  }

  Future<EBSManagePinResponse> getChangePinCredentials(String id) async {
    final res = await _apiHelper.getChangePinCredentials(id);
    return EBSManagePinResponse.fromJson(res['data']);
  }

  Future<List<EBSStatement>> getStatements(String id) async {
    final res = await _apiHelper.getStatements(id);
    final statements = (res['data']['statements'] as List)
        .map((e) => EBSStatement.fromJson(e))
        .toList();
    return statements;
  }
}
