import 'package:get/get.dart';
import 'package:glorifi/src/core/data_helper.dart';
import 'package:glorifi/src/core/logger.dart';
import 'package:glorifi/src/model/personal_snapshot/net_worth_detail_model.dart';
import 'package:glorifi/src/utils/snackbar_util.dart';

class NetWorthDetailsService extends GetxService {
  NetWorthDetailsService();

  final _dataHelper = DataHelperImpl.instance;

  Future<NetWorthDetailModel?> getNetWorthDetails() async {
    final response = await _dataHelper.apiHelper.getNetWorthDetails();
    return response.fold((l) {
      Log.error(l.errorMessage);
      return null;
    }, (r) {
      return r;
    });
  }
}
