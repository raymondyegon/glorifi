import 'package:get/get.dart';
import 'package:glorifi/src/core/data_helper.dart';
import 'package:glorifi/src/core/logger.dart';
import 'package:glorifi/src/feature/banking/model/connected_account_model.dart';
import 'package:glorifi/src/utils/snackbar_util.dart';

class ConnectedAccountsService extends GetxService {
  ConnectedAccountsService();

  final _dataHelper = DataHelperImpl.instance;

  Future<ConnectedAccountModel?> getConnectedAccounts() async {
    final response = await _dataHelper.apiHelper.getConnectedAccounts();
    return response.fold((l) {
      Log.error(l.errorMessage);
      apiExceptionMessage(l.errorCode);
      return null;
    }, (r) {
      return r;
    });
  }
}
