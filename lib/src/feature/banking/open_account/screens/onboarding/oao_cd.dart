
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/feature/banking/open_account/model/oao_screen.dart';
import 'package:glorifi/src/feature/banking/open_account/oao_controller.dart';
import 'package:glorifi/src/feature/banking/open_account/screens/exit/oao_exit_screen.dart';
import 'package:glorifi/src/feature/banking/open_account/screens/onboarding/oao_contact_info_screen.dart';
import 'package:glorifi/src/feature/banking/open_account/widgets/oao_container.dart';
import 'package:glorifi/src/feature/banking/open_account/widgets/oao_footer_note.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive.dart';
import 'package:intl/intl.dart';

class OAOCD extends GetView<OAOController> {
  const OAOCD({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OAOContainer(
      info: OAOScreensInfo.OAOCD,
      children: _content(),
      showBackButton: false,
      disclosureWidget: OAOFooterNote(
        title: '',
        plainText: _disclaimer(),
      ),
      onContinue: () async {
          await Get.to(
            () => OAOExitScreen(),
        );
      },
    );
  }

  String _disclaimer() {
    String date = DateFormat.yMd().format(DateTime.now());
    return "Annual Percentage Yield (APY) and Interest Rate are accurate as of $date. Early withdrawal penalties may apply if you withdraw any funds prior to the maturity date.";
  }

  List<Widget> _row(String name, String value) {
    return [
      Text(
        name,
        style: TextStyle(color: GlorifiColors.darkBlueColor, fontSize: 14, fontWeight: FontWeight.w400),
      ),
      Text(
        value,
        style: TextStyle(fontSize: 14, height: 1.6),
      ),
      SizedBox(
        height: 20.h,
      )
    ];
  }

  List<Widget> _content() {
    return <Widget>[
      Container(
          decoration: BoxDecoration(
            color: GlorifiColors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                blurRadius: 15,
                color: GlorifiColors.black.withOpacity(.080),
              )
            ],
          ),
          padding: EdgeInsets.all(20),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              "Fixed Rate",
              style: TextStyle(color: GlorifiColors.darkBlueColor, fontSize: 24, fontWeight: FontWeight.w700),
            ).paddingOnly(bottom: 20),
            Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(width: 0.5, color: GlorifiColors.silver),
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      child:
                          Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: _row("Interest Rate", controller.application.selectedProduct!.interestRate)),
                      width: 0.5.sw - 20,
                    ),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: _row("APY", controller.application.selectedProduct!.apy)),
                  ],
                )).paddingOnly(bottom: 20),
            ..._row("Maturity Date", controller.application.selectedProduct!.term),
            ..._row("Opening Deposit", "\$${controller.application.fundedAmount}"),
            ..._row("Funding Source", "Account funded from ${controller.selectedFundingAccount.value!.institution}"),
            ..._row("Interest paid at", "Maturity"),
            Container(
                width: 1.sw,
                child: TextButton.icon(
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        side: BorderSide(
                          color: GlorifiColors.lightBlue,
                          width: 2,
                          style: BorderStyle.solid,
                        ),
                        borderRadius: BorderRadius.circular(
                          10,
                        )),
                    primary: Colors.white,
                    backgroundColor: GlorifiColors.white,
                    padding: EdgeInsets.all(15),
                  ),
                  icon: Text(
                    "Download",
                    style: TextStyle(fontSize: 16, color: GlorifiColors.darkBlue),
                  ),
                  label: Icon(Icons.download_sharp, color: GlorifiColors.darkBlue),
                  onPressed: () {},
                )).paddingOnly(top: 30.h, bottom: 10.h)
          ])).paddingOnly(bottom: 40.h)
    ];
  }
}
