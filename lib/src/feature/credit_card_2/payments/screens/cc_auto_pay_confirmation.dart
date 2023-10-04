import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/feature/credit_card_2/payments/screens/cc_payments_container.dart';
import 'package:glorifi/src/routes/app_pages.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive.dart';
import 'package:glorifi/src/widgets/buttons/primary_button.dart';
import 'package:lottie/lottie.dart';

class CCAutoPayConfirmation extends StatelessWidget {
  const CCAutoPayConfirmation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: GlorifiColors.midnightBlue,
        body: Container(
            padding: EdgeInsets.all(24),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Center(
                child: Lottie.asset(
                  'assets/json/complete.json',
                  width: 222.h,
                  repeat: false,
                ),
              ),
              Text(
                "Your auto pay is scheduled!",
                style: TextStyle(
                    color: GlorifiColors.white,
                    fontSize: 23,
                    fontWeight: FontWeight.w700),
              ),
              SizedBox(
                height: 60,
              ),
              Text(
                "Your first payment will begin on the date you chose.",
                textAlign: TextAlign.center,
                style: TextStyle(color: GlorifiColors.white, fontSize: 16),
              ),
              SizedBox(
                height: 120,
              ),
              PrimaryButton(
                title: "Done",
                onTap: () => Get.until(
                    (route) => Get.currentRoute == Routes.ccDashboard),
              )
            ])));
  }
}
