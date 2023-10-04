import 'package:get/get.dart';
import 'package:glorifi/src/core/data_helper.dart';
import 'package:glorifi/src/core/logger.dart';

class ComingSoonService extends GetxService {
  ComingSoonService();

  final _dataHelper = DataHelperImpl.instance;

  Future<Map<String, dynamic>?> notifyEmail(
      String product, String state) async {
    final response = await _dataHelper.apiHelper.notifyEmail(product, state);

    return response.fold((l) {
      Log.error(l.errorMessage);
    }, (r) {
      return r;
    });
  }
}
