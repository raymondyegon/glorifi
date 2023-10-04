import 'package:dio/dio.dart';
import 'package:glorifi/src/core/logger.dart';

class LoggingInterceptor extends Interceptor {
  int _maxCharactersPerLine = 200;

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    Log.error(err.error);
    Log.error(err.message);
    return super.onError(err, handler);
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    Log.info(
        "ENDPOINT: ${options.baseUrl}${options.path}\nREQUEST-->\n\nMethod: ${options.method}\nHeaders: ${options.headers.toString()}\nRequest Data: ${options.data.toString()}\n\n<-- END HTTP");
    requestInterceptor(options).then((value) {
      options = value;
    });
    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    String responseData = "";
    responseData =
        "ENDPOINT: ${response.requestOptions.baseUrl}${response.requestOptions.path}\nRESPONSE-->\n\nHttp Code: ${response.statusCode}\nMethod: ${response.requestOptions.method}\n";

    String responseAsString = response.data.toString();
    if (responseAsString.length > _maxCharactersPerLine) {
      int iterations =
          (responseAsString.length / _maxCharactersPerLine).floor();
      for (int i = 0; i <= iterations; i++) {
        int endingIndex = i * _maxCharactersPerLine + _maxCharactersPerLine;
        if (endingIndex > responseAsString.length) {
          endingIndex = responseAsString.length;
        }
        responseData = responseData +
            responseAsString.substring(i * _maxCharactersPerLine, endingIndex);
      }
    } else {
      responseData =
          responseData + 'Response Data: ${response.data.toString()}';
    }

    responseData = responseData + "\n\n<-- END HTTP";
    Log.info(responseData);

    return super.onResponse(response, handler);
  }

  static Future<RequestOptions> requestInterceptor(
      RequestOptions options) async {
    // Get your AUTH token
    // const token = '';
    // options.headers.addAll({"Authorization": "Bearer: $token"});

    return options;
  }
}
