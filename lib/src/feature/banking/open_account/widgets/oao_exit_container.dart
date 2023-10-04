import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/feature/banking/open_account/oao_controller.dart';
import 'package:glorifi/src/feature/cockpit/controllers/cockpit_controller.dart';
import 'package:glorifi/src/routes/app_pages.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive.dart';

class OAOExitContainer extends GetView<OAOController> {
  final String title;
  final String subtitle;
  final String ctaTitle;

  const OAOExitContainer({Key? key, required this.title, required this.subtitle, required this.ctaTitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    _onContinue() async {
      CockpitController cockpitController = Get.find();
      await Get.offNamed(Routes.cockpit);
    }

    return Scaffold(
        backgroundColor: GlorifiColors.greyF3,
        body: Container(
              padding: EdgeInsets.only(right: 20, left: 20, top: 235, bottom: 50),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      title,
                      style: TextStyle(color: GlorifiColors.darkBlueColor, fontFamily: "OpenSans",
                          fontSize: 30, fontWeight: FontWeight.w400),
                    ).paddingOnly(bottom: 30.h),
                    Text(
                      subtitle,
                      style: TextStyle(color: GlorifiColors.darkBlueColor, fontFamily: "OpenSans",fontSize: 16,fontWeight: FontWeight.w400),
                    ),
                    Spacer(),
                    Container(
                        width: 1.sw,
                        child: TextButton(
                            style: TextButton.styleFrom(
                              primary: GlorifiColors.primaryButtonProgressColor,
                              backgroundColor: GlorifiColors.primaryButtonProgressColor,
                              padding: EdgeInsets.all(20),
                            ),
                            child: Text(
                              ctaTitle,
                              style: TextStyle(
                                  color: GlorifiColors.superLightGrey,
                                  fontSize: 18,
                                  fontFamily: "OpenSans",
                                  fontWeight: FontWeight.w700),
                            ),
                            onPressed: _onContinue)),
                    Container(
                      padding: EdgeInsets.only(top: 10),
                        width: 1.sw,
                        child: TextButton(
                            style: TextButton.styleFrom(
                              primary: GlorifiColors.greyF3,
                              backgroundColor: GlorifiColors.greyF3,
                              padding: EdgeInsets.all(20),
                            ),
                            child: Text(
                              "Contact Support",
                              style: TextStyle(
                                  color: GlorifiColors.defaultGradientStartColor,
                                  fontSize: 16,
                                  fontFamily: "OpenSans",
                                  fontWeight: FontWeight.w600),
                            ),
                            onPressed: _onTapSupport))
                  ])),
        );
  }

  void _onTapSupport() {
    Get.toNamed(Routes.contactSupportCategoryScreen);
  }
}
