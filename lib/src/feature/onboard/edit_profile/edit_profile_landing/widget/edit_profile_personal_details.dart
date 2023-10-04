import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/controllers/profile_controller.dart';
import 'package:glorifi/src/feature/onboard/create_profile_plus/widgets/profile_text_form_field_widget.dart';
import 'package:glorifi/src/feature/onboard/edit_profile/edit_phone_number/controllers/edit_phone_number_controller.dart';
import 'package:glorifi/src/feature/onboard/edit_profile/edit_preferred_name/controllers/edit_preferred_name_controller.dart';
import 'package:glorifi/src/feature/onboard/edit_profile/edit_profile_landing/widget/show_edit_phone_number_dialog.dart';
import 'package:glorifi/src/feature/onboard/edit_profile/edit_profile_landing/widget/show_edit_preffered_name_dialog.dart';
import 'package:glorifi/src/feature/onboard/edit_profile/edit_profile_landing/widget/show_edit_zip_code_dialog.dart';
import 'package:glorifi/src/feature/onboard/edit_profile/edit_zip_code/controllers/edit_zip_code_controller.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/routes/app_pages.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_sizing.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive_extensions.dart';

class EditProfilePersonalDetails extends GetView<ProfileController> {
  const EditProfilePersonalDetails(this.sizingInfo, {Key? key})
      : super(key: key);
  final AdaptiveSizingInfo sizingInfo;

  EditPhoneNumberController get mobilecontroller => Get.find();

  EditZipCodeController get zipCodeController => Get.find();
  EditPreferredNameController get preferredNamController => Get.find();

  @override
  Widget build(BuildContext context) {

    return Container(
      color: GlorifiColors.white,
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 52.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "PERSONAL DETAILS",
            style: smallBold16Primary(color: GlorifiColors.midnightBlue),
          ),
          Obx(
            () => ProfileTextFormFieldWidget(
              label: "Preferred Name (Optional)",
              value: controller.userProfile.preferredName,
              isSpecial: true,
              isLockVisible: false,
              onTap: () {
                if(sizingInfo.isNativeMobile) {
                  Get.toNamed(
                    Routes.EDIT_PREFERRED_NAME,
                    arguments: controller.userProfile.preferredName ?? "",

                  );
                }else
                  showEditPreferredNameDialog(context, preferredNamController);

              },
            ),
          ),
          ProfileTextFormFieldWidget(
            label: "First Name",
            value: controller.userProfile.firstName,
            onTap: () => _showDialog("first name", context),
          ),
          if (controller.userProfile.middleName != null)
            ProfileTextFormFieldWidget(
              label: "Middle Name",
              onTap: () => _showDialog("middle name", context),
              value: controller.userProfile.middleName,
            ),
          ProfileTextFormFieldWidget(
            label: "Last Name",
            onTap: () => _showDialog("last name", context),
            value: controller.userProfile.lastName,
          ),
          ProfileTextFormFieldWidget(
            label: "Birthday",
            onTap: () => _showDialog("birthday", context),
            value: controller
                .getBirthDateFormatted(controller.userProfile.birthDate),
          ),
          Obx(
            () => ProfileTextFormFieldWidget(
                label: "ZIP Code",
                isLockVisible: false,
                value: controller.userProfile.zip,
                onTap: () {
                  if (sizingInfo.isNativeMobile) {
                    Get.toNamed(
                      Routes.EDIT_ZIP_CODE,
                      arguments: controller.userProfile.zip,
                    );
                  } else {
                    showEditZipCodeDialog(context, zipCodeController);
                  }
                }),
          ),
          Obx(
            () => ProfileTextFormFieldWidget(
              label: "Mobile Number",
              onTap: () {
                if (sizingInfo.isNativeMobile) {
                  Get.toNamed(
                    Routes.editPhoneNumber,
                    arguments: controller.userProfile.phoneNumber,
                  );
                } else {
                  showEditPhoneNumberDialog(
                      context, mobilecontroller, controller);
                }
              },
              value: controller.userProfile.phoneNumber,
              verified: true,
              isLockVisible: false,
            ),
          ),
        ],
      ),
    );
  }

  void _showDialog(String message, BuildContext context) {
    showCupertinoDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          content: Text(
            "Please contact support to change your $message",
            style: bodyBold18Primary(),
          ),
          actions: [
            CupertinoDialogAction(
              child: Text('Close'),
              onPressed: () => Navigator.pop(context),
            ),
            CupertinoDialogAction(
              child: Text('Contact'),
              onPressed: () {
                Navigator.pop(context);
                Get.toNamed(Routes.contactSupportCategoryScreen);
              },
            ),
          ],
        );
      },
    );
  }
}
