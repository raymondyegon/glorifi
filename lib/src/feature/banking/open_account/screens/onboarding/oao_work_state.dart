import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/feature/banking/open_account/model/oao_screen.dart';
import 'package:glorifi/src/feature/banking/open_account/oao_controller.dart';
import 'package:glorifi/src/feature/banking/open_account/screens/onboarding/oao_annual_income_screen.dart';
import 'package:glorifi/src/feature/banking/open_account/widgets/oao_container.dart';
import 'package:glorifi/src/feature/banking/open_account/widgets/option_selection_tile.dart';
import 'package:glorifi/src/widgets/text_field/glorifi_text_field.dart';

class OAOWorkStateScreen extends GetView<OAOController> {
  const OAOWorkStateScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OAOContainer(
      info: OAOScreensInfo.OAOWorkStateScreen,
      children: _content(context),
      
    );
  }

  Widget _selection(title, context) {
    return InkWell(
        child: OptionSelectionTile(title: title),
        onTap: () async {
          controller.application.workStatus(title);
          return Get.to(() => OAOAnnualIncomeScreen());
        });
  }

  List<Widget> _content(BuildContext context) {
    return [
      _selection("Employed", context),
      _selection("Retired", context),
      _selection("Student", context),
      _selection("Unemployed", context),
      _selection("Self Employed/Business Owner", context)
    ];
  }
}
