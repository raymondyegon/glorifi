import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/routes/app_pages.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive.dart';

class ReferralWidget extends StatelessWidget {
  const ReferralWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed(Routes.referral);
      },
      child: Container(
        padding: EdgeInsets.all(15),
        alignment: Alignment.center,
        height: 200.h,
        width: 342.w,
        margin: EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: GlorifiColors.midnightBlue,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Column(
          children: [
            Container(
              height: 72.h,
              width: 72.w,
              padding: EdgeInsets.all(15),
              margin: EdgeInsets.all(15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                gradient: LinearGradient(
                  begin: FractionalOffset.topCenter,
                  end: FractionalOffset.bottomCenter,
                  colors: [
                    Color(0xFF1F3B73),
                    Color(0xFF4773CA),
                  ],
                ),
              ),
              child: SvgPicture.asset("assets/images/logo.svg"),
            ),
            Text(
              "Invite a Friend",
              style: headlineBold31Secondary(
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
