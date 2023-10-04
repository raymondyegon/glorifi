import 'dart:io';

import 'package:app_settings/app_settings.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/controllers/local_auth_controller.dart';
import 'package:glorifi/src/core/cache/cache_client.dart';
import 'package:glorifi/src/core/cache/cache_keys.dart';
import 'package:glorifi/src/services/rewards_service.dart';
import 'package:local_auth/local_auth.dart';

class DeviceSettingsController extends GetxController {
  final _faceIdController = false.obs;

  bool get biometricEnabled => _faceIdController.value;

  final _deviceBioMetricTitleController = "".obs;

  String get biometricTitle => _deviceBioMetricTitleController.value;

  final _deviceBiometricStatusController = false.obs;

  bool get deviceHasBiometric => _deviceBiometricStatusController.value;

  final _locationStatusController = false.obs;

  bool get locationStatus => _locationStatusController.value;

  bool permissionAskedFromApp = false;

  final CacheClient _cacheClient = CacheClient();

  @override
  void onInit() async {
    initDeviceSettings();
    super.onInit();
  }

  initDeviceSettings() async {
    _checkBiometric();
    _checkLocation();
  }

  Future<bool> _checkLocationPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();
    return locationPermissionGranted(permission);
  }

  bool locationPermissionGranted(LocationPermission permission) =>
      permission == LocationPermission.always ||
      permission == LocationPermission.whileInUse;

  _checkBiometric() async {
    _deviceBiometricStatusController(
        await LocalAuth.checkDeviceIfHasLocalBio());

    await LocalAuth.getAvailableBiometrics();
    var biometricTitle = await _cacheClient.getString(CacheKeys.biometricTypeKey);

    _deviceBioMetricTitleController(biometricTitle);

    final bool? isLocalBioEnable = await LocalAuth.isLocalBioEnabled();
    _faceIdController(isLocalBioEnable == true);
  }

  _checkLocation() async {
    final serviceEnabled = await _checkLocationPermission();
    _locationStatusController(serviceEnabled);
  }

  openLocationSettings() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied && !permissionAskedFromApp) {
      permission = await Geolocator.requestPermission();
      permissionAskedFromApp = true;
      if (permission == LocationPermission.always ||
          permission == LocationPermission.whileInUse) {
        RewardsService.allowLocationPermission();
      }
      return;
    } else {
      await Geolocator.openAppSettings();
    }
  }

  openBiometricSettings() async {
    if (Platform.isIOS) {
      await AppSettings.openAppSettings();
    } else {
      await AppSettings.openSecuritySettings();
    }
  }
}
