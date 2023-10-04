import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/routes/app_pages.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_base_widget.dart';
import 'package:glorifi/src/utils/adaptive/adaptive_widgets/adaptive_scaffold.dart';
import 'package:glorifi/src/utils/glorifi_assets.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/widgets/buttons/primary_button.dart';

class CCActivateCardSuccessScreen extends StatelessWidget {
  const CCActivateCardSuccessScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AdaptiveBuilder(builder: (context, sizingInfo) {
      return WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: AdaptiveScaffold(
          backgroundColor: GlorifiColors.midnightBlue,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Spacer(
                flex: 2,
              ),
              Center(
                  child: SvgPicture.asset(
                GlorifiAssets.checkmark,
                color: GlorifiColors.electricGreenColor,
                width: 80,
                height: 80,
              )),
              SizedBox(
                height: 72,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Text("Your physical card is activated.",
                    textAlign: TextAlign.center,
                    style: headlineRegular31Secondary(color: Colors.white)),
              ),
              Spacer(
                flex: 2,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24.0, vertical: 33),
                child: PrimaryButton(
                  title: "Done",
                  height: 64,
                  fontSize: 18,
                  textColor: GlorifiColors.midnightBlue,
                  onTap: () {
                    Get.until((route) => Get.currentRoute == Routes.cockpit);
                  },
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
