import 'package:get/get.dart';
import 'package:glorifi/src/core/data_helper.dart';
import 'package:glorifi/src/core/logger.dart';

class OtpService extends GetxService {
  OtpService();

  final _dataHelper = DataHelperImpl.instance;

  Future<dynamic> sendVerification() async {
    final response = await _dataHelper.apiHelper.otpMobileVerificationSend();
    return response.fold((l) {
      Log.error(l.errorMessage);
      return null;
    }, (r) {
      return r;
    });
  }

  Future<dynamic> resendVerification() async {
    final response = await _dataHelper.apiHelper.otpVerificationResend();
    return response.fold((l) {
      Log.error(l.errorMessage);
      return null;
    }, (r) {
      return r;
    });
  }

  Future<dynamic> verify({
    required String passCode,
  }) async {
    final response = await _dataHelper.apiHelper.otpVerificationVerify(
      passCode: passCode,
    );
    return response.fold((l) {
      Log.error(l.errorMessage);
      return null;
    }, (r) {
      return r;
    });
  }
}
