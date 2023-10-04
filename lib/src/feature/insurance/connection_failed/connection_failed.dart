import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_base_widget.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_widgets/adaptive_grid.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_widgets/adaptive_scaffold.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive_extensions.dart';
import 'package:glorifi/src/widgets/appbars/glorifi_appbar.dart';
import 'package:glorifi/src/widgets/buttons/primary_buton_dark.dart';

import '../../../utils/support/support_navigation_helper.dart';

class ConnectionFailed extends StatelessWidget {
  const ConnectionFailed({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return AdaptiveBuilder(builder: (context, sizingInfo) {
      return AdaptiveScaffold(
          appBar: GlorifiAppBar(
            elevation: 0,
            title: "",
            disableLeading: true,
          ),
          body: AdaptiveGrid(
            children: [
              AdaptiveGridItem(
                webMobile: 100,
                nativeMobile: 100,
                desktop: 100,
                tablet: 100,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.h),
                  child: Column(
                    children: [
                      Align(
                          alignment: Alignment.center,
                          child: SvgPicture.asset(
                            "assets/images/access_denied.svg",
                          )),
                      SizedBox(
                        height: 68.h,
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 80.w),
                        child: Text("We can’t access this page at the moment.",
                            style: headlineRegular28Secondary(
                                    color: GlorifiColors.darkBlue)
                                .copyWith(height: 1.5)),
                      ),
                      SizedBox(
                        height: 27.h,
                      ),
                      Text(
                        "We apologize for the inconvenience. Please try again later or contact Customer Support if you need immediate assistance. ",
                        style: smallRegular16Primary(
                                color: GlorifiColors.midnightBlue)
                            .copyWith(height: 1.5),
                      ),
                      SizedBox(
                        height: 88.h,
                      ),
                      PrimaryDarkButton(
                        title: "Go Back",
                        onTap: Get.back,
                      ),
                      SizedBox(
                        height: 16.h,
                      ),
                      OutlinedButton(
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(
                              width: 1.0, color: GlorifiColors.midnightBlue),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        child: InkWell(
                          child: Container(
                            width: Get.width - 90.w,
                            padding: EdgeInsets.symmetric(vertical: 16.h),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Contact Support",
                                  textAlign: TextAlign.center,
                                  style: bodyBold18Primary(
                                      color: GlorifiColors.midnightBlue),
                                ),
                                SizedBox(width: 10.w),
                                SvgPicture.asset(
                                  "assets/images/message.svg",
                                  color: GlorifiColors.midnightBlue,
                                )
                              ],
                            ),
                          ),
                          onTap: navigateToFAQ,
                        ),
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ));
    });
  }
}

Future<void> navigateToFAQ() async {
  String category = 'Insurance';
  SupportNavigationHelper.navigateToList(category);
}
