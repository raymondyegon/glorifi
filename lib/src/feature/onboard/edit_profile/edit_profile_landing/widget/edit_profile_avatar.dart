import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/controllers/image_picker_controller.dart';
import 'package:glorifi/src/controllers/profile_controller.dart';
import 'package:glorifi/src/core/logger.dart';
import 'package:glorifi/src/feature/cockpit/profile/get_img_upload_options.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';

class EditProfileAvatar extends GetView<ProfileController> {
  final imagePickerController = Get.find<ImagePickerController>();

  EditProfileAvatar({Key? key}) : super(key: key);

  String _getSubString() {
    String returnResult = "";
    try {
      returnResult =
          controller.userProfile.firstName.substring(0, 1).toUpperCase() +
              controller.userProfile.lastName.substring(0, 1).toUpperCase();
    } catch (e) {
      Log.error(e);
    }
    return returnResult;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.bottomSheet(
          GetImgUploadOptions(),
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25), topRight: Radius.circular(25)),
          ),
        );
      },
      child: Stack(
        children: [
          Obx(
            () => controller.profileImageString.trim().isEmpty
                ? Container(
                    width: 96,
                    height: 96,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: GlorifiColors.bgGrey80),
                    child: Text(
                      _getSubString(),
                      style: TextStyle(
                          color: GlorifiColors.midnightBlue,
                          fontWeight: FontWeight.w700,
                          fontSize: 20),
                    ))
                : Obx(
                    () => SizedBox(
                      width: 96,
                      height: 96,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Image.memory(
                          base64Decode(controller.profileImageString),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
          ),
          Positioned(
            right: 0,
            bottom: 0,
            child: Container(
              decoration: BoxDecoration(
                  color: GlorifiColors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      offset: Offset(2, 1), //(x,y)
                      blurRadius: 25,
                    ),
                  ],
                  shape: BoxShape.circle),
              width: 34,
              height: 34,
              child: Image.asset(
                'assets/images/edit_icon.png',
              ).paddingAll(5),
            ),
          )
        ],
      ),
    );
  }
}
