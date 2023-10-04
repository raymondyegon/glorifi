import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:glorifi/src/core/data_helper.dart';
import 'package:glorifi/src/core/logger.dart';
import 'package:glorifi/src/feature/mortgage/model/banner_data_model.dart';
import 'package:glorifi/src/feature/mortgage/model/mortgage_data.dart';
import 'package:glorifi/src/feature/mortgage/model/state_data_model.dart';
import 'package:glorifi/src/utils/snackbar_util.dart';

class MortgageService extends GetxService {
  MortgageService();

  final _dataHelper = DataHelperImpl.instance;

  Future<BannerDataModel?> getBannerData() async {
    final response = await _dataHelper.apiHelper.getMortgagesBanners();
    return response.fold((l) {
      Log.error(l.errorMessage);
    }, (r) {
      return r;
    });
  }

  Future<MortgageDataResponse?> getMortgageData() async {
    final response = await _dataHelper.apiHelper.getMortgages();
    return response.fold((l) {
      apiExceptionMessage(l.errorCode);
      Log.error(l.errorMessage);
    }, (r) {
      return r;
    });
  }

  Future<StateDataResponse?> getMortgageStateData(String product) async {
    final response = await _dataHelper.apiHelper.getMortgageStates(product);
    return response.fold((l) {
      Log.error(l.errorMessage);
    }, (r) {
      return r;
    });
  }
}
