import 'package:get/get.dart';
import 'package:glorifi/src/core/data_helper.dart';
import 'package:glorifi/src/core/logger.dart';
import 'package:glorifi/src/model/personal_snapshot/savings_retirement_model.dart';

// class SavingsRetirementService extends GetxService {
//   SavingsRetirementService();

//   final _dataHelper = DataHelperImpl.instance;

//   Future<SavingsRetirementModel?> getSavingsRetirement() async {
//     final response = await _dataHelper.apiHelper.getRetirementSavings();
//     return response.fold((l) {
//       Log.error(l.errorMessage);
//       return null;
//     }, (r) {
//       return r;
//     });
//   }
// }
