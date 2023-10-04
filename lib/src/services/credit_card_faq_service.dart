import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:glorifi/src/core/data_helper.dart';
import 'package:glorifi/src/core/logger.dart';
import 'package:glorifi/src/feature/credit_card/model/credit_card_faq_response.dart';

class CreditCardFAQService extends GetxService {
  CreditCardFAQService();

  final _dataHelper = DataHelperImpl.instance;

  Future<CreditCardFAQResponse?> getCreditCardFAQ() async {
    final response = await _dataHelper.apiHelper.getCreditCardFAQ();
    return response.fold((l) {
      Log.error(l.errorMessage);
    }, (r) {
      return r;
    });
  }
}
