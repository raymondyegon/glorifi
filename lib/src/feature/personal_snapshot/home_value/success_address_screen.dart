import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/controllers/home_value_controller.dart';
import 'package:glorifi/src/feature/cockpit/feed_sections/personal_snapshot/link_data_flow/link_data_flow_controller.dart';
import 'package:glorifi/src/feature/success/success_screen.dart';
import 'package:glorifi/src/routes/app_pages.dart';

enum AddressFlowType {
  edit,
  addFromFinancialData,
  add,
}

class SuccessAddressScreen extends GetView<HomeValueController> {
  const SuccessAddressScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments
        as AddressFlowTypeScreenArguments;

    final appBarTitle = args.flowType != AddressFlowType.edit ? 'Add' : 'Edit';
    final buttonText = 'Close';
    final text = args.flowType != AddressFlowType.edit ? 'Added' : 'Edited';
    final VoidCallback onPressedButton = () {
      if (args.flowType == AddressFlowType.addFromFinancialData) {
        LinkDataFlowController().accountFlagsController.flags.value.hasAddr =
            true;
        Get.back();
      } else if (args.flowType == AddressFlowType.edit) {
        Get.back();
      } else {
        LinkDataFlowController().accountFlagsController.flags.value.hasAddr =
            true;
        Get.until((route) => route.settings.name == Routes.cockpit);
      }
    };

    return SuccessScreen(
      appBarTitle: '$appBarTitle Address',
      title: '',
      text: 'Your Home Address Was $text!',
      buttonText: buttonText,
      onPressedButton: onPressedButton,
      centerTitle: false,
    );
  }
}

class AddressFlowTypeScreenArguments {
  final AddressFlowType flowType;

  AddressFlowTypeScreenArguments({
    Key? key,
    this.flowType = AddressFlowType.add,
  });
}
