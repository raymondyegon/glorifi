import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/feature/banking/open_account/model/oao_screen.dart';
import 'package:glorifi/src/feature/banking/open_account/oao_controller.dart';
import 'package:glorifi/src/feature/banking/open_account/screens/onboarding/oao_complete_account_screen.dart';
import 'package:glorifi/src/feature/banking/open_account/widgets/oao_container.dart';
import 'package:glorifi/src/feature/banking/open_account/widgets/oao_error_screen.dart';
import 'package:glorifi/src/feature/banking/open_account/widgets/oao_footer_note.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive.dart';
import 'package:glorifi/src/widgets/text_field/glorifi_text_field.dart';

class OAOShippingScreen extends StatefulWidget {
  OAOShippingScreen({Key? key}) : super(key: key);

  @override
  State<OAOShippingScreen> createState() => _OAOShippingScreenState();
}

class _OAOShippingScreenState extends State<OAOShippingScreen> {
  OAOController controller = Get.find();

  // int shipping = 0;
  bool terms = false;

  Widget _info(String title, String subtitle, bool value) {

    return BoxSelection(
      title: title,
      subtitle: subtitle,
      onTap: () {
          controller.application.expeditedShipping(value);
      },
      isSelected: value == controller.application.expeditedShipping.value,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          body: OAOContainer(
            disclosureWidget: controller.application.giveExpeditedShippingOption
                ? OAOFooterNote(
                    title: "Please Note:",
                    plainText:
                        r"Should you opt for expedited shipping, your account will be debited $15.00 after 7 business days",
                  )
                : SizedBox.shrink(),
            info: OAOScreensInfo.OAOShippingScreen,
            children: _content(),
            onContinue: () async {
              try {
                return controller.onOrderDebitCard();
              } catch (error) {
                OAOController.showGenericErrorSnackBar(context);
              }
            },
          ),
        ));
  }

  List<Widget> _content() {
    return <Widget>[
      Text(
        "Shipping Type",
        style: TextStyle(color: GlorifiColors.darkBlue, fontSize: 26),
      ).paddingOnly(bottom: 15),
      if (controller.application.giveExpeditedShippingOption)
        Text(
          "Choose your shipping option.",
          style: TextStyle(fontSize: 16, height: 1.3),
        ).paddingOnly(bottom: 30),
      BoxSelection(
        title: "Standard",
        subtitle: "Estimated delivery: 5 - 7 days",
        onTap: () {
          controller.application.expeditedShipping(false);
        },
        isSelected: !controller.application.expeditedShipping.value,
      ).paddingOnly(bottom: 10),
      controller.application.giveExpeditedShippingOption
          ? BoxSelection(
              title: r"Expedited ($15.00)",
              subtitle: "Estimated delivery: 1-3 days",
              onTap: () {
                controller.application.expeditedShipping(true);
              },
              isSelected: controller.application.expeditedShipping.value,
            ).paddingOnly(bottom: 20)
          : SizedBox.shrink(),
      Text("Address", style: TextStyle(fontSize: 16)).paddingOnly(bottom: 10, top: 30),
      Text(
        controller.application.hasMailingAddress
            ? controller.application.mailingAddress.formatted
            : controller.application.address.formatted,
        style: TextStyle(fontSize: 16),
      ).paddingOnly(bottom: 10),
    ];
  }
}
