import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive.dart';

class AccommodationTypeCard extends StatelessWidget {
  final String title;

  final VoidCallback onTap;

  const AccommodationTypeCard(
      {required this.title, required this.onTap, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(22.sp),
          decoration: BoxDecoration(
              color: GlorifiColors.white, borderRadius: BorderRadius.circular(8.r)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
              children: [
            Text(title,
                style: bodySemiBold18Primary(color: GlorifiColors.cornflowerBlue))
          ])).marginOnly(bottom: 8.h),
      onTap: onTap,
    );
  }
}
