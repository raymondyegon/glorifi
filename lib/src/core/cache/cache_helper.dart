import 'package:glorifi/src/model/update_version_model.dart';

abstract class CacheHelper {
  Future<String> getAccessToken();

  Future<String> getRefreshToken();

  Future saveAccessToken(String token);

  Future saveRefreshToken(String token);

  Future clearTokens();

  Future<String> getUserInfo();

  Future saveUserInfo(String userInfo);

  Future updateSkipValueScreen(bool skipValueScreen);

  Future updateShowGlorifiStory(bool showGlorifiStory);

  Future<bool> skipValueScreen();

  Future<bool> showGlorifiStory();

  Future saveFAQCategories(Map<String, String> response);

  Future saveFAQAnswer(Map<String, String> answer);

  Future indexGems(Map<String, String> response);

  Future<Map<String, dynamic>> getFAQCategories();

  Future<Map<String, dynamic>> getFAQAnswer();

  Future<Map<String, dynamic>> getGemIndex();

  Future dismissActionCard(String cardKey);

  Future<bool?> wasActionCardDismissed(String cardKey);

  ///Returns 1-3, to show different splash images
  Future<int> getSplashBgNumber();

  Future<String> getUserEmail();

  Future saveUserEmail(String userInfo);

  Future<UpdateVersionModel> getUpdateVersion();

  Future<bool> saveUpdateVersion(UpdateVersionModel model);

  Future<bool> isPlaidSandboxEnvironment();

  Future savePlaidSandboxEnvironment(bool enabled);

  Future<bool> getUserTermsAcceptanceStatus();

  Future saveUserTermsAcceptance(bool enabled);

  Future requestedEarlyAccessForProduct(String product);
  Future<bool> getRequestedEarlyAccessForProduct(String product);
}
