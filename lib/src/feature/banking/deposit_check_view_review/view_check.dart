import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/feature/banking/deposit_check_view_review/controller/deposited_check_images_controller.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/routes/app_pages.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_widgets/adaptive_scaffold.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive_extensions.dart';
import 'package:glorifi/src/widgets/appbars/glorifi_appbar.dart';
import 'package:photo_view/photo_view.dart';

class ViewCheck extends GetView<DepositedCheckImagesController> {
  ViewCheck({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AdaptiveScaffold(
        appBar: GlorifiAppBar(
          title: 'Check Photo',
        ),
        body: Obx(
          () => Stack(
            children: [
              PhotoView(
                enableRotation: true,
                initialScale: PhotoViewComputedScale.contained * 0.9,
                backgroundDecoration: BoxDecoration(color: GlorifiColors.grey),
                imageProvider: AssetImage(
                    controller.activeButton.value == ButtonType.FRONT
                        ? controller.image['frontImage']
                        : controller.image['backImage']),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 20.h),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildSwitchButton(ButtonType.FRONT),
                      SizedBox(
                        width: 10.w,
                      ),
                      _buildSwitchButton(ButtonType.BACK),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 8.h, horizontal: 8.w),
                        child: IconButton(
                            onPressed: () {
                              Get.toNamed(Routes.checkPrint, arguments: {
                                'image': controller.activeButton.value ==
                                        ButtonType.FRONT
                                    ? controller.image['frontImage']
                                    : controller.image['backImage'],
                              });
                            },
                            icon: Icon(
                              Icons.print,
                              color: GlorifiColors.primaryDarkButtonColor,
                            )),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  ButtonStyle _getButtonStyle(bool isButtonActive) {
    return ButtonStyle(
        foregroundColor: MaterialStateProperty.all<Color>(isButtonActive
            ? GlorifiColors.white
            : GlorifiColors.primaryDarkButtonColor),
        backgroundColor: MaterialStateProperty.all<Color>(isButtonActive
            ? GlorifiColors.primaryDarkButtonColor
            : GlorifiColors.white),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.r),
                side: BorderSide(
                    color: isButtonActive
                        ? GlorifiColors.primaryDarkButtonColor
                        : GlorifiColors.white))));
  }

  ElevatedButton _buildSwitchButton(ButtonType buttonType) {
    return ElevatedButton(
      style: _getButtonStyle(controller.activeButton.value == buttonType),
      onPressed: () {
        controller.activeButton.value = buttonType;
      },
      child: Text(
        buttonType == ButtonType.FRONT ? "Front" : "Back",
        style: captionBold14Primary(),
      ),
    );
  }
}
