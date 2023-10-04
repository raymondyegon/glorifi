import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/widget_extensions.dart';
import 'package:glorifi/src/feature/banking/deposit_check/settings_dialog.dart';
import 'package:glorifi/src/feature/credit_card_2/apply_for_card/model/acc_screen_info_model.dart';
import 'package:glorifi/src/feature/credit_card_2/apply_for_card/widgets/acc_container.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/routes/app_pages.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive.dart';
import 'package:glorifi/src/utils/text_constants.dart';
import 'package:permission_handler/permission_handler.dart';

class ACCVerifyIdentityPart1 extends StatelessWidget {
  const ACCVerifyIdentityPart1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ACCContainer(
      info: ACCScreensInfo.ACCVerifyIdentityPart1,
      children: _contents(),
      onContinue: () async {
        Get.toNamed(Routes.captureIdFrontScreen);
      }
    );
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
          //Granted
      }

      if (permissionStatus.isPermanentlyDenied) {
        showPermissionSettingsDialog(
            context, TextConstants.access_glorifi_camera);
        return;
      }
    } else {
      if (permissionStatus == PermissionStatus.denied) {
        permissionStatus = await permission.request();
        if (permissionStatus == PermissionStatus.permanentlyDenied) {
          showPermissionSettingsDialog(
              context, TextConstants.access_glorifi_camera);
          Get.back();
          return;
        }
      }
      if (permissionStatus == PermissionStatus.granted) {
        //Granted
      }
    }
  }


  List<Widget> _contents() {
    String content =
        TextConstants.capture_id_image;
    return [
      Text(
        content,
        style: smallRegular16Primary(color: GlorifiColors.midnightBlue),
      ).paddingOnly(
        bottom: 56.h,
      ),
      Text(
        TextConstants.third_parties,
        style: captionRegular14Primary(color: GlorifiColors.black),
      ).paddingOnly(
        bottom: 88.h,
      ),
    ];
  }
}
