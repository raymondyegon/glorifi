// ignore_for_file: use_raw_strings

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/feature/banking/servicing/screens/transfer/transfer_controller.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/routes/app_pages.dart';
import 'package:glorifi/src/utils/glorifi_assets.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

class TransferSuccess extends GetView<TransferController> {
  const TransferSuccess({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.find<TransferController>();

    final usCurrency = NumberFormat("#,##0.00", "en_US");

    //Get Todays Date And Format
    final DateTime todaysDate = DateTime.now();
    final DateFormat formatter = DateFormat('MMMM dd, yyyy');
    final String dateFormatted = formatter.format(todaysDate);

    return Scaffold(
      backgroundColor: Color(0xFF03213D),
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          horizontal: 20,
        ),
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                top: 60,
              ),
              child: Lottie.asset(
                'assets/json/complete.json',
                width: 200.h,
                repeat: false,
              ),
            ),
            Text(
              "Your money has been transferred.",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFFF5F5F5),
                fontFamily: "OpenSans",
                fontWeight: FontWeight.w700,
                fontSize: 23,
              ),
            ),
            Container(
              height: 268.h,
              width: double.infinity.w,
              color: Colors.white,
              margin: EdgeInsets.only(
                top: 80,
              ),
              child: Column(
                children: [
                  //Amount
                  FittedBox(
                    fit: BoxFit.fitWidth,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.attach_money,
                          size: 55,
                          color: Color(0xFF131A3D),
                        ),
                        Obx(
                          () => Text(
                            usCurrency.format(controller.transferAmount.value),
                            style: TextStyle(
                              fontFamily: "OpenSans",
                              fontWeight: FontWeight.w600,
                              fontSize: 80,
                              color: Color(0xFF131A3D),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // //Confirmation Number
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: _summaryRow('Confirmation',
                        controller.transferConfirmation, context),
                  ),
                  SizedBox(height: 15),
                  // Date
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: _summaryRow('Date', dateFormatted, context,
                        copyable: false),
                  ),
                ],
              ),
            ),
            InkWell(
              onTap: () {
                // TODO: Update accounts so user doesn't have to pull to refresh
                Get.offAllNamed(Routes.cockpit);
              },
              child: Container(
                margin: EdgeInsets.only(
                  top: 50.h,
                ),
                height: 70,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                child: Center(
                  child: Text(
                    "Done",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      fontFamily: "OpenSans",
                      color: Color(0xFF212C37),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // TODO: This was copied from OAO. Might be worth lifting up to a shared widget - WC
  Widget _summaryRow(title, value, context, {bool copyable = true}) {
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
        if (copyable)
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
}
