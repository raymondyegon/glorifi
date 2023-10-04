import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/feature/text_widget_demo/text_filed_widget_controller.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive_extensions.dart';
import 'package:glorifi/src/widgets/text_field/glorifi_text_field.dart';
import 'package:glorifi/src/widgets/text_field/suffix_model.dart';

import '../../widgets/appbars/glorifi_appbar.dart';

class TextFiledWidget extends GetView<TextFiledWidgetController> {
  const TextFiledWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFFFFFFFF),
        appBar: GlorifiAppBar(
          title: 'Reusable  Text Widget',
        ),
        body: Container(
          margin: EdgeInsets.all(20.0.w),
          child: SingleChildScrollView(
            child: Form(
              key: controller.formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  _commonMessage('------No Hint and With Hint------'),
                  GlorifiTextField(
                    textEditingController: controller.textEditingController,
                    label: 'Label',
                  ),
                  SizedBox(
                    height: 5.0.h,
                  ),
                  GlorifiTextField(
                    textEditingController: controller.textEditingController,
                    label: 'Label',
                    validator: GlorifiTextField.requiredFieldValidator('error message'),
                  ),
                  _commonMessage(
                      '------No Hint and With Hint With 1 icon right------'),
                  GlorifiTextField(
                      textEditingController: controller.textEditingController,
                      label: 'Label',
                    // suffixIcon: [
                    //   SuffixModel(
                    //       icon: Icons.keyboard_arrow_down_outlined,
                    //       callback: () {})
                    // ]
                  ),
                  SizedBox(
                    height: 5.0.h,
                  ),
                  GlorifiTextField(
                      textEditingController: controller.textEditingController,
                    label: 'Label',
                    validator: GlorifiTextField.requiredFieldValidator('error message'),
                    // suffixIcon: [
                    //   SuffixModel(
                    //       icon: Icons.keyboard_arrow_down_outlined,
                    //       callback: () {})
                    // ]
                  ),
                  _commonMessage(
                      '------No Hint and With Hint With 2 icon right------'),
                  GlorifiTextField(
                      textEditingController: controller.textEditingController,
                      label: 'Label',
      
                    // suffixIcon: [
                    //   SuffixModel(icon: Icons.lock, callback: () {}),
                    //   SuffixModel(
                    //       icon: Icons.keyboard_arrow_down_outlined,
                    //       callback: () {})
                    // ]
                  ),
                  SizedBox(
                    height: 5.0.h,
                  ),
                  GlorifiTextField(
                      textEditingController: controller.textEditingController,
                      label: 'Label',
                    validator: GlorifiTextField.requiredFieldValidator('error message'),
                    // suffixIcon: [
                    //   SuffixModel(icon: Icons.lock, callback: () {}),
                    //   SuffixModel(
                    //       icon: Icons.keyboard_arrow_down_outlined,
                    //       callback: () {})
                    // ]
                  ),
                  SizedBox(
                    height: 50.0.h,
                  ),
                  _glorifiButton(
                      onTap: () => {
                            if (controller.formKey.currentState!.validate())
                              {
                                // If the form is valid, display a snackbar. In the real world,
                                // you'd often call a server or save the information in a database.
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Data Saved'),
                                  ),
                                ),
                              }
                          }),
                ],
              ),
            ),
          ),
        ));
  }

  Widget _glorifiButton({required GestureTapCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        width: double.infinity,
        padding: EdgeInsets.all(20.0.w),
        decoration: BoxDecoration(
          color: GlorifiColors.textColor,
          border: Border.all(
            color: GlorifiColors.textColor,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(20.0.r),
          ),
        ),
        child: Text(
          'VALIDATE',
          style: TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 20.0.sp,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  BoxDecoration glorifiBoxDecoration(
      {double radius = 10.0,
      Color bgColor = GlorifiColors.white,
      Color borderColor = GlorifiColors.white,
      double borderWidth = 0.0}) {
    return BoxDecoration(
      color: bgColor,
      border: Border.all(
        color: borderColor,
        width: borderWidth,
      ),
      borderRadius: BorderRadius.all(
        Radius.circular(radius),
      ),
    );
  }

  Widget _commonMessage(String message) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.0.h),
      child: Text(
        message,
        style: TextStyle(
          fontWeight: FontWeight.normal,
          fontSize: 18.0.sp,
          color: Colors.blue,
        ),
      ),
    );
  }
}
