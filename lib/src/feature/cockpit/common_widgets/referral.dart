import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive.dart';
import 'package:glorifi/src/utils/share/share_app_util.dart';

class Referral extends StatelessWidget {
  const Referral({
    Key? key,
  }) : super(key: key);

  Future<void> share() async {
    await ShareAppUtil.showShareApp(null, null, null);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Image.asset("assets/images/referralbg.png",
                width: double.infinity, fit: BoxFit.fill),
            Positioned(
              left: 20.w,
              top: 40.h,
              child: InkWell(
                onTap: Get.back,
                child: Icon(
                  Icons.arrow_back_ios_outlined,
                  color: Colors.white,
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 500.h,
                alignment: Alignment.bottomCenter,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: FractionalOffset.topCenter,
                    end: FractionalOffset.bottomCenter,
                    colors: [
                      Color(0xFF212C37).withOpacity(0.0),
                      Color(0xFF03213D).withOpacity(1),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
                padding: EdgeInsets.only(bottom: 40.h, left: 25.w),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SvgPicture.asset(
                        "assets/images/logo.svg",
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      RichText(
                        text: TextSpan(
                          text: 'GLORI',
                          style: headlineBold31Secondary(),
                          children: <TextSpan>[
                            TextSpan(
                              text: 'FI',
                              style: headlineBold31Secondary(),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Text(
                        "Invite a friend.",
                        style: headlineRegular31Secondary(
                          color: GlorifiColors.lightBlue,
                        ),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Text(
                        "Invite your friends to download the\nGloriFI financial wellness app.",
                        style: captionRegular14Secondary(
                          color: GlorifiColors.white,
                        ),
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      SizedBox(
                        width: 342.w,
                        child: TextButton.icon(
                            onPressed: share,
                            label: Icon(Icons.arrow_right_alt),
                            icon: Text("Get Started",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold)),
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 40, vertical: 20),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              backgroundColor: Colors.white,
                              primary: Colors.black,
                            )),
                      ),
                    ])),
          ],
        ));
  }
}
