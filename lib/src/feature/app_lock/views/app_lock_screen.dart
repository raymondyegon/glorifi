import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/feature/app_lock/controllers/app_lock_controller.dart';
import 'package:glorifi/src/utils/glorifi_assets.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/glorifi_logos.dart';
import 'package:glorifi/src/utils/responsive/responsive_extensions.dart';
import 'package:glorifi/src/utils/text_constants.dart';
import 'package:glorifi/src/widgets/buttons/primary_button.dart';
import 'package:glorifi/src/widgets/containers/gradient_overlay_container.dart';
import 'package:glorifi/src/widgets/containers/loading_container.dart';

class AppLockScreen extends GetView<AppLockController> {
  const AppLockScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: GlorifiColors.productsBgWhite,
        body: Stack(
          children: [
            _background(),
            SafeArea(
              child: LoadingContainer(
                loadingControllers: [controller.pageState],
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(30.sp),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _logo(),
                      Spacer(),
                      Obx(() => PrimaryButton(
                            title: controller.biometricTitle,
                            width: null,
                            onTap: controller.onTapBioMetricButton,
                          )).marginOnly(top: 30.h),
                      TextButton(
                        onPressed: controller.onTapLogout,
                        child: Text(
                          TextConstants.signOut,
                          style: TextStyle(
                            color: GlorifiColors.white,
                            fontSize: 18.sp,
                          ),
                        ),
                      ).paddingOnly(top: 10.h),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _background() {
    return Positioned.fill(
      child: GradientOverlayContainer(
        colors: [Color(0xE003213D), Color(0xA303213D), Color(0xFF03213D)],
        stops: [0.1, 0.3, 0.7],
        child: Image.asset(
          GlorifiAssets.loginBg,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _logo() {
    return SvgPicture.asset(
      GlorifiLogos.logoDarkBg,
      width: 170,
    );
  }
}
