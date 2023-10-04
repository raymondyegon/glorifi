import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/core/base/page_state.dart';
import 'package:glorifi/src/feature/onboard/edit_profile/edit_profile_landing/controllers/device_settings_controller.dart';
import 'package:glorifi/src/feature/onboard/edit_profile/edit_profile_landing/widget/device_settings_item.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive_extensions.dart';

class EditProfileDeviceSettings extends StatefulWidget {
  EditProfileDeviceSettings({
    Key? key,
  }) : super(key: key) {
    Get.lazyPut(() => DeviceSettingsController());
  }

  @override
  _EditProfileDeviceSettingsState createState() =>
      _EditProfileDeviceSettingsState();
}

class _EditProfileDeviceSettingsState extends State<EditProfileDeviceSettings>
    with WidgetsBindingObserver {
  DeviceSettingsController get controller =>
      Get.find<DeviceSettingsController>();

  @override
  void initState() {
    WidgetsBinding.instance?.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        controller.initDeviceSettings();
        break;
      default:
        {}
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Column(
      children: [
        Container(
          width: screenSize.width,
          color: GlorifiColors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "DEVICE SETTINGS",
                    style:
                        smallBold16Primary(color: GlorifiColors.midnightBlue),
                  ),
                  SvgPicture.asset(
                    "assets/images/profile_settings.svg",
                    width: 20.w,
                    height: 20.h,
                  ),
                ],
              ),
              Obx(
                () => DeviceSettingsItem(
                  settingName: "Location",
                  status: controller.locationStatus,
                  onTap: controller.openLocationSettings,
                ).marginOnly(top: 30.h),
              ),
              Obx(
                () => controller.biometricTitle.contains("Face ID")
                    ? DeviceSettingsItem(
                        settingName: controller.biometricTitle,
                        status: controller.biometricEnabled,
                        onTap: controller.openBiometricSettings,
                      ).marginOnly(top: 16.h)
                    : Container(),
              ),
            ],
          ).paddingOnly(left: 20.w, right: 20.w, top: 36.h, bottom: 56.h),
        ),
      ],
    );
  }
}
