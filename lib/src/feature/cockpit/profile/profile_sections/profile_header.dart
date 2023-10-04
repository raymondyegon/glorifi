import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/controllers/image_picker_controller.dart';
import 'package:glorifi/src/controllers/profile_controller.dart';
import 'package:glorifi/src/feature/cockpit/controllers/cockpit_controller.dart';
import 'package:glorifi/src/feature/cockpit/controllers/loyalty_controller.dart';
import 'package:glorifi/src/feature/cockpit/profile/profile_menu.dart';
import 'package:glorifi/src/routes/app_pages.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/support/support_navigation_helper.dart';
import 'package:glorifi/src/widgets/tap/ripple.dart';
import 'package:glorifi/src/utils/responsive/responsive.dart';

import '../../../../font_style_global.dart';

class ProfileHeader extends GetView<ImagePickerController> {
  final Color color;
  final Color buttonColor;
  final Color pointsColor;

  const ProfileHeader(
      {Key? key,
      this.color = GlorifiColors.darkBlue,
      this.buttonColor = Colors.white,
      this.pointsColor = GlorifiColors.lightBlue})
      : super(key: key);

  ProfileController get profileController => Get.find<ProfileController>();
  LoyaltyController get loyaltyController => Get.find<LoyaltyController>();
  CockpitController get cockpitController => Get.find<CockpitController>();

  @override
  Widget build(BuildContext context) {
    Widget _button(onTap, child) {
      return Container(
        child: RawMaterialButton(
          onPressed: onTap,
          child: child,
          padding: EdgeInsets.all(15.0),
          fillColor: buttonColor,
          elevation: 0,
          shape: CircleBorder(),
        ),
        width: 60,
      );
    }

    Widget _getTwoLetterView() {
      String firstName = profileController.userProfile.firstName;
      String lastName = profileController.userProfile.lastName;

      String twoLettersOfName = "${firstName.isNotEmpty ? firstName[0] : ''}"
          "${lastName.isNotEmpty ? lastName[0] : ''}";

      return Container(
        width: 60,
        height: 60,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: GlorifiColors.white.withOpacity(0.42),
          shape: BoxShape.circle,
          border: Border.all(color: GlorifiColors.darkBlueColor, width: 2.0),
        ),
        child: Text(
          twoLettersOfName,
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.w700,
            fontSize: 20,
          ),
        ),
      );
    }

    Widget _getProfileImage = Column(
      children: [
        Obx(
          () => profileController.profileImageString.trim().isEmpty
              ? _getTwoLetterView()
              : SizedBox(
                  width: 60,
                  height: 60,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: Image.memory(
                      base64Decode(profileController.profileImageString),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
        ),
      ],
    );

    return Container(
      color: Colors.transparent,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Ripple(
                  onTap: () => Get.bottomSheet(
                        ProfileMenu(),
                        isScrollControlled: true,
                      ),
                  child: _getProfileImage),
              const SizedBox(width: 8),
              Ripple(
                  onTap: () => cockpitController.currentTab(CockpitTab.rewards),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Obx(
                        () => Text("${loyaltyController.currentTier} Member",
                            textScaleFactor: 1,
                            style: captionSemiBold14Primary(
                              color: color,
                            )),
                      ),
                      Obx(() => Text(
                          "${loyaltyController.currentBalanceString} points",
                          textScaleFactor: 1,
                          style: captionSemiBold14Primary(
                            color: pointsColor,
                          )))
                    ],
                  )),
            ],
          ),
          const Spacer(),

          // this flips the chat bubble
          Transform(
              alignment: Alignment.center,
              transform: Matrix4.rotationY(math.pi),
              child: _button(SupportNavigationHelper.loadBottomSheet,
                  Icon(Icons.chat_bubble_outline, color: color, size: 24))),
          SizedBox(width: 5),
        ],
      ).paddingOnly(
          left: 24.w,
          right: 10.w,
          top: 10
              .h), // The compass SVG has padding on it so we need to account for this or get a new svg
    );
  }
}
