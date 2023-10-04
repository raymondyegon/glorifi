import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/routes/app_pages.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive_extensions.dart';

import '../../../font_style_global.dart';

class CreateAccountErrorScreen extends StatelessWidget {
  const CreateAccountErrorScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlorifiColors.midnightBlue,
      body: body(context),
    );
  }

  body(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.topRight,
          child: IconButton(
            onPressed: Get.back,
            icon: Icon(
              Icons.close,
              size: 36.sp,
              color: GlorifiColors.white,
            ),
          ),
        ),
        Center(
          child: SvgPicture.asset(
            'assets/icons/error.svg',
            color: GlorifiColors.cornflowerBlue,
          ),
        ).paddingSymmetric(
          vertical: 96.h,
        ),
        Text(
          'Unable to create account.',
          style: headlineRegular31Secondary(
            color: GlorifiColors.white,
          ),
        ).paddingOnly(
          bottom: 8.h,
        ),
        Text(
          'Something went wrong creating your account. Not your fault, we’ll sort it out. Try again later or contact support for assistance.',
          style: smallRegular16Primary(
            color: GlorifiColors.white,
          ),
        ).paddingOnly(
          bottom: 64.h,
        ),
        SizedBox(
          height: 64.h,
          child: TextButton(
            onPressed: () => Get.toNamed(Routes.contactSupportScreen),
            style: TextButton.styleFrom(
              backgroundColor: GlorifiColors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  style: BorderStyle.solid,
                  width: 1,
                  color: GlorifiColors.white,
                ),
                borderRadius: BorderRadius.circular(
                  8.sp,
                ),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Contact Support',
                  style: bodyBold18Primary(
                    color: GlorifiColors.midnightBlue,
                  ),
                ).paddingOnly(
                  right: 10.r,
                ),
                SvgPicture.asset(
                  'assets/icons/message_icon.svg',
                  color: GlorifiColors.midnightBlue,
                ),
              ],
            ),
          ),
        ),
      ],
    ).paddingSymmetric(
      vertical: 48.h,
      horizontal: 16.w,
    );
  }
}
