import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:glorifi/src/core/data_helper.dart';
import 'package:glorifi/src/core/logger.dart';
import 'package:glorifi/src/feature/credit_card/model/credit_card_applications_data.dart';
import 'package:glorifi/src/feature/credit_card/model/credit_card_data.dart';
import 'package:glorifi/src/feature/credit_card/model/credit_card_response.dart';
import 'package:glorifi/src/feature/mortgage/model/banner_data_model.dart';
import 'package:glorifi/src/utils/snackbar_util.dart';

class CreditCardService extends GetxService {
  CreditCardService();

  final _dataHelper = DataHelperImpl.instance;

  Future<CreditCardData?> getCreditCardDetailData() async {
    final response = await _dataHelper.apiHelper.getCreditCardDetailData();
    return response.fold((l) {
      Log.error(l.errorMessage);
    }, (r) {
      return r;
    });
  }

  Future<BannerDataModel?> getBannerData() async {
    final response = await _dataHelper.apiHelper.getCreditCardBanner();
    return response.fold((l) {
      Log.error(l.errorMessage);
    }, (r) {
      return r;
    });
  }

  Future<CreditCardResponse?> getCreditCardData() async {
    final response = await _dataHelper.apiHelper.getCreditCards();
    return response.fold((l) {
      Log.error(l.errorMessage);
      apiExceptionMessage(l.errorCode);
    }, (r) {
      return r;
    });
  }

  Future<CreditCardApplicationsData?> getCreditCardApplicationsData() async {
    final response = await _dataHelper.apiHelper.getCreditCardApplication();
    return response.fold((l) {
      Log.error(l.errorMessage);
      apiExceptionMessage(l.errorCode);
    }, (r) {
      return r;
    });
  }
}
