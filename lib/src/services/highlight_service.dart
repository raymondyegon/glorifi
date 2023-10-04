import 'package:get/get.dart';
import 'package:glorifi/src/core/data_helper.dart';
import 'package:glorifi/src/core/logger.dart';
import 'package:glorifi/src/feature/highlights/highlight_model.dart';
import 'package:glorifi/src/utils/snackbar_util.dart';

class HighlightService extends GetxService {
  HighlightService();

  final _dataHelper = DataHelperImpl.instance;

  Future<HighlightModel?> getInsightsHighlight() async {
    final response = await _dataHelper.apiHelper.getInsightsHighlight();
    return response.fold((l) {
      Log.error(l.errorMessage);
      apiExceptionMessage(l.errorCode);
    }, (r) {
      return r;
    });
  }

  Future<ApplicationStatusModel?> getApplicationStatus() async {
    final response = await _dataHelper.apiHelper.getApplicationStatus();
    return response.fold((l) {
      Log.error(l.errorMessage);
      apiExceptionMessage(l.errorCode);
    }, (r) {
      return r;
    });
  }

  Future<HighlightModel?> getBankAccountHighlight() async {
    final response = await _dataHelper.apiHelper.getBankAccountHighlight();
    return response.fold((l) {
      Log.error(l.errorMessage);
      apiExceptionMessage(l.errorCode);
    }, (r) {
      return r;
    });
  }

  Future<HighlightModel?> getCreditScoreHighlight() async {
    final response = await _dataHelper.apiHelper.getCreditScoreHighlight();
    return response.fold((l) {
      Log.error(l.errorMessage);
    }, (r) {
      return r;
    });
  }

  Future<HighlightModel?> getProductsHighlight() async {
    final response = await _dataHelper.apiHelper.getProductsHighlight();
    return response.fold((l) {
      Log.error(l.errorMessage);
      apiExceptionMessage(l.errorCode);
    }, (r) {
      return r;
    });
  }
}
