import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/feature/insurance/widgets/connect_to_insurance_web.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/routes/app_pages.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_base_widget.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_widgets/adaptive_scaffold.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/login_status/login_status.dart';
import 'package:glorifi/src/utils/responsive/responsive_extensions.dart';
import 'package:glorifi/src/utils/text_constants.dart';
import 'package:glorifi/src/widgets/appbars/glorifi_appbar.dart';
import 'package:glorifi/src/widgets/loading/glorifi_spinner.dart';

import '../../utils/constants.dart';

class ContinueCreateQuoteScreen extends StatelessWidget {
  String? title, vendor, initialUrl, category;

  ContinueCreateQuoteScreen({Key? key}) : super(key: key) {
    title = Get.parameters['title'];
    vendor = Get.parameters['vendor'];
    initialUrl = Get.parameters['initialUrl'];
    category = Get.parameters['category'];

    if (initialUrl == null && category != null) {
      // condition true means this is a redirect from Unqork to Bindable
      initialUrl = bindableUrlMap[category];
      vendor = 'bindable';
    }
  }

  @override
  Widget build(BuildContext context) {
    return AdaptiveBuilder(
      builder: (context, sizingInfo) {
        return AdaptiveScaffold(
          backgroundColor: GlorifiColors.grey,
          appBar: GlorifiAppBar(
            elevation: 0,
            title: "Accounts",
            trailing: Trailing(
              text: TextConstants.close,
              onTap: Get.back,
            ),
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(vertical: 80.h, horizontal: 24.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Right this way...",
                  style: headlineRegular31Secondary(
                      color: GlorifiColors.cornflowerBlue),
                ),
                SizedBox(
                  height: 24.h,
                ),
                Text(
                  "To give you the best quote, we need to route you to one of our network providers.",
                  style: bodyRegular18Primary(color: GlorifiColors.darkBlue),
                ),
                SizedBox(
                  height: 87.h,
                ),
                FutureBuilder(
                  future: Future.delayed(Duration(seconds: 2)),
                  builder: (_, s) {
                    if (s.connectionState != ConnectionState.done) {
                      Center(
                        child: GlorifiSpinner(
                          size: 72,
                        ),
                      );
                    } else {
                      CheckLoginStatus.checkLoginStatus(
                          alreadyLoggedIn, notLoggedIn);
                    }

                    return Center(
                      child: GlorifiSpinner(
                        size: 72,
                      ),
                    );
                  },
                ),
                Spacer(),
                Text(
                  "You will be subject to the network provider's terms and conditions",
                  textAlign: TextAlign.center,
                  style: xSmallRegular12Primary(color: GlorifiColors.darkBlue),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  alreadyLoggedIn() {
    Get.off(ConnectToInsuranceWeb(
        url: initialUrl, vendor: vendor, title: title ?? ''));
  }

  notLoggedIn() {
    Get.toNamed(Routes.login, arguments: "REDIRECT");
  }
}
