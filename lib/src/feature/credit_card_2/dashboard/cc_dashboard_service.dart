import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:glorifi/src/core/data_helper.dart';
import 'package:glorifi/src/core/mock/mock_data.dart';
import '../transactions/model/cc_transaction_details_model.dart';

class CCDashboardService extends GetxService {
  _api(bool isMockEnabled) {
    return isMockEnabled ? MockData() : DataHelperImpl.instance.apiHelper;
  } 


  // TODO: Use CCTransactionDetailsModel here when Api is ready
  Future<List<CCTransactionDetailsModel>> getCCTransactions(bool isMockEnabled, 
      {int loadMoreIndex: 0}) async {
    final res = await _api(isMockEnabled).getCCTransactions(loadMoreIndex)
        as Map<String, dynamic>;
    return res["transactions"]
        .map<CCTransactionDetailsModel>(
            (json) => CCTransactionDetailsModel.fromJson(json))
        .toList();
  }
}
