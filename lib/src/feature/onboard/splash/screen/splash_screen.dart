import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/feature/onboard/splash/controllers/splash_controller.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/glorifi_logos.dart';
import 'package:glorifi/src/utils/responsive/responsive.dart';
import 'package:glorifi/src/widgets/containers/gradient_overlay_container.dart';
import 'package:glorifi/src/widgets/glorifi_logos/glorifi_logos.dart';

class SplashScreen extends GetView<SplashController> {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlorifiColors.splashBgColor,
      body: Stack(
        children: [
          Positioned.fill(
            child: Obx(
              () => GradientOverlayContainer(
                colors: [
                  GlorifiColors.whiteBlue.withOpacity(0),
                  GlorifiColors.midnightBlue.withOpacity(0.8),
                  GlorifiColors.midnightBlue.withOpacity(1)
                ],
                // stops: [0.5, 1],
                child: Image.asset(
                  controller.splashImageAssetNameWithPath,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Positioned.fill(
            child: SafeArea(
              child: Align(
                alignment: Alignment.center,
                child: GloriFiLogos(
                    imageKey: GlorifiLogos.logoDarkBg,
                    height: 76.h,
                    width: 194.w),
              ),
            ),
          )
        ],
      ),
    );
  }
}
