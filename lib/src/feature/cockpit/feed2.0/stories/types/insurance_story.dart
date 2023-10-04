import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:glorifi/src/feature/cockpit/feed2.0/stories/types/base_story.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/routes/app_pages.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive.dart';

class InsuranceStory extends StatelessWidget {
  const InsuranceStory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseStory(
        onTap: () => Get.toNamed(Routes.insuranceCategoryList),
        child: Stack(
          children: [
            Image.asset(
              "assets/images/insurance_bg1.png",
              fit: BoxFit.fill,
              width: double.infinity,
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    const Color(0xFF03213D).withOpacity(1.0),
                    const Color(0xFF16253200).withOpacity(0.1),
                  ],
                  begin: const FractionalOffset(0.0, 0.7),
                  end: const FractionalOffset(0.0, 0.2),
                  stops: [0.0, 0.6],
                ),
              ),
            ),
            Padding(
              padding:
                  EdgeInsets.only(left: 15.0.w, right: 15.0.w, bottom: 100.0.h),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 100.h,
                  ),
                  Text(
                    "Get Your Insurance\nQuick Quote",
                    textAlign: TextAlign.center,
                    style: headlineRegular32Secondary(color: Colors.white),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                          width: 69.w,
                          child: Divider(
                            color: GlorifiColors.white,
                            height: 1.0,
                          )),
                      Icon(
                        Icons.star,
                        color: GlorifiColors.darkOrange,
                      ),
                      SizedBox(
                          width: 69.w,
                          child: Divider(
                            color: GlorifiColors.white,
                            height: 1.0,
                          ))
                    ],
                  ),
                  SizedBox(
                    height: 50.h,
                  ),
                  Text(
                    " GloriFi users save up to 40%",
                    style: smallBold16Primary(color: Colors.white),
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Learn More",
                        style: smallBold16Primary(color: Colors.white),
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      Icon(
                        Icons.arrow_forward_sharp,
                        color: GlorifiColors.darkOrange,
                        size: 25.w,
                      )
                    ],
                  )
                ],
              ),
            ),
          ],
        ));
  }
}
