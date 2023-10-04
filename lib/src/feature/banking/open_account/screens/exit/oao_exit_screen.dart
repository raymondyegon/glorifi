import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/feature/banking/open_account/oao_controller.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/routes/app_pages.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_base_widget.dart';
import 'package:glorifi/src/utils/glorifi_assets.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive.dart';
import 'package:glorifi/src/widgets/buttons/app_button.dart';
import 'package:lottie/lottie.dart';

import '../../../../../utils/adaptive/adaptive_widgets/adaptive_scaffold.dart';

// Step 6 of 6
// https://app.asana.com/0/1202239119682092/1202240186732683/f
class OAOExitScreen extends StatelessWidget {
  const OAOExitScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OAOController());
    return AdaptiveBuilder(
      builder: (context, sizingInfo) {
        return AdaptiveScaffoldNative().getScaffold(
          context: context,
          backgroundColor: GlorifiColors.defaultGradientStartColor,
          body: SingleChildScrollView(
            child: Column(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: _content(controller, context),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

_onContinue(OAOController controller, BuildContext context) async {
  await Get.offNamed(Routes.cockpit);
}

Widget _copyField(title, value, context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Flexible(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: captionSemiBold14Primary(
                color: GlorifiColors.darkBlue,
              ),
            ),
            SizedBox(
              height: 2.h,
            ),
            Text(
              value,
              style: smallRegular16Primary(
                color: GlorifiColors.darkGrey80,
              ),
            ),
          ],
        ),
      ),
      InkWell(
        child: SvgPicture.asset(
          GlorifiAssets.copyClipboard,
        ),
        onTap: () {
          Clipboard.setData(
            ClipboardData(text: value),
          );
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Copied to clipboard"),
          ));
        },
      ),
    ],
  );
}

List<Widget> _content(OAOController controller, BuildContext context) {
  return [
    Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 50.h,
        ),
        Center(
          child: Lottie.asset(
            'assets/json/complete.json',
            width: 200.h,
            repeat: false,
          ),
        ),
        Text(
          "Congratulations on opening your account!",
          textAlign: TextAlign.center,
          style: headlineBold23Primary(
            color: GlorifiColors.productsBgWhite,
          ),
        ).paddingOnly(bottom: 32.h),
        Text(
          "Your account is ready to go! Here are your new account details.",
          textAlign: TextAlign.center,
          style: smallRegular16Primary(
            color: GlorifiColors.white,
          ),
        ).paddingOnly(bottom: 35.h),
        Container(
          width: double.infinity,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6.r),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 16.w,
                vertical: 24.h,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 4.h,
                  ),
                  Center(
                    child: Text(
                      'Account Details',
                      style: leadBold24Primary(
                        color: GlorifiColors.darkBlue,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  Text(
                    'You can use your new account right away!',
                    style: smallRegular16Primary(
                      color: GlorifiColors.black,
                    ),
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  _copyField(
                    'Account Number',
                    controller.application.accountNumber.toString(),
                    context,
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  _copyField(
                    'Routing Number',
                    controller.application.routingNumber.toString(),
                    context,
                  ),
                ],
              ),
            ),
          ),
        ).paddingOnly(
          bottom: 44.h,
        ),
        AppButton(
          height: 70,
          elevation: 0,
          backgroundColor: GlorifiColors.white,
          borderColor: GlorifiColors.white,
          fontSize: 18.sp,
          label: "Done",
          textStyle: bodyBold18Primary(
            color: GlorifiColors.midnightBlueColor,
          ),
          onTap: () => _onContinue(controller, context),
        ).paddingAll(4.h),
        SizedBox(
          height: 50.h,
        ),
      ],
    ).paddingSymmetric(
      horizontal: 24.w,
    ),
  ];
}
