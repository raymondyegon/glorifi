import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:glorifi/src/core/data_helper.dart';
import 'package:glorifi/src/core/logger.dart';
import 'package:glorifi/src/feature/insurance/model/quote_response.dart';
import 'package:glorifi/src/feature/policy_detail/model/policy_detail_response.dart';
import 'package:glorifi/src/utils/snackbar_util.dart';

import '../feature/insurance/model/base_response.dart';

class InsuranceService extends GetxService {
  InsuranceService();

  final _dataHelper = DataHelperImpl.instance;

  Future<BaseResponse?> getPolicies() async {
    final response = await _dataHelper.apiHelper.getMyPolicy();
    return response.fold((l) {
      Log.error(l.errorMessage);
    }, (r) {
      return r;
    });
  }

  Future<QuoteResponse?> getQuotes() async {
    final response = await _dataHelper.apiHelper.getPendingQuotes();
    return response.fold((l) {
      Log.error(l.errorMessage);
    }, (r) {
      return r;
    });
  }

  Future<PolicyDetailResponse?> getPolicyDetail({required String id}) async {
    final response = await _dataHelper.apiHelper.getPolicyDetail(id: id);
    return response.fold((l) {
      Log.error(l.errorMessage);
    }, (r) {
      return r;
    });
  }
}
