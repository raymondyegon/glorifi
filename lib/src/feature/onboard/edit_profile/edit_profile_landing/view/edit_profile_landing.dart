import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/feature/feature_flag/feature_flag_manager.dart';
import 'package:glorifi/src/feature/onboard/create_profile_plus/widgets/show_input_info.dart';
import 'package:glorifi/src/feature/onboard/edit_profile/edit_profile_landing/controllers/edit_profile_controller.dart';
import 'package:glorifi/src/feature/onboard/edit_profile/edit_profile_landing/widget/edit_profile_avatar.dart';
import 'package:glorifi/src/feature/onboard/edit_profile/edit_profile_landing/widget/edit_profile_card.dart';
import 'package:glorifi/src/feature/onboard/edit_profile/edit_profile_landing/widget/edit_profile_credit_score.dart';
import 'package:glorifi/src/feature/onboard/edit_profile/edit_profile_landing/widget/edit_profile_device_settings.dart';
import 'package:glorifi/src/feature/onboard/edit_profile/edit_profile_landing/widget/edit_profile_external_accounts.dart';
import 'package:glorifi/src/feature/onboard/edit_profile/edit_profile_landing/widget/edit_profile_member_since.dart';
import 'package:glorifi/src/feature/onboard/edit_profile/edit_profile_landing/widget/edit_profile_personal_details.dart';
import 'package:glorifi/src/routes/app_pages.dart';
import 'package:glorifi/src/services/session_manager_service.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_base_widget.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_sizing.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_widgets/adaptive_scaffold.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive_extensions.dart';
import 'package:glorifi/src/widgets/appbars/glorifi_appbar.dart';
import 'package:glorifi/src/widgets/buttons/primary_buton_dark.dart';
import 'package:glorifi/src/widgets/tap/ripple.dart';
import 'package:glorifi/src/widgets/web/page_header.dart';

