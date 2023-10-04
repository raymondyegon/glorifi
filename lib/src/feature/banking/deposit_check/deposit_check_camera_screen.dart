import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/feature/banking/deposit_check/controller/deposit_check_camera_controller.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/routes/app_pages.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_widgets/adaptive_scaffold.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive_extensions.dart';

class DepositCheckCameraScreen extends GetView<DepositCheckCameraController> {
  const DepositCheckCameraScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: FutureBuilder<void>(
        future: controller.initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // If the Future is complete, display the preview.
            var scale = Get.size.aspectRatio *
                controller.cameraController!.value.aspectRatio;
            scale = (scale < 1) ? 1 / scale : scale;
            return AdaptiveScaffold(
              body: Stack(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      width: Get.width,
                      height: Get.height,
                      child: Transform.scale(
                        scale: scale,
                        child: Center(
                          child: CameraPreview(controller.cameraController!),
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                        margin: EdgeInsets.only(left: 12.w, right: 12.w),
                        height: 182.h,
                        width: 34.w,
                        decoration: BoxDecoration(
                          color: GlorifiColors.white,
                          borderRadius: BorderRadius.all(Radius.circular(4.sp)),
                        ),
                        child: RotatedBox(
                          quarterTurns: 1,
                          child: Center(
                            child: Text(
                              controller.description,
                              textAlign: TextAlign.center,
                              style: bodyRegular18Secondary(
                                  color: GlorifiColors.black),
                            ),
                          ),
                        )),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      height: 577.h,
                      width: 274.w,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: GlorifiColors.white,
                          width: 1.w,
                        ),
                      ),
                    ),
                  ),
                  Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        height: 134.h,
                        width: Get.width - 73.w * 2,
                        color: Colors.transparent,
                        child: RotatedBox(
                          quarterTurns: 1,
                          child: Column(
                            children: <Widget>[
                              _buildCameraButton(
                                () => controller.toggleFlash(),
                                "Turn on\nLight",
                                GlorifiColors.white,
                              ),
                              _buildCameraButton(
                                () async {
                                  await controller.takePhoto();
                                  Get.until((route) =>
                                      Get.currentRoute == Routes.mobileDeposit);
                                  controller.analyzeCheck();
                                },
                                "Capture",
                                GlorifiColors.biscayBlue,
                                bgColor: GlorifiColors.white,
                              ),
                              _buildCameraButton(
                                () => Get.until((route) =>
                                    Get.currentRoute == Routes.mobileDeposit),
                                "Cancel",
                                GlorifiColors.cameraCancelRed,
                              ),
                            ],
                          ),
                        ),
                      )),
                ],
              ),
            );
          } else {
            // Otherwise, display a loading indicator.
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Widget _buildCameraButton(
      void Function()? onTapCallback, String text, Color textColor,
      {Color bgColor = Colors.transparent}) {
    return Expanded(
      child: Align(
        alignment: Alignment.center,
        child: GestureDetector(
          onTap: onTapCallback,
          child: Container(
            alignment: Alignment.center,
            height: 76.h,
            width: 76.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: bgColor,
            ),
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: captionRegular14Secondary(color: textColor),
            ),
          ),
        ),
      ),
    );
  }
}
