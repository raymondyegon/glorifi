import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/feature/onboard/edit_profile/edit_profile_landing/controllers/edit_profile_controller.dart';
import 'package:glorifi/src/utils/responsive/responsive_extensions.dart';
import 'package:glorifi/src/utils/text_constants.dart';
import 'package:glorifi/src/widgets/asset_image/AssetImageView.dart';
import 'package:glorifi/src/widgets/loading/shimmer.dart';
import 'package:glorifi/src/widgets/tap/ripple.dart';

import '../../../../../font_style_global.dart';
import '../../../../../utils/glorifi_colors.dart';

class ExternalAccountEmptyState extends GetView<EditProfileController> {
  final Function() onTap;

  const ExternalAccountEmptyState({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.loadingTapLinkExternalBankAccount.value
          ? Container(
              height: 150,
              child: ShimmeryPlaceHolder(
                radius: 8,
              ),
            )
          : Ripple(
              onTap: onTap,
              child: Container(
                padding: EdgeInsets.symmetric(
                  vertical: 26.h,
                  horizontal: 20.w,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: GlorifiColors.white,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AssetImageView(
                      fileName: 'icons/link_icon.svg',
                      width: 24.sp,
                      height: 24.sp,
                    ),
                    SizedBox(width: 16.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            TextConstants.linkExternalBankAccount,
                            style: smallBold16Secondary(
                              color: GlorifiColors.cornflowerBlue,
                            ),
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            TextConstants.addCheckingBalanceSavings,
                            style: smallRegular16Primary(
                              color: GlorifiColors.ebonyBlue,
                            ),
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            TextConstants.youCanLinkUnlinkAnytime,
                            style: captionRegular14Primary(
                              color: GlorifiColors.ebonyBlue,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
