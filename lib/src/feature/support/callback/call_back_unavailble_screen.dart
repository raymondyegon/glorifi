import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/routes/app_pages.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_base_widget.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_widgets/adaptive_grid.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_widgets/adaptive_scaffold.dart';
import 'package:glorifi/src/utils/glorifi_assets.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive_extensions.dart';
import 'package:glorifi/src/widgets/appbars/glorifi_appbar.dart';
import 'package:glorifi/src/widgets/shared/app_button.dart';
import 'package:glorifi/src/widgets/web/page_header.dart';

class CallbackUnavailableScreen extends StatelessWidget {
  const CallbackUnavailableScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String agentAvailability =
        'our agents are currently unavailable but we can call you back when we are open';
    return AdaptiveScaffold(
      resizeToAvoidBottomInset: false,
      appBar: GlorifiAppBar(
        title: 'Request a Callback',
        disableLeading: true,
        trailing: Trailing(
          text: 'Cancel',
          onTap: Get.back,
        ),
      ),
      body: AdaptiveBuilder(
        builder: (context, sizingInfo) {
          return SingleChildScrollView(
            physics: NeverScrollableScrollPhysics(),
            child: Column(
              children: [
                if (!sizingInfo.isNativeMobile)
                  PageHeader(
                    headerTitle: 'Request a Callback',
                    horizontalPadding: sizingInfo.isDesktop
                        ? 200.w
                        : sizingInfo.isTablet
                            ? 34.5.w
                            : sizingInfo.isWebMobile
                                ? 24.5.w
                                : 23.75.w,
                    showTrailingButton: false,
                  ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: sizingInfo.isDesktop
                        ? 200.w
                        : sizingInfo.isTablet
                            ? 34.5.w
                            : 24.w,
                  ),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: 1024),
                    child: AdaptiveGrid(
                      children: [
                        AdaptiveGridItem(
                          nativeMobile: 100,
                          desktop: 80,
                          tablet: 100,
                          webMobile: 100,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                alignment: sizingInfo.isDesktop
                                    ? Alignment.centerLeft
                                    : Alignment.center,
                                child: SvgPicture.asset(
                                  GlorifiAssets.check,
                                  height: !sizingInfo.isNativeMobile
                                      ? 160.h
                                      : 120.h,
                                  color: GlorifiColors.black.withOpacity(0.75),
                                ).paddingOnly(
                                  top: 64.h,
                                  bottom: 36.h,
                                ),
                              ),
                              Container(
                                alignment: sizingInfo.isDesktop
                                    ? Alignment.centerLeft
                                    : Alignment.center,
                                child: Text(
                                  agentAvailability,
                                  textAlign: sizingInfo.isDesktop
                                      ? TextAlign.start
                                      : TextAlign.center,
                                  style: headlineSemiBold21Secondary(
                                    color: GlorifiColors.darkBlue,
                                  ),
                                ),
                              ).paddingOnly(
                                bottom: 48.h,
                              ),
                              Container(
                                alignment: sizingInfo.isDesktop
                                    ? Alignment.centerLeft
                                    : Alignment.center,
                                child: RichText(
                                  textAlign: sizingInfo.isDesktop
                                      ? TextAlign.start
                                      : TextAlign.center,
                                  text: TextSpan(
                                    text: 'Our Support agents are available\n',
                                    style: bodySemiBold18Primary(
                                      color: GlorifiColors.midnightBlue,
                                    ),
                                    children: <InlineSpan>[
                                      TextSpan(
                                        text:
                                            'Monday - Friday, 8:00 a.m. to 10:00 p.m. (EST) and Saturday - Sunday, 9:00 a.m. to 5:00 p.m.',
                                        style: smallRegular16Primary(
                                          color: GlorifiColors.midnightBlue,
                                        ),
                                      )
                                    ],
                                  ),
                                ).paddingOnly(
                                  bottom: 64.h,
                                ),
                              ),
                              AppButton(
                                onTap: () => Get.toNamed(
                                    Routes.faqCategoriesListingScreen),
                                borderRadius: BorderRadius.circular(
                                  4.sp,
                                ),
                                label: 'Back to Support',
                                textStyle: bodyBold18Primary(
                                  color: GlorifiColors.darkBlue,
                                ),
                                side: BorderSide(
                                  color: GlorifiColors.lightBlue,
                                  width: 2.w,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
