import 'package:get/get.dart';
import 'package:glorifi/src/core/data_helper.dart';
import 'package:glorifi/src/core/logger.dart';
import 'package:glorifi/src/model/members_model.dart';
import 'package:glorifi/src/structure/base_controller.dart';
import 'package:glorifi/src/utils/login_status/login_status.dart';

class MemberController extends BaseController {
  final _dataHelper = DataHelperImpl.instance;

  @override
  void onInit() async {
    CheckLoginStatus.isLoggedIn().then((value) {
      if (value) {
        getUserEmail();
      }
    });

    super.onInit();
  }

  Rx<MembersModels> _userEmail = MembersModels().obs;

  String? get member => _userEmail.value.data?.first.emailAddress;

  Future<void> getUserEmail() async {
    final response = await _dataHelper.apiHelper.getUserEmail();
    response.fold((l) {
      Log.error(l.errorMessage);
      throw l.errorMessage;
    }, (r) {
      _userEmail.value = r;
      return r;
    });
  }
}
