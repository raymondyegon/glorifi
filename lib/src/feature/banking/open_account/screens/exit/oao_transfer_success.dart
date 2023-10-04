
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/feature/banking/open_account/oao_controller.dart';
import 'package:glorifi/src/feature/banking/open_account/screens/exit/oao_exit_screen.dart';
import 'package:glorifi/src/feature/banking/open_account/screens/onboarding/oao_cd.dart';
import 'package:glorifi/src/feature/banking/open_account/screens/order_card/oao_order_debt_card_screen.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_base_widget.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive.dart';
import 'package:glorifi/src/widgets/buttons/app_button.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

import '../../../../../utils/adaptive/adaptive_widgets/adaptive_scaffold.dart';

// Step 6 of 6
// https://app.asana.com/0/1202239119682092/1202240186732683/f
class OAOTransferSuccess extends StatelessWidget {
  const OAOTransferSuccess({Key? key}) : super(key: key);

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
  switch (controller.application.selectedProduct!.group) {
    case 'DDA':
      //Checking
      await controller.fetchDebitCardOptions();
      return Get.to(() => OAODebitCardScreen());
    case 'SAV':
      return Get.to(() => OAOExitScreen());
    case 'CD':
      return Get.to(() => OAOCD());
  }
}

Widget _field(title, value, context) {
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
      )
    ],
  );
}

String dateNow() {
  var now = DateTime.now();
  return DateFormat.yMd().format(now);
}

List<Widget> _content(OAOController controller, BuildContext context) {
  final formatCurrency = new NumberFormat.simpleCurrency();
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
          "Your transfer has been initiated.",
          textAlign: TextAlign.center,
          style: headlineBold23Primary(
            color: GlorifiColors.productsBgWhite,
          ),
        ).paddingOnly(bottom: 32.h),
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
                      formatCurrency.format(controller.application.fundedAmount),
                      style: TextStyle(color: GlorifiColors.headerBlue, fontWeight: FontWeight.bold, fontSize: 30),
                    ),
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  Text(
                    'has been transferred from ${controller.selectedFundingAccount.value!.institution}' +
                        ' ${controller.selectedFundingAccount.value!.mask} ' +
                        'to GloriFi ${controller.application.selectedProduct!.description} ${controller.application.accountNumber!.substring(7)}',
                    style: smallRegular16Primary(
                      color: GlorifiColors.black,
                    ),
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  _field(
                    'Confirmation',
                    "<number>",
                    context,
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  _field(
                    'Date',
                    dateNow(),
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
