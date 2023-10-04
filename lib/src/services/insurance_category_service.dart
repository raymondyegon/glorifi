import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:glorifi/src/core/data_helper.dart';
import 'package:glorifi/src/core/logger.dart';
import 'package:glorifi/src/feature/insurance/model/insurance_category_model.dart';

class InsuranceCategoryService extends GetxService {
  InsuranceCategoryService();

  final _dataHelper = DataHelperImpl.instance;

  Future<InsuranceCategoryModel?> getInsuranceCategory() async {
    final response = await _dataHelper.apiHelper.getInsuranceCategoryData();
    return response.fold((l) {
      Log.error(l.errorMessage);
    }, (r) {
      return r;
    });
  }
}
