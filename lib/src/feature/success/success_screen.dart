import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_base_widget.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive_extensions.dart';

class SuccessScreen extends StatelessWidget {
  SuccessScreen({
    Key? key,
    required this.appBarTitle,
    required this.title,
    this.text,
    required this.buttonText,
    required this.onPressedButton,
    this.extraButtonText,
    this.onPressedExtraButton,
    this.centerTitle,
  }) : super(key: key);

  final String appBarTitle;
  final String title;
  final String? text;
  final String buttonText;
  final VoidCallback onPressedButton;
  final String? extraButtonText;
  final VoidCallback? onPressedExtraButton;
  final bool? centerTitle;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return Future.value(false);
      },
      child: AdaptiveBuilder(builder: (context, sizingInfo) {
        bool isDesktop = sizingInfo.isDesktop;
        return Scaffold(
            body: Center(
          child: Container(
              width: isDesktop ? 672.w : Get.width,
              height: isDesktop ? 437.h : null,
              decoration: BoxDecoration(
                color: Color(0xFF03213D),
                borderRadius: isDesktop ? BorderRadius.circular(16) : null,
              ),
              padding: EdgeInsets.symmetric(
                horizontal: 30,
              ),
              child: Padding(
                padding: EdgeInsets.only(
                  top: 68,
                  left: 24.w,
                  right: 24.w,
                  bottom: 40,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        SvgPicture.asset(
                          'assets/icons/successful.svg',
                          width: 64,
                        ),
                        SizedBox(height: 32.0.h),
                        Visibility(
                          visible: title.isNotEmpty,
                          child: Text(
                            title,
                            textAlign: TextAlign.center,
                            style: headlineRegular26Secondary(
                              color: GlorifiColors.white,
                            ),
                          ),
                        ),
                        SizedBox(height: 32.0.h),
                        if (text != null)
                          Text(
                            text!,
                            textAlign: TextAlign.center,
                            style: headlineRegular26Secondary(
                                color: GlorifiColors.white),
                          ),
                      ],
                    ),
                    SizedBox(height: text != null ? 25.0.h : 15.0.h),
                    Column(
                      children: [
                        TextButton(
                          onPressed: onPressedButton,
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            minimumSize: Size(double.infinity, 0),
                            backgroundColor: Colors.white,
                            shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                            ),
                          ),
                          child: Text(
                            buttonText,
                            style: TextStyle(
                              color: Color(0xff212C37),
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        extraButtonText != null
                            ? TextButton(
                                onPressed: onPressedExtraButton,
                                child: Text(
                                  extraButtonText!,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              )
                            : SizedBox()
                      ],
                    ),
                  ],
                ),
              )),
        ));
      }),
    );
  }
}
