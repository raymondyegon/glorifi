import 'package:dio/dio.dart';
import 'package:get/get.dart' as GetX;
import 'package:glorifi/src/utils/app_lock/app_lock_watchdog_service.dart';

class AppLockInterceptor extends InterceptorsWrapper{
  final AppLockWatchdogService _appLockService = GetX.Get.find();

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    notifyAppLock();
    return super.onError(err, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    notifyAppLock();
    return super.onResponse(response, handler);
  }

  notifyAppLock(){
    _appLockService.onApiCallDone();
  }
}