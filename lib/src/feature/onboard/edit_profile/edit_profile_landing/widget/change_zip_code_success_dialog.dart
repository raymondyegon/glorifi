import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_base_widget.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';

Future changeZipCodeSuccessDialog(BuildContext context) {
  return showDialog(
      barrierColor: Color(0xEB03213D),
      context: context,
      builder: (dialogContext) {
        return AdaptiveBuilder(builder: (context, sizingInfo) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),


            content: Container(
              padding: EdgeInsets.symmetric(vertical: 4, horizontal: 4),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                        onPressed: Get.back,
                        icon: SvgPicture.asset("assets/images/ic_close.svg")),
                  ),

                  Container(
                    padding: EdgeInsets.symmetric(vertical: 80, horizontal: 120),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Center(
                          child: Text("Success!",
                              style: headlineBold31Primary(
                                  color: GlorifiColors.midnightBlue)),
                        ),
                        SizedBox(
                          height: 55,
                        ),
                        Center(child: SvgPicture.asset("assets/images/ic_check.svg")),
                        SizedBox(
                          height: 55,
                        ),
                        SizedBox(
                          width: 300,
                          child: Text(
                            "Your zip code has been changed.",
                            maxLines: 2,
                            textAlign: TextAlign.center,
                            style: headlineRegular31Primary(
                                color: GlorifiColors.midnightBlue),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
      });
}
