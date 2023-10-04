import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glorifi/src/feature/policy_detail/widget/policy_text_style.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive.dart';
import 'package:glorifi/src/widgets/buttons/app_button.dart';

class PolicyDetailTile extends StatelessWidget {
  const PolicyDetailTile(
      {Key? key,
      required this.isPolicy,
      this.data = "",
      required this.buttonColor,
      required this.buttonStrokeColor,
      required this.onTap,
      this.underWriter = "",
      required this.buttonLabel,
      this.showContent = true,
      this.buttonTextColor = GlorifiColors.white,
      required this.title})
      : super(key: key);

  final bool isPolicy, showContent;
  final String data, buttonLabel, title, underWriter;
  final VoidCallback onTap;
  final Color buttonColor, buttonStrokeColor, buttonTextColor;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Container(
        padding: EdgeInsets.all(16.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              textAlign: TextAlign.start,
              style: PolicyTextStyle.textStylePolicy,
            ),
            SizedBox(
              height: 16.h,
            ),
            Visibility(
              visible: showContent,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          isPolicy ? "Policy Number" : "Contact Us",
                          style: PolicyTextStyle.textStylePolicyDetail,
                        ),
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Visibility(
                              visible: !isPolicy,
                              child: Container(
                                child: SvgPicture.asset(
                                  "assets/icons/phone_icon.svg",
                                ),
                                padding: EdgeInsets.only(right: 8.r),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(right: 10.r),
                              child: Text(
                                data,
                                textAlign: TextAlign.end,
                                style: PolicyTextStyle.textStyleAddressData,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 12.h,
                  ),
                ],
              ),
            ),
            Visibility(
              visible: isPolicy,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Policy Underwriter",
                    textAlign: TextAlign.start,
                    style: captionRegular14Primary(
                        color: GlorifiColors.cornflowerBlue),
                  ),
                  Text(
                    underWriter,
                    textAlign: TextAlign.start,
                    style: captionBold14Primary(
                        color: GlorifiColors.cornflowerBlue),
                  ),
                ],
              ),
            ),
            Visibility(
              visible: isPolicy,
              child: SizedBox(
                height: 24.h,
              ),
            ),
            AppButton(
              height: 60,
              backgroundColor: buttonColor,
              borderColor: buttonStrokeColor,
              fontSize: 18.sp,
              textColor: buttonTextColor,
              label: buttonLabel,
              textStyle: TextStyle(
                color: buttonTextColor,
                fontFamily: 'OpenSans',
                fontWeight: FontWeight.bold,
                fontSize: 18.sp,
              ),
              onTap: onTap,
            ),
            SizedBox(
              height: 10.h,
            ),
          ],
        ),
      ),
    );
  }
}
