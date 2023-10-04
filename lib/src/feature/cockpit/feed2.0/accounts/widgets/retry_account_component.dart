import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/feature/banking/controller/my_bank_controller.dart';
import 'package:glorifi/src/feature/cockpit/feed2.0/accounts/controller/accounts_controller.dart';
import 'package:glorifi/src/feature/feature_flag/feature_flag_manager.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/routes/app_pages.dart';
import 'package:glorifi/src/utils/glorifi_assets.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive.dart';
import 'package:glorifi/src/utils/text_constants.dart';
import 'banking_buttons.dart';
import 'linked_account_list.dart';

class RetryAccountComponent extends StatelessWidget {
  const RetryAccountComponent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AccountsController>();
    return Column(
      children: [
        Container(
          width: Get.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(8.r)),
            color: GlorifiColors.white,
          ),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SvgPicture.asset(
                        GlorifiAssets.banking,
                        height: 24.h,
                        width: 24.w,
                        color: GlorifiColors.blueMidnightBlue,
                      ),
                      SizedBox(
                        width: 14.h,
                      ),
                      Text(
                        TextConstants.banking,
                        style: bodySemiBold18Primary(
                            color: GlorifiColors.blueMidnightBlue),
                      ),
                    ],
                  ).paddingSymmetric(horizontal: 18.w, vertical: 24.h),
                ],
              ).paddingSymmetric(horizontal: 8.h),
              Divider(
                thickness: 1,
                color: GlorifiColors.altoGrey,
              ),
              Container(
                decoration: BoxDecoration(
                  color: GlorifiColors.white,
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(8.r),
                    bottomLeft: Radius.circular(8.r),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'There was an issue loading your information.',
                      style: bodyRegular18Primary(),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          GlorifiAssets.refresh,
                          height: 24.h,
                          width: 24.w,
                          color: GlorifiColors.blueMidnightBlue,
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        GestureDetector(
                          onTap: () async {
                            await controller.myBankController.pullRefresh();
                          },
                          child: Text(
                            "Try again",
                            style: bodyBold18Primary(
                                color: GlorifiColors.darkBlue),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                padding: EdgeInsets.only(
                  left: 28.w,
                  right: 28.w,
                  top: 25.h,
                  bottom: 33.h,
                ),
              ),
              LinkedAccountList().paddingOnly(
                  top: 10.h, left: 10.h, right: 10.h, bottom: 25.h),
            ],
          ),
        ),
      ],
    );
  }
}
