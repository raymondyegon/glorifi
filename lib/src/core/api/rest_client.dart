import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart' as navigation;
import 'package:glorifi/src/app.dart';
import 'package:glorifi/src/core/api/app_lock_interceptor.dart';
import 'package:glorifi/src/core/api/pretty_dio_logger.dart';
import 'package:glorifi/src/core/data_helper.dart';
import 'package:glorifi/src/core/exceptions/custom_exception.dart';
import 'package:glorifi/src/core/logger.dart';
import 'package:glorifi/src/feature/onboard/login/controllers/token_refresh_mixin.dart';
import 'package:glorifi/src/routes/app_pages.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class RestClient {
  final String _endPoint;
  late Dio _dio;

  final connectTimeout = 30000;

  RestClient(this._endPoint) {
    var options = BaseOptions(
      baseUrl: _endPoint,
      connectTimeout: connectTimeout,
      receiveTimeout: 30000,
    );

    _dio = Dio(options);
  }

  void setRequestTimeout(int timeout) {
    _dio.options.connectTimeout = timeout;
  }

  void resetRequestTimeout() {
    _dio.options.connectTimeout = connectTimeout;
  }

  Future<Response<dynamic>> get(
    Api api,
    String path, {
    Map<String, dynamic>? data,
    Map<String, dynamic>? headers,
  }) async {
    _setDioInterceptorList(api);

    final standardHeaders = await _getOptions(api);
    if (headers != null) {
      standardHeaders.headers?.addAll(headers);
    }

    return _dio
        .get(path, queryParameters: data, options: standardHeaders)
        .then((value) => value)
        .catchError(_getDioException);
  }

  Future<Response<dynamic>> post(
    Api api,
    String path,
    Map<String, dynamic> data, {
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParams,
  }) async {
    _setDioInterceptorList(api);

    final standardHeaders = await _getOptions(api);
    if (headers != null) {
      standardHeaders.headers?.addAll(headers);
    }

    return _dio
        .post(path,
            data: data, options: standardHeaders, queryParameters: queryParams)
        .then((value) => value)
        .catchError(_getDioException);
  }

  Future<Response<dynamic>> patch(
    Api api,
    String path,
    Map<String, dynamic> data, {
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParams,
  }) async {
    _setDioInterceptorList(api);

    final standardHeaders = await _getOptions(api);
    if (headers != null) {
      standardHeaders.headers?.addAll(headers);
    }

    return _dio
        .patch(path,
            data: data, options: standardHeaders, queryParameters: queryParams)
        .then((value) => value)
        .catchError(_getDioException);
  }

  Future<Response<dynamic>> postFormData(
    Api api,
    String path,
    FormData formData, {
    Map<String, dynamic>? headers,
  }) async {
    _setDioInterceptorList(api);

    final standardHeaders = await _getOptions(api);
    if (headers != null) {
      standardHeaders.headers?.addAll(headers);
    }

    return _dio
        .post(
          path,
          data: formData,
          options: standardHeaders,
        )
        .then((value) => value)
        .catchError(_getDioException);
  }

  Future<Response<dynamic>> put(
    Api api,
    String path, {
    Map<String, dynamic>? data,
    Map<String, dynamic>? headers,
  }) async {
    _setDioInterceptorList(api);

    final standardHeaders = await _getOptions(api);
    if (headers != null) {
      standardHeaders.headers?.addAll(headers);
    }

    return _dio
        .put(path, data: data, options: standardHeaders)
        .then((value) => value)
        .catchError(_getDioException);
  }

  Future<Response<dynamic>> delete(Api api, String path,
      {Map<String, dynamic>? data, Map<String, dynamic>? headers}) async {
    _setDioInterceptorList(api);

    final standardHeaders = await _getOptions(api);
    if (headers != null) {
      standardHeaders.headers?.addAll(headers);
    }

    return _dio
        .delete(path, data: data, options: standardHeaders)
        .then((value) => value)
        .catchError(_getDioException);
  }

  Future<Response<dynamic>> downloadFile(
    Api api,
    String path,
    String fileToBeSavedPath, {
    Map<String, dynamic>? headers,
  }) async {
    _setDioInterceptorList(api);

    final standardHeaders = await _getOptions(api);
    if (headers != null) {
      standardHeaders.headers?.addAll(headers);
    }

    return _dio
        .download(path, fileToBeSavedPath, options: standardHeaders)
        .then((value) => value)
        .catchError(_getDioException);
  }

  Future<Options> _getOptions(Api api) async {
    final apiToken = await DataHelperImpl.instance.cacheHelper.getAccessToken();

    switch (api) {
      case Api.public:
        return PublicApiOptions().options;
      case Api.protected:
        return ProtectedApiOptions(apiToken).options;
    }
  }

  dynamic _getDioException(error) {
    if (error is DioError) {
      Log.error(
          'DIO ERROR: ${error.type} ENDPOINT: ${error.requestOptions.baseUrl} - ${error.requestOptions.path}');
      switch (error.type) {
        case DioErrorType.cancel:
          throw RequestCancelledException(
              001, 'Something went wrong. Please try again.');
        case DioErrorType.connectTimeout:
          throw RequestTimeoutException(
              408, 'Could not connect to the server.');
        case DioErrorType.other:
          throw DefaultException(
              002, 'Something went wrong. Please try again.');
        case DioErrorType.receiveTimeout:
          throw ReceiveTimeoutException(
              004, 'Could not connect to the server.');
        case DioErrorType.sendTimeout:
          throw RequestTimeoutException(
              408, 'Could not connect to the server.');

        case DioErrorType.response:
          final errorMessage = error.response?.data['message'];
          switch (error.response?.statusCode) {
            case 400:
              throw CustomException(400, jsonEncode(error.response?.data), "");
            case 403:
              final message = errorMessage ?? '${error.response?.data}';
              throw UnauthorisedException(error.response?.statusCode, message);
            case 401:
              final message = errorMessage ?? '${error.response?.data}';
              throw UnauthorisedException(error.response?.statusCode, message);
            case 404:
              throw NotFoundException(
                  404, errorMessage ?? error.response?.data.toString());
            case 409:
              throw ConflictException(
                  409, 'Something went wrong. Please try again.');
            case 408:
              throw RequestTimeoutException(
                  408, 'Could not connect to the server.');
            case 431:
              throw CustomException(431, jsonEncode(error.response?.data), "");
            case 437:
              throw CustomException(437, jsonEncode(error.response?.data), "");
            case 500:
              throw InternalServerException(
                  500, 'Something went wrong. Please try again.');
            default:
              throw DefaultException(0002,
                  errorMessage ?? 'Something went wrong. Please try again.');
          }
      }
    } else {
      throw UnexpectedException(000, 'Something went wrong. Please try again.');
    }
  }

  void _setDioInterceptorList(Api api) {
    List<Interceptor> interceptorList = [];

    _dio.interceptors.clear();
    _dio.interceptors.add(AppLockInterceptor());
    if (kDebugMode) {
      interceptorList.add(PrettyDioLogger());
    }
    // TODO: We need better control of environemnts, and Alice should only be included on non-prod builds
    // Letting this through on all builds since kDebug == False on the QA/beta builds currently sent out - WC
    interceptorList.add(alice.getDioInterceptor());

    if (api == Api.protected) {
      interceptorList.add(_getInterceptorForProtectedApi());
    }

    _dio.interceptors.addAll(interceptorList);
  }

  Interceptor _getInterceptorForProtectedApi() {
    return InterceptorsWrapper(onRequest: (request, handler) async {
      await DataHelperImpl.instance.cacheHelper
          .getAccessToken()
          .then((value) async {
        printInfo(info: "APITOKEN%^&*(*&^%%^&*&^%%^&*: $value");
        if (!value.isEmpty) {
          if (JwtDecoder.isExpired(value)) {
            if (kIsWeb) {
              return;
            }
            TokenRefresher tokenRefresher =
                TokenRefresher(onTokenExchangeError: (error) {
              navigation.Get.offAllNamed(Routes.login);
              return handler
                  .reject(DioError(requestOptions: RequestOptions(path: '')));
            }, onTokenExchangeSuccess: (response) {
              if (response["access_token"] != null) {
                final newAccessToken = response["access_token"] as String?;
                final refreshToken = response["refresh_token"] as String?;
                DataHelperImpl.instance.cacheHelper
                    .saveAccessToken(newAccessToken!);
                DataHelperImpl.instance.cacheHelper
                    .saveRefreshToken(refreshToken!);
                request.headers['Authorization'] = 'Bearer $newAccessToken';
                return handler.next(request);
              }
            });
            await tokenRefresher.getAccessTokenFromRefreshToken();
          } else {
            request.headers['Authorization'] = 'Bearer $value';
            return handler.next(request);
          }
        } else {
          // request.headers['Authorization'] = 'Bearer $value';
          var token;
          Future.delayed(
              Duration(seconds: 4),
              await DataHelperImpl.instance.cacheHelper
                  .getAccessToken()
                  .then((value) {
                token = value;
              }));
          request.headers['Authorization'] = 'Bearer $value';
          return handler.next(request);
        }
      });
    });
  }
}

abstract class ApiOptions {
  Options options = Options();
}

// Public API options need to be sent with public
class PublicApiOptions extends ApiOptions {
  PublicApiOptions() {
    super.options.headers = <String, dynamic>{
      'Accept': 'application/json',
    };
  }
}

// Protected API options need to be sent
class ProtectedApiOptions extends ApiOptions {
  ProtectedApiOptions(String apiToken) {
    super.options.headers = <String, dynamic>{
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $apiToken',
    };
  }
}

enum Api { public, protected }
