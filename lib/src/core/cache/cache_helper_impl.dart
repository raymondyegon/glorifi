import 'package:glorifi/src/core/cache/cache_client.dart';
import 'package:glorifi/src/core/cache/cache_helper.dart';
import 'package:glorifi/src/core/cache/cache_keys.dart';
import 'package:glorifi/src/model/update_version_model.dart';

import '../../utils/constants.dart';

class CacheHelperImpl extends CacheHelper {
  CacheHelperImpl(this._cache);

  final CacheClient _cache;

  @override
  Future<String> getAccessToken() {
    return _cache.getString(CacheKeys.token);
  }

  @override
  Future<String> getUserInfo() {
    return _cache.getString(CacheKeys.userInfo);
  }

  @override
  Future saveAccessToken(String token) {
    return _cache.putString(CacheKeys.token, token);
  }

  @override
  Future saveRefreshToken(String token) {
    return _cache.putString(CacheKeys.refreshToken, token);
  }

  @override
  Future clearTokens() async {
    await saveAccessToken('');
    await saveRefreshToken('');
  }

  @override
  Future saveUserInfo(String userInfo) {
    return _cache.putString(CacheKeys.userInfo, userInfo);
  }

  @override
  Future<String> getRefreshToken() {
    return _cache.getString(CacheKeys.refreshToken);
  }

  ///Returns a value to check if the app needs to show/skip
  ///the value screens
  @override
  Future<bool> skipValueScreen() async {
    final shouldShow = await _cache.getBool(CacheKeys.skipValueScreen);
    return shouldShow == true;
  }

  ///This method update the value to show/skip
  ///value screen when a user open the app
  ///[skipValueScreen] true to show the value screen
  ///[skipValueScreen] false to hide the value screen
  @override
  Future updateSkipValueScreen(bool skipValueScreen) {
    return _cache.putBool(CacheKeys.skipValueScreen, skipValueScreen);
  }

  @override
  Future<bool> showGlorifiStory() async {
    final shouldShow = await _cache.getBool(CacheKeys.showGlorifiStory);
    return shouldShow != false;
  }

  @override
  Future updateShowGlorifiStory(bool showGlorifiStory) {
    return _cache.putBool(CacheKeys.showGlorifiStory, showGlorifiStory);
  }

  @override
  Future saveFAQCategories(Map<String, String> response) {
    return _cache.putJsonObject(faqCategoriesKey, response);
  }

  @override
  Future<Map<String, dynamic>> getFAQCategories() {
    return _cache.getJsonObject(faqCategoriesKey);
  }

  @override
  Future indexGems(Map<String, String> response) {
    return _cache.putJsonObject(gemIndexingKey, response);
  }

  @override
  Future<Map<String, dynamic>> getGemIndex() {
    return _cache.getJsonObject(gemIndexingKey);
  }

  @override
  Future dismissActionCard(String cardKey) {
    return _cache.putBool(cardKey, true);
  }

  @override
  Future<bool?> wasActionCardDismissed(String cardKey) {
    return _cache.getBool(cardKey);
  }

  @override
  Future<int> getSplashBgNumber() async {
    int splashImageNo = await _cache.getInt(CacheKeys.splashScreenImageNo);
    await _cache.putInt(CacheKeys.splashScreenImageNo, (++splashImageNo) % 3);
    return splashImageNo;
  }

  @override
  Future saveUserEmail(String email) {
    return _cache.putString(CacheKeys.userEmail, email);
  }

  @override
  Future<String> getUserEmail() {
    return _cache.getString(CacheKeys.userEmail);
  }

  @override
  Future<bool> isPlaidSandboxEnvironment() async {
    final result = await _cache.getBool(CacheKeys.plaidEnvironmentKey);
    return result == true;
  }

  @override
  Future savePlaidSandboxEnvironment(bool enabled) {
    return _cache.putBool(CacheKeys.plaidEnvironmentKey, enabled);
  }

  @override
  Future<UpdateVersionModel> getUpdateVersion() async {
    final result = await _cache.getJsonObject(CacheKeys.splashVersionCheck);
    return UpdateVersionModel.fromJson(result);
  }

  @override
  Future<bool> saveUpdateVersion(UpdateVersionModel model) async {
    final result = await _cache.putJsonObject(
        CacheKeys.splashVersionCheck, model.toJson());
    return result;
  }

  Future saveUserTermsAcceptance(bool accepted) {
    return _cache.putBool(CacheKeys.termsAcceptance, accepted);
  }

  @override
  Future<bool> getUserTermsAcceptanceStatus() async {
    final shouldShow = await _cache.getBool(CacheKeys.termsAcceptance);
    return shouldShow == true;
  }

  @override
  Future<Map<String, dynamic>> getFAQAnswer() {
    return _cache.getJsonObject(faqAnswerKey);
  }

  @override
  Future saveFAQAnswer(Map<String, String> answer) {
    return _cache.putJsonObject(faqAnswerKey, answer);
  }

  @override
  Future requestedEarlyAccessForProduct(String product) {
    return _cache.putBool('reqEarlyAccess${product}', true);
  }

  @override
  Future<bool> getRequestedEarlyAccessForProduct(String product) async {
    return await _cache.getBool('reqEarlyAccess${product}') ?? false;
  }
}
