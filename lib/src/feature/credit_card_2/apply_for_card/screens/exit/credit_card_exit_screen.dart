import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/core/logger.dart';
import 'package:glorifi/src/feature/banking/open_account/oao_controller.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/routes/app_pages.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive.dart';
import 'package:lottie/lottie.dart';

// Step 6 of 6
// https://app.asana.com/0/1202239119682092/1202240186732683/f
class CreditCardExitScreen extends GetView<OAOController> {
  const CreditCardExitScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _onContinue() async {
      Log.info(
          "Final OAO Form Data: ${controller.applicationInProgress.value}");

      try {
        if (controller.workflowOptions.mockAPI != null) {
          await controller.workflowOptions.mockAPI!();
        }
        await Get.offNamed(Routes.cockpit);
      } catch (error) {
        OAOController.showGenericErrorSnackBar(context);

        if (controller.workflowOptions.ignoreFailedAPICall) {
          await Future.delayed(const Duration(milliseconds: 500));
          await Get.toNamed(Routes.cockpit);
        }
      }
    }

    Widget _copyField(title, value) {
      return InkWell(
          onTap: () {
            Clipboard.setData(ClipboardData(text: value));
          },
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(title,
                      style: TextStyle(
                          color: GlorifiColors.darkBlue,
                          fontWeight: FontWeight.w600)),
                  Text(value,
                      style: captionRegular14Primary(
                          color: GlorifiColors.darkGrey80)),
                ]),
                Icon(
                  Icons.copy,
                  size: 19,
                  color: GlorifiColors.darkBlue,
                )
              ]));
    }

    List<Widget> _content() {
      return [
        Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          SizedBox(
            height: 0.1.sh + 130,
          ),
          Container(
                  margin: EdgeInsets.only(top: 20),
                  child: Text("Congratulations on opening your account!",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: GlorifiColors.white,
                          fontSize: 23,
                          fontWeight: FontWeight.bold)))
              .paddingOnly(bottom: 30),
          Text("Your account is ready to go! Here are your new account details.",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: GlorifiColors.white, fontSize: 16))
              .paddingOnly(bottom: 30),
          Container(
            width: double.infinity,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10),
                    Text('Account Details',
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                            color: GlorifiColors.darkBlue)),
                    SizedBox(height: 20),
                    Text('You can use your new account right away!',
                        style: TextStyle(
                            color: GlorifiColors.black, fontSize: 15)),
                    SizedBox(height: 20),
                    _copyField('Account Number',
                        controller.application.accountNumber.toString()),
                    SizedBox(
                      height: 20,
                    ),
                    _copyField('Routing Number',
                        controller.application.routingNumber.toString()),
                  ],
                ),
              ),
            ),
          ).paddingOnly(bottom: 20),
          Container(
                  width: 1.sw,
                  child: TextButton(
                      style: TextButton.styleFrom(
                        primary: Colors.white,
                        backgroundColor: GlorifiColors.white,
                        padding: EdgeInsets.all(18),
                      ),
                      child: Text(
                        "Done",
                        style: TextStyle(
                            color: GlorifiColors.blueMidnightBlue,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                      onPressed: _onContinue))
              .paddingOnly(bottom: 60)
        ])
      ];
    }

    return Scaffold(
        backgroundColor: GlorifiColors.blueMidnightBlue,
        body: Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
            child: SingleChildScrollView(
                child: Stack(children: [
              Center(
                  child: Lottie.asset(
                'assets/json/complete.json',
                width: 200,
                repeat: false,
              )).paddingOnly(top: 0.1.sh),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: _content(),
              )
            ]))));
  }
}
