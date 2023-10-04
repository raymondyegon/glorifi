import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/glorifi_values.dart';
import 'package:glorifi/src/utils/responsive/responsive_extensions.dart';
import 'package:glorifi/src/widgets/tap/ripple.dart';

class ProfileTextFormFieldWidget extends StatelessWidget {
  final String label;
  final String? value;
  final Function()? onTap;
  final bool verified;
  final bool isSpecial;
  final bool enabled;
  final bool isLockVisible;

  ProfileTextFormFieldWidget({
    required this.label,
    this.value,
    this.onTap,
    this.verified = true,
    this.isSpecial = false,
    this.enabled = false,
    this.isLockVisible = true,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Ripple(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(top: GlorifiValues.margin),
        child: Stack(
          children: [
            TextField(
              decoration: InputDecoration(
                label: Text(
                  label,
                  style:
                      smallRegular16Primary(color: GlorifiColors.greyProfile),
                ),
                isDense: true,
              ),
              style: smallBold16Primary(color: GlorifiColors.midnightBlue),
              enabled: enabled,
              controller: TextEditingController(text: value),
            ),
            Positioned(
              right: 10.w,
              bottom: 16.h,
              child: isSpecial
                  ? Container()
                  : verified
                      ? _getVerifiedWidget()
                      : _getUnverifiedWidget(),
            )
          ],
        ),
      ),
    );
  }

  Widget _getVerifiedWidget() {
    return Row(
      children: [
        isLockVisible
            ? Icon(
                Icons.lock,
                size: 20.sp,
                color: GlorifiColors.creditBgGrey,
              ).paddingOnly(right: 5)
            : Container(),
        Icon(
          Icons.check_circle_outline,
          size: 20.sp,
          color: GlorifiColors.lightGreenProfile,
        ),
      ],
    );
  }

  Widget _getUnverifiedWidget() {
    return Row(
      children: [
        Text(
          "Unverified",
          style: captionRegular14Primary(
            color: GlorifiColors.redError,
          ),
        ).paddingOnly(right: 5),
        Icon(
          Icons.error_outline,
          size: 20.sp,
          color: GlorifiColors.redError,
        )
      ],
    );
  }
}
