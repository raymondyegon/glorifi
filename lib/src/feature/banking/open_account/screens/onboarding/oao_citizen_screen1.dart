import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/feature/banking/open_account/model/oao_screen.dart';
import 'package:glorifi/src/feature/banking/open_account/oao_controller.dart';
import 'package:glorifi/src/feature/banking/open_account/screens/exit/oao_back_screen.dart';
import 'package:glorifi/src/feature/banking/open_account/screens/onboarding/oao_citizen_screen2.dart';
import 'package:glorifi/src/feature/banking/open_account/screens/onboarding/oao_review_application_screen.dart';
import 'package:glorifi/src/feature/banking/open_account/widgets/oao_container.dart';
import 'package:glorifi/src/feature/banking/open_account/widgets/option_selection_tile.dart';

// Step 3 of 6
// https://app.asana.com/0/1202239119682092/1202240186732671/f
class OAOVerifyCitizenshipScreen1 extends GetView<OAOController> {
  const OAOVerifyCitizenshipScreen1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OAOContainer(
      info: OAOScreensInfo.OAOVerifyCitizenshipScreen1,
      children: _content(context),
    );
  }

  Future<void> _handleOptionSelected(BuildContext context, Function nextScreen) async {
    try {
      nextScreen();
    } catch (error, trace) {
      OAOController.showGenericErrorSnackBar(context);
    }
  }

  List<Widget> _content(BuildContext context) {
    return [
      InkWell(
        child: OptionSelectionTile(title: "U.S. Citizen"),
        onTap: () async => await _handleOptionSelected(context, () async {
          controller.applicationInProgress.value.USCitizenship = "US Citizen";
          controller.applicationInProgress.value.nonUSCitizenship.clear();
          controller.onConfirmCitizenship();
        }),
      ),
      InkWell(
        child: OptionSelectionTile(title: "U.S. Permanent Resident (Green Card)"),
        onTap: () async => await _handleOptionSelected(context, () async {
          controller.applicationInProgress.value.USCitizenship = "U.S. Permanent Resident (Green Card)";
          controller.applicationInProgress.value.nonUSCitizenship.clear();
          controller.onConfirmCitizenship();
        }),
      ),
      InkWell(
        child: OptionSelectionTile(title: "Non Resident Alien"),
        onTap: () async => await _handleOptionSelected(context, () async {
          controller.applicationInProgress.value.USCitizenship = "Non Resident Alien";
          await Get.to(
            () => OAOVerifyCitizenshipScreen2(),
          );
        }),
      ),
    ];
  }
}
