import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/controllers/profile_controller.dart';
import 'package:glorifi/src/feature/cockpit/feed2.0/greeting/weather_controller.dart';
import 'package:glorifi/src/feature/cockpit/feed2.0/greeting/weather_widget.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_base_widget.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive.dart';

import '../../../../font_style_global.dart';

class Greeting extends GetView<ProfileController> {
  Greeting({Key? key}) : super(key: key);
  final weatherController = Get.find<WeatherController>();

  @override
  Widget build(BuildContext context) {
    /*

    TODO: ${controller.greeting} make greeting a list so we can divide it into 2 lines
    check whether we really want it to be 3 lines first

     */

    Widget _getGreeting(TextStyle style, {add_new_lines: false}) {
      var divider = add_new_lines == true ? "\n" : " ";
      return Obx(() => Text(
            controller.greetingMessage.join(divider),
            style: style.copyWith(),
          ));
    }

    Widget _mobile(Color color) {
      return Padding(
        padding: EdgeInsets.only(left: 24.w, right: 24.w, bottom: 30.h),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _getGreeting(
                headlineRegular32Secondary(color: color),
                add_new_lines: true),
            SizedBox(width: 4.w),
            Expanded(
              child: WeatherWidget(
                color: color,
              ),
            ),
          ],
        ),
      );
    }

    Widget _mobileNative = _mobile(GlorifiColors.basicLightGrey);

    Widget _mobileWeb = _mobile(GlorifiColors.basicLightGrey);

    Widget _tablet = Padding(
      padding: EdgeInsets.symmetric(vertical: 25.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _getGreeting(
              headlineBold30Secondary(color: GlorifiColors.biscayBlue)),
          WeatherWidget(color: GlorifiColors.biscayBlue)
        ],
      ),
    );

    Widget _desktop = Padding(
      padding: EdgeInsets.symmetric(vertical: 25.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _getGreeting(
            headlineBold30Secondary(color: GlorifiColors.biscayBlue),
          ),
          WeatherWidget(color: GlorifiColors.biscayBlue)
        ],
      ),
    );

    return AdaptiveBuilder(builder: (context, sizingInfo) {
      if (sizingInfo.isWebMobile) {
        return _mobileWeb;
      } else if (sizingInfo.isTablet) {
        return _tablet;
      } else if (sizingInfo.isDesktop) {
        return _desktop;
      } else {
        return _mobileNative;
      }
    });
  }
}
