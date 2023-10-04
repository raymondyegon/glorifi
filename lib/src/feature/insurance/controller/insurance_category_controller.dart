import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:glorifi/src/feature/insurance/model/insurance_category_model.dart';
import 'package:glorifi/src/services/insurance_category_service.dart';
import 'package:glorifi/src/structure/base_controller.dart';

class InsuranceCategoryController extends BaseController {
  RxList<InsuranceCategoryData> insuranceCategory =
      RxList<InsuranceCategoryData>();

  @override
  void onInit() async {
    super.onInit();
    getInsuranceCategories();
  }

  Future<void> getInsuranceCategories() async {
    InsuranceCategoryModel response = await InsuranceCategoryService()
        .getInsuranceCategory() as InsuranceCategoryModel;
    insuranceCategory.addAll(response.data);
  }
}
