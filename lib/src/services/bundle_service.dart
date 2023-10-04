import 'package:get/get.dart';
import 'package:glorifi/src/core/data_helper.dart';
import 'package:glorifi/src/core/logger.dart';
import 'package:glorifi/src/feature/bundles/model/bundle_details_response_model.dart';
import 'package:glorifi/src/feature/bundles/model/bundle_response_model.dart';
import 'package:glorifi/src/utils/snackbar_util.dart';

class BundleService extends GetxService {
  BundleService();

  final _dataHelper = DataHelperImpl.instance;

  Future<BundleResponseModel?> getBundles() async {
    final response = await _dataHelper.apiHelper.getBundles();

    return response.fold((l) {
      Log.error(l.errorMessage);
      throw l.errorMessage;
    }, (r) {
      return r;
    });
  }

  Future<BundleDetailsResponseModels?> getBundleDetails(
      String bundleName) async {
    final response = await _dataHelper.apiHelper.getBundleDetails(bundleName);

    return response.fold((l) {
      apiExceptionMessage(l.errorCode);
      Log.error(l.errorMessage);
      // throw l.errorMessage;
    }, (r) {
      return r;
    });
  }
}
