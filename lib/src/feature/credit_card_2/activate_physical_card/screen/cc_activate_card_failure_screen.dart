import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/routes/app_pages.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_base_widget.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_widgets/adaptive_scaffold.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/widgets/buttons/primary_button.dart';

class CCActivateCardFailureScreen extends StatelessWidget {
  const CCActivateCardFailureScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AdaptiveBuilder(builder: (context, sizingInfo) {
      return AdaptiveScaffold(
        backgroundColor: GlorifiColors.bgColor,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Spacer(
              flex: 3,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Text("Your card cannot be activated at this time.",
                  style:
                      headlineRegular31Primary(color: GlorifiColors.darkBlue)),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 24.0, vertical: 48),
              child: Text("Try again in a few minutes.",
                  style: smallRegular16Primary(color: GlorifiColors.darkBlue)),
            ),
            Spacer(
              flex: 2,
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 24.0, vertical: 33),
              child: PrimaryButton(
                title: "Done",
                primaryColor: GlorifiColors.midnightBlue,
                height: 64,
                fontSize: 18,
                textColor: GlorifiColors.white,
                onTap: () {
                  Get.until((route) => Get.currentRoute == Routes.ccDashboard);
                },
              ),
            ),
          ],
        ),
      );
    });
  }
}
