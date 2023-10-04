import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/feature/banking/widgets/alert_dialog.dart';
import 'package:glorifi/src/structure/base_controller.dart';
import 'package:permission_handler/permission_handler.dart';

import '../settings_dialog.dart';

enum CheckPhotoType { front, back }

class DepositCheckCameraController extends BaseController {
  late CameraController? cameraController = null;
  late Future<void>? initializeControllerFuture = null;
  late bool isFlash;
  late String description;
  var analysisSuccessful = false.obs;

  CheckPhotoType checkPhotoType = CheckPhotoType.front;
  late Rx<XFile> frontCheckPhoto = XFile("").obs;
  late Rx<XFile> backCheckPhoto = XFile("").obs;

  @override
  void onInit() {
    super.onInit();
    isFlash = false;
    description = "Camera";
    initializeController();
  }

  @override
  void onClose() {
    cameraController?.dispose();
    super.onClose();
  }

  Future<void> initializeController() async {
    final cameras = await availableCameras();
    if (cameras.isNotEmpty) {
      cameraController = CameraController(
        cameras.first,
        ResolutionPreset.medium,
        imageFormatGroup: ImageFormatGroup.yuv420,
      );
      initializeControllerFuture = cameraController?.initialize();
    } else {
      debugPrint("No camera on this device");
    }
  }

  void toggleFlash() {
    isFlash
        ? cameraController?.setFlashMode(FlashMode.off)
        : cameraController?.setFlashMode(FlashMode.always);
    isFlash = !isFlash;
  }

  Future<void> takePhoto() async {
    analysisSuccessful.value = false;
    if (checkPhotoType == CheckPhotoType.front) {
      frontCheckPhoto.value = await cameraController!.takePicture();
    } else {
      backCheckPhoto.value = await cameraController!.takePicture();
    }
  }

  Future<void> permissionValidation(
      BuildContext context, String route, bool isFront) async {
    Permission permission = Permission.camera;
    Permission permissionAudio = Permission.microphone;
    PermissionStatus permissionStatus = await permission.status;
    PermissionStatus audioPermissionStatus = await permissionAudio.status;
    bool isIOS = Theme.of(context).platform == TargetPlatform.iOS;

    if (isIOS) {
      if (await Permission.camera.request().isDenied ||
          await Permission.camera.request().isLimited ||
          await Permission.microphone.request().isLimited ||
          await Permission.microphone.request().isDenied) {
        await [Permission.microphone, Permission.camera].request();
      }

      if (await Permission.camera.request().isGranted ||
          await Permission.camera.request().isLimited) {
        if (cameraController != null || cameraController!.value.isInitialized) {
          await initializeController();
          if (cameraExists()) {
            if (isFront) {
              description = "Front of Check";
              checkPhotoType = CheckPhotoType.front;
            }
            Get.toNamed(route);
          } else {
            showNoCameraSnackBar();
          }
        }
      }

      if (permissionStatus.isPermanentlyDenied ||
          audioPermissionStatus.isPermanentlyDenied) {
        showPermissionSettingsDialog(
            context, 'Allow GloriFi camera access to deposit checks.');
        return;
      }
    } else {
      if (permissionStatus == PermissionStatus.denied ||
          audioPermissionStatus == PermissionStatus.denied) {
        permissionStatus = await permission.request();
        audioPermissionStatus = await permissionAudio.request();
        if (permissionStatus == PermissionStatus.permanentlyDenied ||
            audioPermissionStatus == PermissionStatus.permanentlyDenied) {
          showPermissionSettingsDialog(
              context, 'Allow GloriFi camera access to deposit checks.');
          return;
        }
      }
    }

    if (permissionStatus == PermissionStatus.granted &&
        audioPermissionStatus == PermissionStatus.granted) {
      if (cameraController != null || cameraController!.value.isInitialized) {
        await initializeController();
        if (cameraExists()) {
          if (isFront) {
            description = "Front of Check";
            checkPhotoType = CheckPhotoType.front;
          }
          Get.toNamed(route);
        } else {
          showNoCameraSnackBar();
        }
      }
    }
  }

  bool cameraExists() {
    return cameraController != null;
  }

  void showNoCameraSnackBar() {
    ScaffoldMessenger.of(Get.context!).showSnackBar(
      SnackBar(
        content: Text(
          "No camera on device",
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Future<void> analyzeCheck() async {
    await Future.delayed(
        const Duration(seconds: 1), () {}); // TODO: Remove (verify simulation)
    analysisSuccessful.value =
        true; // TODO: Connect it with backend or analytics framework
    if (!analysisSuccessful.value) {
      glorifiAlertDialog(
          "Can’t recognize check image or information",
          """
The image might be blurry, cropped, or does not have enough lighting.

Take another picture of the check.

If the error continues, please contact customer service at 844-456-7434.""",
          "Dismiss");
    }
  }
}
