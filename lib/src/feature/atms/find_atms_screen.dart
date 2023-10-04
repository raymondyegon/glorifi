import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/feature/atms/all_point_atm_screen.dart';
import 'package:glorifi/src/feature/atms/money_pass_atm_screen.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_base_widget.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_widgets/adaptive_scaffold.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive.dart';
import 'package:glorifi/src/utils/text_constants.dart';
import 'package:glorifi/src/widgets/appbars/glorifi_appbar.dart';
import 'controllers/find_atms_screen_controller.dart';
import 'wegets/atm_component.dart';
import 'package:universal_html/html.dart' as html;

class FindAtmsScreen extends GetView<FindAtmsScreenController> {
  static const AllPointAtmIndex = 0;
  static const MoneyPassAtmIndex = 1;

  const FindAtmsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => FindAtmsScreenController());
    return AdaptiveBuilder(builder: (context, sizingInfo) {
      return AdaptiveScaffold(
        appBar: GlorifiAppBar(
          textStyle: bodySemiBold18Primary(color: GlorifiColors.darkBlue),
          title: TextConstants.findATM,
        ),
        body: Container(
          color: GlorifiColors.productsBgWhite,
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 24.h),
              Text(
                TextConstants.findAtmTitle,
                style: leadRegular24Secondary(color: GlorifiColors.darkBlue),
              ),
              SizedBox(height: 8.h),
              Text(TextConstants.findAtmSubTitle,
                  style: smallRegular16Primary(color: GlorifiColors.darkGrey)),
              SizedBox(height: 32.h),
              ListView.builder(
                  shrinkWrap: true,
                  itemCount: controller.atmList.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        AtmComponent(
                            data: controller.atmList[index],
                            onTap: () {
                              if (index == AllPointAtmIndex) {
                                if(sizingInfo.isNativeMobile){
                                  Get.to(AllPointAtmScreen());
                                } else {
                                  openWebPage(TextConstants.allPointMapUrl);
                                }
                              } else if (index == MoneyPassAtmIndex) {
                                if (sizingInfo.isNativeMobile) {
                                  Get.to(MoneyPassAtmScreen());
                                } else {
                                  openWebPage(TextConstants.moneyPassMapUrl);
                                }
                              }
                            }),
                        SizedBox(height: 16.h)
                      ],
                    );
                  }),
            ],
          ),
        ),
      );
    });
  }
  openWebPage(String url) {
    html.window.open(url, "_blank");
  }
}
