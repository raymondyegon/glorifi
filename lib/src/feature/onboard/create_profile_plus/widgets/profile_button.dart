import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/feature/onboard/create_profile_plus/widgets/profile_colors.dart';
import 'package:glorifi/src/feature/onboard/create_profile_plus/widgets/profile_text.dart';
import 'package:glorifi/src/utils/glorifi_values.dart';

Widget profileNextButton(
  BuildContext context,
  String title,
  Widget icon,
  Function() onTap, {
  double width = double.infinity,
  Color primaryColor = profileRed,
  bool isLoading = false,
  double fontSize = 16,
  Color textColor = profileButtonTextColor,
  double iconSpacing = 2,
  Color splashColor = Colors.white,
}) {
  final screenSize = MediaQuery.of(context).size;

  if (width == double.infinity) {
    width = screenSize.width - 60;
  }

  return Container(
      width: width,
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(GlorifiValues.radius_6)),
            primary: primaryColor,
            onPrimary: splashColor,
            padding: EdgeInsets.symmetric(
              horizontal: GlorifiValues.padding,
              vertical: GlorifiValues.extraSmallPadding,
            )),
        child: isLoading
            ? CircularProgressIndicator(
                color: Colors.white,
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                        color: textColor,
                        fontSize: fontSize,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: iconSpacing),
                  icon
                ],
              ),
        onPressed: isLoading ? () {} : onTap,
      ));
}

Widget editProfileButton(Function() onTap) {
  return SizedBox(
      width: 130,
      height: 35,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            primary: profileRed,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            )),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Edit Profile",
              style: TextStyle(color: profileBackgroundColor, fontSize: 14),
            ),
            Icon(
              Icons.edit,
              color: Colors.white,
              size: 16,
            )
          ],
        ),
        onPressed: onTap,
      ));
}

Widget editAccountRowItem(Widget icon, String title) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Row(
        children: [icon, editProfileBodyText(title).paddingOnly(left: 10)],
      ),
      Icon(
        Icons.arrow_forward,
      )
    ],
  ).paddingOnly(top: 20);
}

Widget fullWidthContinueButton(
    BuildContext context, String title, Widget icon, Function() onTap) {
  return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(primary: profileRed),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: TextStyle(
                  color: profileButtonTextColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w600),
            ),
            icon
          ],
        ),
        onPressed: onTap,
      ));
}
