import 'package:get/get.dart';
import 'package:glorifi/src/core/data_helper.dart';
import 'package:glorifi/src/core/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthenticationService extends GetxService {
  late String guid;
  late String token;
  String? verifyOtpUrl;

  AuthenticationService();

  final _dataHelper = DataHelperImpl.instance;

  Future<String?> verify({
    required String emailAddress,
    required String firstName,
    required String lastName,
    required String zip,
    required String birthDate,
    required String phoneNumber,
    String? preferredName,
    String? middleName,
  }) async {
    // Build map of data expected by API
    Map<String, dynamic> data = {
      "email_address": emailAddress,
      "name_first": firstName,
      "name_last": lastName,
      "birth_date": birthDate,
      "address_postal_code": zip,
      "phone_number": phoneNumber,
      if (preferredName != null && preferredName.isNotEmpty)
        "preferred_name": preferredName,
      if (middleName != null && middleName.isNotEmpty) "name_middle": middleName
    };
    final response = await _dataHelper.apiHelper.executeRegister(data);
    response.fold((l) {
      Log.error(l.errorMessage);
      throw l.errorMessage;
    }, (r) {
      return r;
    });
  }

  Future<bool?> savePersonalDetail({
    required String fieldName, // e.g. PersonalDetails.emailAddress
    required String value, // e.g. example.gmail.com
  }) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _prefs.setString(fieldName, value);
  }

  Future sentOtpPhone() async {
    final response = await _dataHelper.apiHelper.sentOtpPhone();
    return response.fold(
      (l) {
        Log.error(l.errorMessage);
        throw l.errorMessage;
      },
      (r) {
        return r;
      },
    );
  }

  Future editPhoneNumber(String mobile) async {
    final response = await _dataHelper.apiHelper.editPhoneNumber(mobile);
    return response.fold(
      (l) {
        Log.error(l.errorMessage);
        throw l.errorMessage;
      },
      (r) {
        return r;
      },
    );
  }

  Future sendOtp(String email) async {
    final response = await _dataHelper.apiHelper.sendOtp(email);
    return response.fold(
      (l) {
        Log.error(l.errorMessage);
        throw l.errorMessage;
      },
      (r) {
        return r;
      },
    );
  }

  Future verifyOtp({required String email, String otp = ""}) async {
    final response = await _dataHelper.apiHelper.verifyOtp(email, otp);
    return response.fold(
      (l) {
        Log.error(l.errorMessage);
        throw l.errorMessage;
      },
      (r) {
        return r;
      },
    );
  }

  Future verifyOtpMobile(String otp) async {
    final response = await _dataHelper.apiHelper.verifyOtpMobile(otp);
    return response.fold(
      (l) {
        Log.error(l.errorMessage);
        throw l.errorMessage;
      },
      (r) {
        return r;
      },
    );
  }

  Future<bool> verifyZipCode(String zipCode) async {
    final isValidZip = await _dataHelper.apiHelper.verifyZipCode(zipCode);
    return await isValidZip.fold(
      (l) {
        Log.error(l.errorMessage);

        return false;
      },
      (r) {
        return r;
      },
    );
  }
}
