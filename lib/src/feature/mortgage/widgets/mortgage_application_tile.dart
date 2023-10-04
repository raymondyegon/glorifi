import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/feature/mortgage/model/mortgage_data.dart';
import 'package:glorifi/src/routes/app_pages.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive_extensions.dart';

import '../../../font_style_global.dart';

class MortgageApplicationTile extends StatelessWidget {
  const MortgageApplicationTile({
    Key? key,
    required this.element,
  }) : super(key: key);

  final MortgageData element;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // element.status == "Application in Progress"
        //     ? Get.toNamed(Routes.mortgageDetail, arguments: {"data": element})
        //     : Get.toNamed(Routes.mortgageDetailSubmitted);

        /// Commenting the lines of code because for now when an application is in status submitted the application details page has to be displayed.
        /// Ticket: https://app.asana.com/0/1202108389793418/1202442889249013/f

        Get.toNamed(Routes.mortgageDetail, arguments: {"data": element});
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(4.h),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 16.0.h, horizontal: 16.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Application #" + element.referenceNumber,
                    style: smallSemiBold16Primary(
                      color: GlorifiColors.cornflowerBlue,
                    ),
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  Text(
                    "Started On " + element.formattedCreatedDate(),
                    style: captionSemiBold14Primary(
                      color: GlorifiColors.denimBlue,
                    ),
                  )
                ],
              ),
              SizedBox(
                width: 15.w,
              ),
              Text(
                element.status == "Application in Progress"
                    ? "In Progress"
                    : "Submitted",
                style: smallBold16Primary(
                  color: GlorifiColors.bloodOrange,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
