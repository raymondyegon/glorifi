import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/utils/text_constants.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive_extensions.dart';
import 'package:glorifi/src/widgets/loading/glorifi_spinner.dart';
import '../../../font_style_global.dart';
import '../../../utils/adaptive/adaptive_base_widget.dart';
import '../../../utils/adaptive/adaptive_widgets/adaptive_scaffold.dart';
import '../../../widgets/appbars/glorifi_appbar.dart';

class CreditScoreRetrieveSuccessView extends StatelessWidget {
  CreditScoreRetrieveSuccessView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AdaptiveBuilder(builder: (context, sizingInfo) {
      return AdaptiveScaffold(
        appBar: GlorifiAppBar(
          title: "Verify Identity",
          textStyle: bodySemiBold18Primary(
            color: GlorifiColors.cornflowerBlue,
          ),
          leading: Leading(
            icon: Icon(
              Icons.close,
              color: Colors.black,
            ),
            onTap: Get.back,
          ),
        ),
        backgroundColor: GlorifiColors.bgColor,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (!sizingInfo.isNativeMobile) ...[
              ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 1024),
                child: Text("Verify Identity",
                    style: headlineBold30Secondary(
                      color: GlorifiColors.cornflowerBlue,
                    )),
              ).paddingSymmetric(
                  vertical: sizingInfo.isWebMobile ? 48.h : 64.h,
                  horizontal: sizingInfo.isDesktop
                      ? 200.w
                      : sizingInfo.isTablet
                          ? 32.w
                          : 24.w)
            ],
            Expanded(
              child: Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: 1024),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Spacer(),
                      GlorifiSpinner(),
                      SizedBox(height: 32.h),
                      Text(
                        TextConstants.retrieving_your_credit_scoreText,
                        textAlign: TextAlign.center,
                        style: headlineRegular26Secondary(color: GlorifiColors.cornflowerBlue),
                      ),
                      Spacer(flex: 2)
                    ],
                  ),
                ).paddingSymmetric(
                    horizontal: sizingInfo.isDesktop
                        ? 200.w
                        : sizingInfo.isTablet
                            ? 126.w
                            : 24.w),
              ),
            ),
          ],
        ),
      );
    });
  }
}
