import '../../core/data_helper.dart';

class CheckLoginStatus {
  static final _dataHelper = DataHelperImpl.instance;

  static Future<bool> isLoggedIn() async {
    final currentAccessToken = await _dataHelper.cacheHelper.getAccessToken();
    final currentRefreshToken = await _dataHelper.cacheHelper.getRefreshToken();
    return currentAccessToken.isNotEmpty && currentRefreshToken.isNotEmpty;
  }

  static Future<void> checkLoginStatus(
      Function() loggedIn, Function() notLoggedIn) async {
    final currentAccessToken = await _dataHelper.cacheHelper.getAccessToken();
    final currentRefreshToken = await _dataHelper.cacheHelper.getRefreshToken();
    if (currentAccessToken.isNotEmpty && currentRefreshToken.isNotEmpty) {
      loggedIn.call();
    } else {
      notLoggedIn.call();
    }
  }
}
