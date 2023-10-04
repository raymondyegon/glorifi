import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/feature/onboard/create_profile_plus/widgets/profile_colors.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/widgets/tap/ripple.dart';

Future<bool?> showbottomsheet(String infoTitle, String infoMessage,
    {String okayButtonText = "Got it!"}) async {
  final context = Get.context!;
  bool? _returnValue;
  await showModalBottomSheet<bool?>(
    isScrollControlled: true,
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20.0),
    ),
    builder: (BuildContext context) {
      final screenSize = MediaQuery.of(context).size;
      return Wrap(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(5.0),
                child: Container(
                  height: 5,
                  width: screenSize.width * .3,
                  color: Colors.black,
                ),
              ).paddingOnly(top: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Ripple(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      "Cancel",
                      style: TextStyle(color: profileRed),
                    ).paddingAll(10),
                  ).paddingAll(20)
                ],
              ),
              Text(
                infoTitle,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 26,
                ),
              ).paddingOnly(left: 30, right: 30),
              Text(
                infoMessage,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black),
              ).paddingAll(30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Ripple(
                    onTap: () {
                      Navigator.pop(context, false);
                    },
                    child: Container(
                      width: screenSize.width * 0.5 - 40,
                      height: 60,
                      decoration: BoxDecoration(
                          border: Border.all(color: GlorifiColors.midnightBlue),
                          borderRadius: BorderRadius.all(Radius.circular(8))),
                      child: Center(
                          child: Text(
                        "Don't Enable",
                        style: TextStyle(
                            color: GlorifiColors.midnightBlue,
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                      )),
                    ),
                  ).paddingOnly(right: 20),
                  Ripple(
                    onTap: () {
                      Navigator.pop(context, true);
                    },
                    child: Container(
                      width: screenSize.width * 0.5 - 40,
                      height: 60,
                      decoration: BoxDecoration(
                          color: GlorifiColors.lightRed,
                          borderRadius: BorderRadius.all(Radius.circular(8))),
                      child: Center(
                          child: Text(
                        "Enable",
                        style: TextStyle(
                            color: GlorifiColors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                      )),
                    ),
                  )
                ],
              ).paddingOnly(right: 30, left: 30, bottom: 50),
            ],
          ),
        ],
      );
    },
  ).then((value) {
    _returnValue = value;
  });
  return _returnValue;
}
