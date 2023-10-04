import 'package:get/get.dart';
import 'package:glorifi/src/core/data_helper.dart';
import 'package:glorifi/src/core/logger.dart';
import 'package:glorifi/src/model/personal_snapshot/total_debt_detail_model.dart';
import 'package:glorifi/src/utils/snackbar_util.dart';

class TotalDebtService extends GetxService {
  TotalDebtService();

  final _dataHelper = DataHelperImpl.instance;

  Future<TotalDebtDetailModel?> getTotalDebt() async {
    final response = await _dataHelper.apiHelper.getTotalDebt();
    return response.fold((l) {
      Log.error(l.errorMessage);
      apiExceptionMessage(l.errorCode);
      return null;
    }, (r) {
      return r;
    });
  }

  Future getMonthlyIncome() async {
    final response = await _dataHelper.apiHelper.getMonthlyIncome();
    return response.fold((l) {
      Log.error(l.errorMessage);
      return null;
    }, (r) {
      return r;
    });
  }

  Future postMonthlyIncome(int value) async {
    final response = await _dataHelper.apiHelper.postMonthlyIncome(value);
    return response.fold((l) {
      Log.error(l.errorMessage);
      return null;
    }, (r) {
      return r;
    });
  }
}
