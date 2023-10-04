import 'dart:async';
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/controllers/camera/glorifi_camera_controller.dart';
import 'package:glorifi/src/structure/base_controller.dart';
import 'package:glorifi/src/utils/snackbar_util.dart';

class IdentityCheckController extends BaseController {
  var glorifiCameraController = Get.find<GloriFiCameraController>();

  File? idFrontImage;
  File? idBackImage;
  File? selfie;

  RxBool isCaptureMoodInFrontIdScreen = true.obs;
  RxBool isCaptureMoodInBackIdScreen = true.obs;
  RxBool isCaptureMoodInSelfieScreen = true.obs;

  Future<void> initCamera(CameraType cameraType) async {
    await glorifiCameraController.init(cameraType);
  }

  CameraController get cameraController =>
      glorifiCameraController.cameraController;

  takePhoto(ImageType imageType) async {
    var file = await glorifiCameraController.takePhoto();
    cacheImage(file!, imageType);
  }

  void cacheImage(File file, ImageType imageType) {
    switch (imageType) {
      case ImageType.ID_FRONT:
        idFrontImage = file;
        break;
      case ImageType.ID_BACK:
        idBackImage = file;
        break;
      case ImageType.SELFIE:
        selfie = file;
        break;
    }
    showSnackBar("Image captured !");
  }
}

enum ImageType { ID_FRONT, ID_BACK, SELFIE }
