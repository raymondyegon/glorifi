import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/controllers/camera/glorifi_camera_controller.dart';
import 'package:glorifi/src/core/logger.dart';
import 'package:glorifi/src/feature/credit_card_2/apply_for_card/model/acc_screen_info_model.dart';
import 'package:glorifi/src/feature/credit_card_2/apply_for_card/widgets/acc_container.dart';
import 'package:glorifi/src/feature/credit_card_2/identity_check/controller/Identity_check_controller.dart';
import 'package:glorifi/src/feature/credit_card_2/identity_check/widgets/capture_widget.dart';
import 'package:glorifi/src/feature/credit_card_2/identity_check/widgets/captured_image_preview.dart';
import 'package:glorifi/src/routes/app_pages.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive.dart';
import 'package:glorifi/src/utils/snackbar_util.dart';
import 'package:glorifi/src/utils/text_constants.dart';
import 'package:glorifi/src/widgets/buttons/glorifi_outlined_button.dart';

class CaptureIdBackScreen extends GetView<IdentityCheckController> {
  CaptureIdBackScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ACCContainer(
        children: _content(),
        info: ACCScreensInfo.captureIdBackScreen,
        onContinue: () async {
          if (controller.isCaptureMoodInBackIdScreen.value) {
            showErrorToast("need to capture image");
          } else {
            Get.toNamed(Routes.captureSelfieScreen);
          }
        });
  }

  List<Widget> _content() {
    return [
      Container(
        width: 342.w,
        height: 296.h,
        child: Obx(
          () => controller.isCaptureMoodInBackIdScreen.value
              ? CaptureWidget(cameraType: CameraType.BACK)
              : CapturedImagePreview(
                  image: controller.idBackImage!,
                ),
        ),
      ).marginOnly(
        bottom: 30.h,
      ),
      Center(
        child: Obx(
          () => GlorifiOutlinedButton(
            title: controller.isCaptureMoodInBackIdScreen.value
                ? TextConstants.capture
                : TextConstants.retake,
            width: 200.w,
            height: 50.h,
            primaryColor: GlorifiColors.bgColor,
            borderColor: GlorifiColors.redError,
            onTap: () async {
              if (controller.isCaptureMoodInBackIdScreen.value) {
                await controller.takePhoto(ImageType.ID_BACK);
                controller.isCaptureMoodInBackIdScreen.value = false;
              } else {
                controller.update();
                controller.isCaptureMoodInBackIdScreen.value = true;
              }
            },
          ),
        ),
      ),
    ];
  }
}
