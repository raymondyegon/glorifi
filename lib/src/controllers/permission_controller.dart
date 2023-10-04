import 'package:get/get.dart';
import 'package:glorifi/src/services/rewards_service.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionController extends GetxController {
  @override
  void onInit() async {
    checkPermissionStatus();
    super.onInit();
  }

  void checkPermissionStatus() async {
    PermissionStatus _cameraStatus = await Permission.camera.status;
    PermissionStatus _locationStatus = await Permission.location.status;
    PermissionStatus _galleryStatus = await Permission.photos.status;
    if (_cameraStatus == PermissionStatus.granted) {
      RewardsService.allowCameraAccess();
    }
    if (_locationStatus == PermissionStatus.granted) {
      RewardsService.allowLocationPermission();
    }
    if (_galleryStatus == PermissionStatus.granted ||
        _galleryStatus == PermissionStatus.limited) {
      RewardsService.allowCameraAccess();
    }
  }
}
