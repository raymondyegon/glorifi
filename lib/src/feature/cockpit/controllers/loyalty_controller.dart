import 'package:get/get.dart';
import 'package:glorifi/src/core/base/urls.dart';
import 'package:glorifi/src/core/data_helper.dart';
import 'package:glorifi/src/structure/base_controller.dart';
import 'package:intl/intl.dart';

class LoyaltyController extends BaseController {
  final DataHelper _dataHelper = DataHelperImpl.instance;
  NumberFormat myFormat = NumberFormat.decimalPattern('en_us');

  final _currentBalance = 0.obs;
  int get currentBalance => _currentBalance.value;
  String get currentBalanceString => myFormat.format(currentBalance);

  final _currentTier = ''.obs;
  String get currentTier => _currentTier.value;

  @override
  void onInit() {
    fetchPoints();
    _fetchTier();
    super.onInit();
  }

  Future<void> fetchPoints() async {
    final response = await _dataHelper.apiHelper.getRewardsBalance();
    response.fold((l) {
      // TODO: Handle failure
    }, (r) {
      _currentBalance.value = r;
    });
  }

  void _fetchTier() async {
    final response = await _dataHelper.apiHelper.getRewardsTier();
    response.fold((error) {
      // TODO: Handle this
    }, (success) {
      change(_currentTier(success), status: RxStatus.success());
    });
  }

  Future<String?> generateRewardLink() async {
    final response = await _dataHelper.apiHelper.getRewardsSessionToken();
    return response.fold((l) => null, (r) {
      return "${Urls.rewardsBaseUrl}/#/sso/${r}";
    });
  }

  updateCurrentBalance(int newBalance) {
    change(_currentBalance(newBalance),
        status: RxStatus.success());
  }
}
