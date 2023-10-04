import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/controllers/plaid_controller.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/utils/glorifi_assets.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive_extensions.dart';
import 'package:glorifi/src/widgets/buttons/custom_async_button.dart';
import 'package:intl/intl.dart';
import 'package:plaid_flutter/plaid_flutter.dart' as Plaidd;

class PersoneticsEmpty extends StatelessWidget {
  const PersoneticsEmpty({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PlaidController plaidController = Get.put(PlaidController());
    final DateTime todaysDate = DateTime.now();
    final DateFormat formatter = DateFormat('MMMM dd, yyyy');
    final String formatted = formatter.format(todaysDate);
    return Wrap(
      children: [
        Container(
          height: 450.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(8.r),
            ),
            // color: Colors.red,
          ),
          margin: EdgeInsets.only(
            left: 20.w,
            right: 20.w,
            top: 30,
          ),
          child: DottedBorder(
            padding: EdgeInsets.symmetric(
              horizontal: 30.w,
              vertical: 30,
            ),
            borderType: BorderType.RRect,
            radius: Radius.circular(20),
            color: Colors.black87,
            dashPattern: [10, 15],
            strokeWidth: 1,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 28.0),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      formatted,
                      style: smallSemiBold16Primary(
                          color: GlorifiColors.midnightBlue),
                    ),
                  ),
                ),
                Text(
                  "You have no Insights at this time.",
                  style: headlineRegular24Secondary(
                    color: GlorifiColors.gradientDarkBlue,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 28.0),
                  child: Text(
                    "Check back soon, or link more of your accounts for even better insights.",
                    style: smallSemiBold16Primary(
                      color: GlorifiColors.darkMidnightBlue,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        // Link Account Button
        CustomAsyncButton(
          onTap: () async {
            await plaidController.openPlaid();
          },
          width: double.infinity,
          height: 64,
          inkwellBorderRadius: BorderRadius.circular(8.r),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.r),
            color: Color.fromRGBO(21, 41, 81, 1),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                GlorifiAssets.gridAddIcon,
                width: 22.w,
                height: 22.h,
                color: GlorifiColors.primaryButtonIconColor,
              ).paddingOnly(
                right: 10.w,
              ),
              Text(
                'Link A Bank Account',
                style: bodyBold18Primary(color: GlorifiColors.white),
              ),
            ],
          ),
        ).paddingOnly(
          left: 20.w,
          right: 20.w,
          top: 50.h,
          bottom: 50.h,
        ),
      ],
    );
  }
}
