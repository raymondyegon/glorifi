import 'package:get/get.dart';
import 'package:glorifi/src/core/mock/mock_data.dart';
import 'package:glorifi/src/feature/credit_card_2/transactions/model/cc_merchant_model.dart';
import 'package:glorifi/src/feature/credit_card_2/transactions/model/cc_transaction_details_model.dart';

class CCMerchantDetailService extends GetxService {
  // final _apiHelper = DataHelperImpl.instance.apiHelper;
  final _apiHelper = MockData();

  Future<Map<String, dynamic>> getCCMerchantDetails(
      {required String merchantId}) async {
    final res = await _apiHelper.getCCMerchantDetails(merchantId)
        as Map<String, dynamic>;
    return res;
  }
}
