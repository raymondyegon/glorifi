import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/controllers/compare_user_controller.dart';
import 'package:glorifi/src/personal_snapshot/compare_with_other/common_widget.dart';
import 'package:glorifi/src/personal_snapshot/compare_with_other/strings.dart';
import 'package:glorifi/src/routes/app_pages.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive_extensions.dart';
import '../../widgets/appbars/glorifi_appbar.dart';

class CompareOptionDetailsView extends GetView<CompareUserController> {
  const CompareOptionDetailsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  GlorifiAppBar(
        title: Strings.compare,
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(25.0.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              glorifiText(
                text: Strings.annual_income,
                textStyle: glorifiTextStyle(
                  fontSize: 26.0.sp,
                  textColor: GlorifiColors.textColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 20.0.h,
              ),
              glorifiText(
                text: Strings.compare_your_income,
                textStyle: glorifiTextStyle(
                  fontSize: 21.0.sp,
                  textColor: GlorifiColors.textColor,
                  fontWeight: FontWeight.normal,
                ),
              ),
              SizedBox(
                height: 40.0.h,
              ),
              glorifiText(
                text: Strings.annual_income_text,
                textStyle: glorifiTextStyle(
                  fontSize: 20.0.sp,
                  textColor: GlorifiColors.textColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 5.0.h,
              ),
              glorifiTextFieldNumber(
                  textEditingController: controller.textEditingController,
                  hint: Strings.enter_annual_income,
                  label: Strings.annual_income_text),
              Spacer(),
              glorifiButton(
                  text: Strings.compare_now,
                  onTap: () => {
                        Get.toNamed(Routes.compareResultView),
                      }),
            ],
          ),
        ),
      ),
    );
  }
}
