import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/feature/banking/open_account/model/oao_member_application.dart';
import 'package:glorifi/src/feature/banking/open_account/oao_controller.dart';
import 'package:glorifi/src/feature/banking/open_account/screens/exit/oao_exit_screen.dart';
import 'package:glorifi/src/feature/banking/open_account/screens/order_card/oao_order_debt_card_screen.dart';
import 'package:glorifi/src/feature/banking/widgets/outlined_button_widget.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/routes/app_pages.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive.dart';

class OAOSkipFundButton extends GetView<OAOController> {
  const OAOSkipFundButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Text(
        controller.application.selectedProduct?.group != "CD"
            ? 'Not ready? You can always fund your account later on your accounts tab.'
            : 'CD account must be funded with a minimum deposit of \$${minCDDeposit}.00 ',
        style: smallRegular16Primary(color: GlorifiColors.midnightBlue).copyWith(height: 24 / 16),
      ),
      SizedBox(height: 24.h),
      OutlinedButtonWidget(
          text: controller.application.selectedProduct?.group == "CD"
              ? "Cancel Application"
              : 'Skip',
          onTap: () async {
            if (controller.fromEBS) {
              Get.back();
            } else {
              switch (controller.application.selectedProduct!.group) {
                case 'DDA':
                  await controller.fetchDebitCardOptions();
                  return Get.to(() => OAODebitCardScreen());
                case 'SAV':
                  return Get.to(() => OAOExitScreen());
                case 'CD':
                  showDialog(
                      barrierColor: GlorifiColors.ebonyBlue.withOpacity(0.95),
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0))),
                          title: Text(
                            "Are you sure?",
                            style: TextStyle(
                                color: GlorifiColors.darkBlueColor,
                                fontSize: 31),
                          ),
                          content: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'This is will terminate your application, your information will not be saved.',
                                style: TextStyle(
                                  fontSize: 14,
                                  height: 24 / 14,
                                  color: GlorifiColors.darkBlue,
                                ),
                              ).paddingOnly(bottom: 20),
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  Get.offNamed(Routes.cockpit);
                                },
                                style: TextButton.styleFrom(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 20),
                                  minimumSize: Size(double.infinity, 0),
                                  backgroundColor: GlorifiColors.midnightBlue,
                                  shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8)),
                                  ),
                                ),
                                child: Text(
                                  'Yes, Cancel',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ).paddingOnly(bottom: 15),
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                style: TextButton.styleFrom(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 20),
                                  minimumSize: Size(double.infinity, 0),
                                  backgroundColor: GlorifiColors.white,
                                  // side: BorderSide(
                                  //   color: GlorifiColors.silver,
                                  //   width: 2,
                                  //   style: BorderStyle.solid,
                                  // ),
                                  // shape: const RoundedRectangleBorder(
                                  //   borderRadius: BorderRadius.all(Radius.circular(8)),
                                  // ),
                                ),
                                child: Text(
                                  'No, Go Back',
                                  style: TextStyle(
                                    color: GlorifiColors.midnightBlue,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      });
              }
            }
          })
    ]);
  }
}
