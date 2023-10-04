import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/feature/cockpit/feed2.0/stories/types/base_story.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/utils/responsive/responsive.dart';

import '../../../../../routes/app_pages.dart';

class CreditStory extends StatelessWidget {
  const CreditStory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseStory(
      onTap: () => Get.toNamed(Routes.creditCardComingSoonScreen),
      child: Stack(
        children: [
          Image.asset(
            "assets/images/credit_bg.png",
            fit: BoxFit.cover,
            width: double.infinity,
            height: 804.h,
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 40.0.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25.0, vertical: 8),
                  child: SvgPicture.asset(
                    "assets/images/glorifi_logo/logo_dark_bg.svg",
                    width: 60.w,
                    height: 60.h,
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25.0, vertical: 8),
                  child: Text(
                    "Finally, a Card\nYou Want to\nCarry.",
                    style: leadBold24Secondary(color: Colors.white),
                  ),
                ),
                Image.asset("assets/images/credit_card_gold.png")
              ],
            ),
          ),
        ],
      ),
    );
  }
}
