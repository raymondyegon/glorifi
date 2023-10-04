import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/feature/banking/deposit_check/controller/deposit_check_camera_controller.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/routes/app_pages.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_widgets/adaptive_scaffold.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive_extensions.dart';
import 'package:glorifi/src/widgets/buttons/primary_button.dart';

class BackCheckPhotoConfirmation extends StatelessWidget {
  const BackCheckPhotoConfirmation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: AdaptiveScaffold(
        body: RotatedBox(
          quarterTurns: 1,
          child: Center(
            child: _buildBody(),
          ),
        ),
      ),
    );
  }

  Widget _buildBody() {
    return Column(
      children: [
        SizedBox(height: 105.h),
        Text(
          "Please ensure you have signed the back of the check.",
          textAlign: TextAlign.center,
          style: headlineRegular20Secondary(color: GlorifiColors.black),
        ),
        SizedBox(height: 25.h),
        Container(
          width: 510.w,
          child: Text(
            "Ensure you have written the following on the back of the check 'For mobile deposit only.'",
            textAlign: TextAlign.center,
            style: headlineRegular20Secondary(color: GlorifiColors.black),
          ),
        ),
        SizedBox(height: 59.h),
        PrimaryButton(
          title: "Take Photo",
          width: 335.w,
          height: 64.h,
          primaryColor: GlorifiColors.primaryButtonProgressColor,
          textColor: GlorifiColors.superLightGrey,
          hasRightArrow: true,
          onTap: _triggerCamera,
        ),
      ],
    );
  }

  Future<void> _triggerCamera() async {
    var cameraController = Get.put(DepositCheckCameraController());
    cameraController.description = "Back of Check";
    cameraController.checkPhotoType = CheckPhotoType.back;
    Get.toNamed(Routes.checkDepositCamera);
  }
}
