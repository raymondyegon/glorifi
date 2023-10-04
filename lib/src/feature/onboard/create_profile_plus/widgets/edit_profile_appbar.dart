import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';

Widget editProfileAppbar(Function() onTap, String title) {
  return Stack(
    children: [
      Row(children: [
        Container(
          height: 70,
          child: Center(
            child: Container(
              width: 25,
              height: 25,
              child: InkWell(
                child: Icon(
                  Icons.arrow_back_ios,
                  color: GlorifiColors.midnightBlue,
                  size: 18,
                ),
                onTap: onTap,
              ),
            ).paddingOnly(left: 30),
          ),
        )
      ]),
      Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 70,
              child: Center(
                  child: Text(
                title,
                style: TextStyle(
                    color: GlorifiColors.midnightBlue,
                    fontFamily: 'univers',
                    fontSize: 21),
              )),
            ),
          ])
    ],
  );
}
