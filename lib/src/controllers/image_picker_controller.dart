import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/controllers/profile_controller.dart';
import 'package:glorifi/src/core/logger.dart';
import 'package:glorifi/src/services/rewards_service.dart';
import 'package:glorifi/src/services/upload_image_service.dart';
import 'package:glorifi/src/structure/base_controller.dart';
import 'package:glorifi/src/utils/image_compressor.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import '../feature/banking/deposit_check/settings_dialog.dart';

class ImagePickerController extends BaseController {
  final ImagePicker _picker = ImagePicker();

  RxString _imagePathController = "".obs;

  String get imagePath => _imagePathController.value;

  pickImageFromGallery(context) async {
    bool isIOS = Theme.of(context).platform == TargetPlatform.iOS;

    Permission permission = Permission.photos;
    PermissionStatus permissionStatus = await permission.status;

    if (isIOS) {
      if (await Permission.photos.request().isDenied ||
          await Permission.photos.request().isLimited) {
        await Permission.photos.request();
      }

      if (await Permission.photos.request().isGranted ||
          await Permission.photos.request().isLimited) {
        Get.back();
        final XFile? image =
            await _picker.pickImage(source: ImageSource.gallery);
        if (image != null) {
          onImageSelectionDone(image);
        }
      }

      if (permissionStatus.isPermanentlyDenied) {
        showPermissionSettingsDialog(
          context,
          'Allow GloriFi gallery access to upload profile picture.',
          sourceImage: Icons.photo_library_rounded,
        );
        return;
      }
    } else {
      if (permissionStatus == PermissionStatus.denied) {
        permissionStatus = await permission.request();
        if (permissionStatus == PermissionStatus.permanentlyDenied) {
          showPermissionSettingsDialog(
            context,
            'Allow GloriFi gallery access to upload profile picture',
            sourceImage: Icons.photo_library_rounded,
          );
          Get.back();
          return;
        }
      }
      if (permissionStatus == PermissionStatus.granted) {
        Get.back();
        final XFile? image =
            await _picker.pickImage(source: ImageSource.gallery);
        if (image != null) {
          onImageSelectionDone(image);
        }
      }
    }
  }

  pickImageFromCamera(BuildContext context) async {
    bool isIOS = Theme.of(context).platform == TargetPlatform.iOS;

    Permission permission = Permission.camera;
    PermissionStatus permissionStatus = await permission.status;

    if (isIOS) {
      if (await Permission.camera.request().isDenied ||
          await Permission.camera.request().isLimited) {
        await Permission.camera.request();
      }

      if (await Permission.camera.request().isGranted ||
          await Permission.camera.request().isLimited) {
        Get.back();
        final XFile? image =
            await _picker.pickImage(source: ImageSource.camera);
        if (image != null) {
          onImageSelectionDone(image);
        }
      }

      if (permissionStatus.isPermanentlyDenied) {
        showPermissionSettingsDialog(
            context, 'Allow GloriFi camera access to upload profile picture.');
        return;
      }
    } else {
      if (permissionStatus == PermissionStatus.denied) {
        permissionStatus = await permission.request();
        if (permissionStatus == PermissionStatus.permanentlyDenied) {
          showPermissionSettingsDialog(
              context, 'Allow GloriFi camera access to upload profile picture');
          Get.back();
          return;
        }
      }
      if (permissionStatus == PermissionStatus.granted) {
        Get.back();
        final XFile? image =
            await _picker.pickImage(source: ImageSource.camera);
        if (image != null) {
          onImageSelectionDone(image);
        }
      }
    }
  }

  onImageSelectionDone(XFile image) async {
    RewardsService.allowCameraAccess();
    File? croppedImage = await getCroppedImage(image);

    if (croppedImage != null) {
      //Reduce quality to 80% and make Max height to 512
      croppedImage = await getCompressedPicture(croppedImage);
      _imagePathController(croppedImage.path);
      uploadImage();
    }
  }

  Future<File?> getCroppedImage(image) async {
    return await ImageCropper().cropImage(
        sourcePath: image.path,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9
        ],
        androidUiSettings: AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.black,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        iosUiSettings: IOSUiSettings(
          minimumAspectRatio: 1.0,
        ));
  }

  uploadImage() async {
    ///todo profile completion percentage currently passed as static 'Need to be changed'.....
    final profileController = Get.find<ProfileController>();
    List<int> imageBytes = File(imagePath).readAsBytesSync();
    String base64Image = base64Encode(imageBytes);
    profileController.onProfilePictureUpdateSuccess(base64Image);
    final response = await UploadImageService()
        .uploadImage(imagePath: imagePath, profileCompletionPercentage: "50");
    Log.info(response.toString());
  }
}
