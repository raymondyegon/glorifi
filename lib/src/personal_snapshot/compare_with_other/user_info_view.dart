import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/personal_snapshot/compare_with_other/common_widget.dart';
import 'package:glorifi/src/personal_snapshot/compare_with_other/strings.dart';
import 'package:glorifi/src/routes/app_pages.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive_extensions.dart';

class UserInfoView extends StatelessWidget {
  const UserInfoView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: glorifiAppBar(
        title: 'sdcs',
      ),
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.all(20.0.w),
          padding: EdgeInsets.all(20.0.w),
          width: double.infinity,
          decoration: glorifiBoxDecoration(
            radius: 10.0.r,
            bgColor: GlorifiColors.grey,
            borderColor: GlorifiColors.grey,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              glorifiText(
                text: Strings.ready_to_compare,
                textStyle: glorifiTextStyle(
                    fontSize: 18.0.sp,
                    textColor: GlorifiColors.textColor,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 30.0.h,
              ),
              glorifiButtonWithIcon(
                  text: Strings.compare_now,
                  icon: Icon(
                    Icons.group,
                    color: GlorifiColors.white,
                  ),
                  onTap: () => {
                        Get.toNamed(Routes.compareOptionView),
                      }),
            ],
          ),
        ),
      ),
    );
  }
}
