import 'package:dartz/dartz.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_disposable.dart';
import 'package:glorifi/src/core/data_helper.dart';
import 'package:glorifi/src/core/exceptions/custom_exception.dart';

// ignore: camel_case_types
class OKTA_APIService extends GetxService {
  late String accessToken;

  OKTA_APIService();

  final _dataHelper = DataHelperImpl.instance;

  Future<Either<CustomException, dynamic>> getAccessToken({
    required String grant_type,
    required String client_id,
    required String scope,
    required String refresh_token,
  }) async {
    // Build map of data expected by API
    return _dataHelper.apiHelper.getAccessTokenForOkta(refresh_token);
  }
}
