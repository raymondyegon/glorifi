import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/controllers/camera/glorifi_camera_controller.dart';
import 'package:glorifi/src/core/logger.dart';
import 'package:glorifi/src/feature/credit_card_2/identity_check/controller/Identity_check_controller.dart';
import 'package:glorifi/src/utils/responsive/responsive.dart';

class CaptureWidget extends GetView<IdentityCheckController> {
  final CameraType cameraType;

  const CaptureWidget({required this.cameraType, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        builder: (IdentityCheckController identityCheckController) {
      return FutureBuilder<void>(
        future: controller.initCamera(cameraType),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Container(
              width: 342.w,
              height: 296.h,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.r),
                child: CameraPreview(controller.cameraController),
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      );
    });
  }
}
