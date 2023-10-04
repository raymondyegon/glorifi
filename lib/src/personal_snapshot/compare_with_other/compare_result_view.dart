import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/controllers/compare_user_controller.dart';
import 'package:glorifi/src/personal_snapshot/compare_with_other/common_widget.dart';
import 'package:glorifi/src/personal_snapshot/compare_with_other/strings.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive_extensions.dart';
import '../../widgets/appbars/glorifi_appbar.dart';

class CompareResultView extends GetView<CompareUserController> {
  const CompareResultView({Key? key}) : super(key: key);

  _getResultData(BuildContext context) {
    controller.getCompareDataApi();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance!
        .addPostFrameCallback((_) => _getResultData(context));
    return Scaffold(
      appBar:  GlorifiAppBar(
        title: Strings.compare,
      ),
      body: SafeArea(
        child: Obx(
          () => controller.isDataLoad.value
              ? _resultView()
              : _loadDataView(), //_loadDataView(), _resultView
        ),
      ),
    );
  }

  Widget _loadDataView() {
    return Container(
      padding: EdgeInsets.all(25.0.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          glorifiText(
            text: Strings.provided_data,
            textStyle: glorifiTextStyle(
              fontSize: 21.0.sp,
              textColor: GlorifiColors.textColor,
              fontWeight: FontWeight.normal,
            ),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.center,
              child: glorifiText(
                text: Strings.getting_your_comparison,
                textStyle: glorifiTextStyle(
                  fontSize: 25.0.sp,
                  textColor: GlorifiColors.textColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _resultView() {
    return Container(
      padding: EdgeInsets.all(20.0.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          glorifiText(
            text: Strings.annual_income_text,
            textStyle: glorifiTextStyle(
              fontSize: 25.0.sp,
              textColor: GlorifiColors.textColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 25.h,
          ),
          _dropdownView(),
          SizedBox(
            height: 25.h,
          ),
          glorifiText(
            text: '5%',
            textStyle: glorifiTextStyle(
              fontSize: 45.0.sp,
              textColor: GlorifiColors.textColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 5.0.h,
          ),
          RichText(
            text: TextSpan(
              text: 'You are ',
              style: glorifiTextStyle(
                fontSize: 20.0.sp,
                textColor: GlorifiColors.textColor,
                fontWeight: FontWeight.bold,
              ),
              children: <TextSpan>[
                TextSpan(
                    text: '5% below',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                TextSpan(text: ' average in your group.'),
              ],
            ),
          ),
          SizedBox(
            height: 30.0.h,
          ),
          Container(
            alignment: Alignment.centerRight,
            child: glorifiText(
              text: Strings.compared_against,
              textStyle: glorifiTextStyle(
                fontSize: 18.0.sp,
                textColor: GlorifiColors.textColor,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
          _averageView(),
        ],
      ),
    );
  }

  Widget _averageView() {
    return Column(
      children: [
        _divider(),
        Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  glorifiText(
                    text: 'You',
                    textStyle: glorifiTextStyle(
                      fontSize: 20.0.sp,
                      textColor: GlorifiColors.textColor,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  SizedBox(
                    height: 30.0.h,
                  ),
                  glorifiText(
                    // ignore: use_raw_strings
                    text: "\$65,000",
                    textStyle: glorifiTextStyle(
                      fontSize: 30.0.sp,
                      textColor: GlorifiColors.textColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: 1.0,
              color: Colors.black,
              height: 120.0.h,
            ),
            Expanded(
              child: Column(
                children: [
                  glorifiText(
                    text: 'Others Avg.',
                    textStyle: glorifiTextStyle(
                      fontSize: 20.0.sp,
                      textColor: GlorifiColors.textColor,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  SizedBox(
                    height: 30.0.h,
                  ),
                  glorifiText(
                    // ignore: use_raw_strings
                    text: "\$70,000",
                    textStyle: glorifiTextStyle(
                      fontSize: 30.0.sp,
                      textColor: GlorifiColors.textColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
        SizedBox(
          height: 10.0.h,
        ),
        glorifiText(
          text: Strings.based_on_average,
          textStyle: glorifiTextStyle(
            fontSize: 18.0.sp,
            textColor: GlorifiColors.textColor,
            fontWeight: FontWeight.normal,
          ),
        ),
        _divider(),
      ],
    );
  }

  Widget _divider() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.0.h),
      height: 5.0.h,
      color: GlorifiColors.grey,
    );
  }

  Widget _dropdownView() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: DropdownButtonFormField<String>(
            icon: Icon(Icons.keyboard_arrow_down_outlined),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(15.0),
              floatingLabelBehavior: FloatingLabelBehavior.always,
              border: OutlineInputBorder(
                // <--- this line
                borderRadius: BorderRadius.circular(10), // <--- this line
              ),
            ),
            // value: _ratingController,
            items: controller.arrayList
                .map((label) => DropdownMenuItem(
                      child: Text(label.toString()),
                      value: label,
                    ))
                .toList(),
            hint: Text('Select'),
            onChanged: (value) {},
          ),
        ),
        const SizedBox(
          width: 5.0,
        ),
        Expanded(
          child: DropdownButtonFormField<String>(
            icon: Icon(Icons.keyboard_arrow_down_outlined),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(15.0),
              floatingLabelBehavior: FloatingLabelBehavior.always,
              border: OutlineInputBorder(
                // <--- this line
                borderRadius: BorderRadius.circular(10), // <--- this line
              ),
            ),
            // value: _ratingController,
            items: controller.arrayGender
                .map((label) => DropdownMenuItem(
                      child: Text(label.toString()),
                      value: label,
                    ))
                .toList(),
            hint: Text('Select'),
            onChanged: (value) {},
          ),
        ),
        const SizedBox(
          width: 5.0,
        ),
        Expanded(
          child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(10.0),
            decoration: glorifiBoxDecoration(),
            child: glorifiText(
              text: Strings.age_group,
              textStyle: glorifiTextStyle(
                fontSize: 14.0,
                textColor: GlorifiColors.textColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