class EditProfileLanding extends GetView<EditProfileController> {
  const EditProfileLanding({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return AdaptiveBuilder(builder: (context, sizingInfo) {
      return AdaptiveScaffold(
        appBar: GlorifiAppBar(
          title: "Edit Profile",
        ),
        backgroundColor: GlorifiColors.productsBgWhite,
        body: (sizingInfo.isDesktop)
            ? _web(sizingInfo, context)
            : _mobile(sizingInfo, context),
      );
    });
  }

  Widget _web(AdaptiveSizingInfo sizingInfo, BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 200.w).copyWith(bottom: 100.h),
      child: Container(
        width: sizingInfo.screenSize.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            PageHeader(
              headerTitle: "My Profile",
              showTrailingButton: false,
              horizontalPadding: 0,
              showWebPageFont: true,
            ),
            SizedBox(
              height: 50.h,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                    width: (sizingInfo.screenSize.width - 400.w - 32.w) * 0.4,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Card(
                          elevation: 8,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0.r),
                          ),
                          color: Colors.white,
                          child: Column(
                            children: [
                              EditProfileAvatar()
                                  .paddingOnly(top: 20.h, bottom: 20.h),
                              EditProfileMemberSince(),
                              (!controller.getProfile.isComplete)
                                  ? Ripple(
                                      onTap: () {
                                        _showCompleteProfileBottomSheet(
                                            context);
                                      },
                                      child: Obx(
                                        () => EditProfileCard(
                                          profileModel: controller.getProfile,
                                        ),
                                      ),
                                    ).paddingSymmetric(
                                      vertical: 20.h, horizontal: 20.h)
                                  : const SizedBox(),
                            ],
                          ),
                        ),
                        // PrimaryDarkButton(
                        //   title: "Logout",
                        //   onTap: () {
                        //     final sessionManager = Get.find<SessionManagerService>();
                        //     sessionManager.logout();
                        //   },
                        // ).marginOnly(top: 36.h),

                        // Card(
                        //   color: GlorifiColors.white,
                        //   elevation: 8.0,
                        //   child: Padding(
                        //     padding: EdgeInsets.symmetric(
                        //         horizontal: 20.w, vertical: 20.h),
                        //     child: EditProfileDeviceSettings(),
                        //   ),
                        // ),
                      ],
                    )),
                SizedBox(
                  width: 32.w,
                ),
                Container(
                    width: (sizingInfo.screenSize.width - 400.w - 32.w) * 0.6,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Card(
                            elevation: 8,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0.r),
                            ),
                            color: Colors.white,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 20.h, horizontal: 20.w),
                              child: EditProfilePersonalDetails(sizingInfo),
                            )),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Flexible(
                              child: EditProfileExternalAccounts(
                                sizingInfo: sizingInfo,
                                onTap: () => controller.gotoLinkedAccounts(),
                              ),
                            ),
                            SizedBox(
                              width: 32.h,
                            ),
                            Flexible(
                              child: EditProfileCreditScore(onTap: () {
                                controller.showDialogBox(context);
                              }),
                            ),
                          ],
                        ).paddingOnly(top: 32.h),
                      ],
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _tablet(AdaptiveSizingInfo sizingInfo, BuildContext context) {
    return const SizedBox();
  }

  Widget _mobile(AdaptiveSizingInfo sizingInfo, BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (!sizingInfo.isNativeMobile)
            PageHeader(
                headerTitle: "My Profile",
                showTrailingButton: false,
                horizontalPadding: sizingInfo.isDesktop
                    ? 200.w
                    : sizingInfo.isTablet
                        ? 34.5.w
                        : 24.5.w),
          EditProfileAvatar().paddingOnly(top: 20),
          EditProfileMemberSince(),
          Obx(
            () => (!controller.getProfile.isComplete)
                ? Card(
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0.r),
                    ),
                    color: Colors.white,
                    child: Ripple(
                      onTap: () {
                        _showCompleteProfileBottomSheet(context);
                      },
                      child: EditProfileCard(
                        profileModel: controller.getProfile,
                        crossAxisAlignment: CrossAxisAlignment.start,
                      ),
                    ).paddingSymmetric(horizontal: 20.w, vertical: 20.h),
                  )
                    .paddingSymmetric(horizontal: 20.w)
                    .marginOnly(top: 23.h, bottom: 42.h)
                : SizedBox(
                    height: 35.h,
                  ),
          ),
          EditProfilePersonalDetails(sizingInfo),
          SizedBox(height: 16.h),
          EditProfileExternalAccounts(
            onTap: controller.gotoLinkedAccounts,
          ).paddingSymmetric(vertical: 16.h, horizontal: 20.w),
          if (FeatureFlagManager.snapshotCreditScoreEnabled)
          Obx(
            () => EditProfileCreditScore(
              onTap: () {
                if (controller.creditScoreEnabled) {
                  Get.toNamed(Routes.creditScoreDetailScreen);
                } else {
                  Get.toNamed(Routes.enableCreditScoreStep1Name);
                }
              },
              isMobile: true,
              creditScoreEnabled: controller.creditScoreEnabled,
            ).paddingSymmetric(
              vertical: 16.h,
              horizontal: 20.w,
            ),
          ),
          SizedBox(
            height: 16.h,
          ),
          EditProfileDeviceSettings().marginOnly(bottom: 30.h),
        ],
      ),
    );
  }

  void _showCompleteProfileBottomSheet(BuildContext context) {
    String title = "Complete your Profile";
    String message = "1. Full Name\n"
        "2. Profile Picture\n"
        "3. Birthday\n"
        "4. ZIP Code\n"
        "5. Mobile Number\n"
        "6. Request Free Credit Score\n"
        "7. Link Bank Account\n";

    kIsWeb
        ? showInfoDialog(context, title, message)
        : showBottomSheetLog(context, title, message);
  }
}
