import 'dart:io';
import 'package:camera/camera.dart';
import 'package:glorifi/src/core/logger.dart';

import 'package:glorifi/src/structure/base_controller.dart';
import 'package:glorifi/src/utils/snackbar_util.dart';

class GloriFiCameraController extends BaseController {
  CameraController? _cameraController = null;
  CameraType? _cameraType;

  List<CameraDescription>? _cameras;

  get cameraController => _cameraController!;

  Future<void> init(CameraType cameraType) async {
    _cameraType = cameraType;
    await disposeCamera();
    _cameraController = await _generateCameraController();
    await _initCameraController();
  }

  Future<File?> takePhoto() async {
    try {
      XFile file = await _cameraController!.takePicture();
      return File(file.path);
    } catch (e) {
      Log.debug(e);
      showErrorToast('There was an unexpected error, please try again.');
    }
  }

  Future<void> disposeCamera() async {
    final CameraController? oldController = _cameraController;
    if (oldController != null) {
      _cameraController = null;
      await oldController.dispose();
    }
  }

  Future<CameraController> _generateCameraController() async {
    if (_cameras == null) {
      _cameras = await availableCameras();
    }
    return CameraController(
      _getCamera(_cameras!),
      ResolutionPreset.max,
      imageFormatGroup: ImageFormatGroup.jpeg,
    );
  }

  CameraDescription _getCamera(List<CameraDescription> cameras) {
    switch (_cameraType!) {
      case CameraType.FRONT:
        return cameras[1];
      case CameraType.BACK:
        return cameras[0];
    }
  }

  Future<void> _initCameraController()  async {
    try {
      await _cameraController!.initialize();
    } on CameraException catch (e) {
      switch (e.code) {
        case 'CameraAccessDenied':
          showErrorToast('You have denied camera access.');
          break;
        case 'CameraAccessDeniedWithoutPrompt':
          // iOS only
          showErrorToast('Please go to Settings app to enable camera access.');
          break;
        case 'CameraAccessRestricted':
          // iOS only
          showErrorToast('Camera access is restricted.');
          break;
        case 'AudioAccessDenied':
          showErrorToast('You have denied audio access.');
          break;
        case 'AudioAccessDeniedWithoutPrompt':
          // iOS only
          showErrorToast('Please go to Settings app to enable audio access.');
          break;
        case 'AudioAccessRestricted':
          // iOS only
          showErrorToast('Audio access is restricted.');
          break;
        case 'cameraPermission':
          // Android & web only
          showErrorToast('Unknown permission error.');
          break;
        default:
          if (e.description != null) {
            showErrorToast(e.description!);
          }
          break;
      }
    }
  }
}

enum CameraType { FRONT, BACK }
