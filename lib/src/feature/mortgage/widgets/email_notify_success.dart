import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_widgets/adaptive_scaffold.dart';
import 'package:glorifi/src/utils/glorifi_assets.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive.dart';

import '../../../font_style_global.dart';
import '../../../utils/adaptive/adaptive_base_widget.dart';
import '../../../utils/adaptive/adaptive_widgets/adaptive_grid.dart';
import '../../../utils/text_constants.dart';
import '../../../widgets/buttons/app_button.dart';

class EmailNotifySuccess extends StatelessWidget {
  final Function? onTap;
  final bool showLegalName;

  const EmailNotifySuccess({
    Key? key,
    required this.onTap,
    required this.showLegalName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AdaptiveBuilder(
      builder: (context, sizingInfo) {
        if (sizingInfo.isDesktop) {
          return AdaptiveScaffoldWeb().getScaffold(
            context: context,
            backgroundColor: GlorifiColors.midnightBlue,
            body: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(top: 200),
                child: Stack(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: sizingInfo.isDesktop
                              ? 200.w
                              : sizingInfo.isTablet
                                  ? 34.5.w
                                  : 24.5.w),
                      child: ConstrainedBox(
                        constraints: BoxConstraints(maxWidth: 1024),
                        child: AdaptiveGrid(
                          children: [
                            AdaptiveGridItem(
                              desktop: 55,
                              tablet: 100,
                              nativeMobile: 100,
                              webMobile: 100,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                    GlorifiAssets.successful,
                                  ),
                                  SizedBox(
                                    height: 38.h,
                                  ),
                                  Text(
                                    "You got it!",
                                    style: headlineRegular31Secondary(
                                      color: GlorifiColors.productsBgWhite,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            AdaptiveGridItem(
                              desktop: 45,
                              webMobile: 100,
                              tablet: 100,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Thank you for your interest. You have been added to our wait list. We’ll notify you via email.",
                                    style: smallRegular16Primary(
                                      color: GlorifiColors.white,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 35.h,
                                  ),
                                  AppButton(
                                    height: 56,
                                    elevation: 0,
                                    backgroundColor: GlorifiColors.white,
                                    borderColor: GlorifiColors.white,
                                    fontSize: 16.sp,
                                    label: "Done",
                                    textStyle: smallBold16Primary(
                                      color: GlorifiColors.ebonyBlue,
                                    ),
                                    onTap: () => onTap!(),
                                  ),
                                  Visibility(
                                    visible: showLegalName,
                                    child: Text(
                                      TextConstants.legalName,
                                      maxLines: 2,
                                      style: smallRegular8(
                                          color: GlorifiColors.white),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        } else {
          return AdaptiveScaffold(
            backgroundColor: GlorifiColors.midnightBlue,
            // appBar: GlorifiAppBar(
            //   title: 'Confirmation',
            //   disableLeading: true,
            //   trailing: Trailing(
            //     onTap: () {
            //       Get.back();
            //     },
            //     icon: Icon(
            //       Icons.close,
            //       color: Colors.black,
            //     ),
            //   ),
            // ),
            body: SafeArea(
              child: Padding(
                padding: EdgeInsets.only(
                  left: 24.w,
                  right: 24.w,
                  bottom: showLegalName ? 52.h : 32.h,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 150.h,
                    ),
                    SvgPicture.asset(
                      GlorifiAssets.successful,
                    ),
                    SizedBox(
                      height: 38.h,
                    ),
                    Text(
                      "You got it!",
                      style: headlineRegular31Secondary(
                        color: GlorifiColors.productsBgWhite,
                      ),
                    ),
                    SizedBox(
                      height: 47.h,
                    ),
                    Text(
                      "Thank you for your interest. You have been added to our wait list. We’ll notify you via email.",
                      style: smallRegular16Primary(
                        color: GlorifiColors.white,
                      ),
                    ),
                    !sizingInfo.isTablet
                        ? Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                doneButton(onTap),
                              ],
                            ),
                          )
                        : Padding(
                            padding: EdgeInsets.only(
                              top: 65.h,
                            ),
                            child: doneButton(onTap),
                          ),
                    Visibility(
                      visible: showLegalName,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 64.h,
                            ),
                            Text(
                              TextConstants.legalName,
                              maxLines: 2,
                              style: smallRegular8(color: GlorifiColors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      },
    );
  }
}

Widget doneButton(Function? onTap) {
  return AppButton(
    height: 56,
    elevation: 0,
    backgroundColor: GlorifiColors.white,
    borderColor: GlorifiColors.white,
    fontSize: 16.sp,
    label: "Done",
    textStyle: smallBold16Primary(
      color: GlorifiColors.ebonyBlue,
    ),
    onTap: () => onTap!(),
  );
}
