import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/controllers/compare_user_controller.dart';
import 'package:glorifi/src/personal_snapshot/compare_with_other/common_widget.dart';
import 'package:glorifi/src/personal_snapshot/compare_with_other/strings.dart';
import 'package:glorifi/src/routes/app_pages.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive_extensions.dart';
import '../../widgets/appbars/glorifi_appbar.dart';

class CompareOptionView extends GetView<CompareUserController> {
  const CompareOptionView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GlorifiAppBar(
        title: Strings.compare,
      ),

      body: SafeArea(
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.all(25.0),
          child: controller.compareOptionDataList.isNotEmpty
              ? Column(
                  children: [
                    glorifiText(
                      text: Strings.select_topic_you,
                      textStyle: glorifiTextStyle(
                        fontSize: 26.0.sp,
                        textColor: GlorifiColors.textColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 30.0.h,
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: controller.compareOptionDataList.length,
                        itemBuilder: (context, index) {
                          return _singleRowOption(index);
                        },
                      ),
                    ),
                  ],
                )
              : CircularProgressIndicator(),
        ),
      ),
    );
  }

  Widget _singleRowOption(int index) {
    CompareOptionData _compareOptionData =
        controller.compareOptionDataList[index];
    return GestureDetector(
      onTap: () => {
        Get.toNamed(Routes.compareOptionDetailsView),
      },
      child: Container(
        padding: EdgeInsets.all(16.0.w),
        margin: EdgeInsets.only(bottom: 16.0.h),
        decoration: glorifiBoxDecoration(
          radius: 10.0.r,
          bgColor: Colors.transparent,
          borderColor: GlorifiColors.textColor,
          borderWidth: 0.5.sp,
        ),
        child: glorifiText(
          text: _compareOptionData.optionTitle,
          textStyle: glorifiTextStyle(
            fontSize: 18.0.sp,
            textColor: GlorifiColors.textColor,
          ),
        ),
      ),
    );
  }
}
