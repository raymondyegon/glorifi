import 'package:flutter/material.dart';
import 'package:glorifi/src/feature/onboard/create_profile_plus/widgets/profile_colors.dart';
import 'package:get/get.dart';

Widget profileCard(bool activeFlag, BuildContext context, String title,
    String body, Widget leading) {
  final screenSize = MediaQuery.of(context).size;

  return Card(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15.0),
    ),
    color: activeFlag
        ? editProfileCardBackgroundColor
        : editProfileCardBackgroundColorInActive,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: screenSize.width - 160,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                    color: activeFlag ? profileIconColor : Colors.white),
              ),
              Text(
                body,
                style: TextStyle(color: profileTitleColor),
              ).paddingOnly(top: 10)
            ],
          ),
        ),
        leading,
      ],
    ).paddingAll(20),
  );
}
