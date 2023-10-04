import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/feature/onboard/login/models/login_args.dart';
import 'package:glorifi/src/feature/update_handler/controllers/update_handler_controllers.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive.dart';

class UpdateHandlerScreen extends GetView<UpdateHandlerControllers> {
  const UpdateHandlerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: GlorifiColors.altoGrey,
        body: Padding(
          padding: EdgeInsets.all(24.sp),
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Update Available",
                style:
                    headlineRegular31Secondary(color: GlorifiColors.darkBlue),
              ),
              SizedBox(height: 24.h),
              Text(
                "We said update. Regular dates we’ll leave up to you. ",
                style: bodyBold18Primary(color: GlorifiColors.midnightBlue),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16.h),
              Text(
                "Would you like to update now?",
                style:
                    captionRegular14Primary(color: GlorifiColors.midnightBlue),
              ),
              SizedBox(height: 56.h),
              InkWell(
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 15.h),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.r),
                    color: GlorifiColors.midnightBlue,
                  ),
                  child: Text(
                    "Update",
                    style: bodyBold18Primary(color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              SizedBox(height: 16.h),
              controller.updateTerms == UpdateTerms.optional
                  ? TextButton(
                      onPressed: () {
                        Get.back(
                          result: LoginArgs(updateTerms: UpdateTerms.updated),
                        );
                      },
                      child: Text(
                        "Skip",
                        style: bodyBold18Primary(
                            color: GlorifiColors.midnightBlue),
                      ),
                    )
                  : const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
