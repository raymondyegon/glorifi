import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/controllers/home_value_controller.dart';
import 'package:glorifi/src/feature/personal_snapshot/home_value/common_widget.dart';
import 'package:glorifi/src/feature/personal_snapshot/home_value/success_address_screen.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive_extensions.dart';
import 'package:glorifi/src/widgets/appbars/glorifi_appbar.dart';
import 'package:glorifi/src/widgets/charts/line_chart/line_chart.dart';

class HomeValueScreen extends GetView<HomeValueController> {
  const HomeValueScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: GlorifiAppBar(
        title: 'Home Value',
        textStyle: bodySemiBold18Primary(
          color: GlorifiColors.ebonyBlue,
        ),
        trailing: Trailing(
          text: 'Edit',
          onTap: () => {
            controller.goToDetailsScreen(),
          },
        ),
      ),
      body: SafeArea(
        child: Obx(() => Container(
              decoration: glorifiBoxDecoration(bgColor: Color(0xFFF3F2F2)),
              width: double.infinity,
              margin: EdgeInsets.all(15.0.w),
              padding: EdgeInsets.all(20.0.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: glorifiText(
                          text: 'Home Value',
                          textStyle: glorifiTextStyle(
                            fontSize: 22.0.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => {
                          controller.goToDetailsScreen(),
                        },
                        child: Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 25.0.h,
                  ),
                  _graph(),
                  SizedBox(
                    height: 20.0.h,
                  ),
                  _bottomView(),
                ],
              ),
            )),
      ),
    );
  }

  Widget _graph() {
    final homeValueDetail = controller.homeValueDetail.value;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        controller.primaryAddress.value
            ? glorifiText(
                text: r'\$860,000',
                textStyle: glorifiTextStyle(
                  fontSize: 30.0.sp,
                  fontWeight: FontWeight.bold,
                ),
              )
            : glorifiText(
                text:
                    'Home value refers to the worth of a piece of real estate based on the price that a buyer and seller agree upon.',
                textStyle: glorifiTextStyle(
                  fontSize: 20.0.sp,
                  fontWeight: FontWeight.normal,
                ),
              ),
        Container(
          width: 300.w,
          height: 100.h,
          margin: const EdgeInsets.symmetric(vertical: 20.0),
          child: LineChartWidget(
            data: homeValueDetail.historical,
          ),
        ),
      ],
    );
  }

  Widget _bottomView() {
    return controller.primaryAddress.value
        ? Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              glorifiText(
                text: 'As of 10 Mar (pull monthly)',
                textStyle: glorifiTextStyle(
                    fontSize: 20.0.sp,
                    fontWeight: FontWeight.w700,
                    textColor: Colors.black),
              ),
              SizedBox(
                height: 5.0.h,
              ),
              glorifiText(
                text: '*Data powered by AVM and Historical AVM',
                textStyle: glorifiTextStyle(
                    fontSize: 18.0.sp,
                    fontWeight: FontWeight.w500,
                    textColor: Colors.black54),
              ),
            ],
          )
        : GestureDetector(
            onTap: () => {
              controller.goToAddressScreen(AddressFlowType.add),
            },
            child: Row(
              children: [
                Spacer(),
                glorifiText(
                  text: 'Add address',
                  textStyle: glorifiTextStyle(
                    fontSize: 18.0.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  width: 10.0.w,
                ),
                Icon(
                  Icons.arrow_forward,
                  color: Colors.black,
                ),
              ],
            ),
          );
  }
}
