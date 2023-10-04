import 'package:get/get.dart';
import 'package:glorifi/src/core/data_helper.dart';
import 'package:glorifi/src/model/account_flags_model.dart';

class SnapshotDataController extends GetxController with StateMixin {
  final _dataHelper = DataHelperImpl.instance;

  getLinkDataFlowData() async {
    var info = null;
    change('', status: RxStatus.loading());
    final response = await _dataHelper.apiHelper.getLinkDataFlowData();
    response.fold(
      (l) => change(l, status: RxStatus.error()),
      (r) {
        info = AccountFlagsModel.fromJson(r['data']);
        change(r, status: RxStatus.success());
      },
    );
    return info;
  }
}
