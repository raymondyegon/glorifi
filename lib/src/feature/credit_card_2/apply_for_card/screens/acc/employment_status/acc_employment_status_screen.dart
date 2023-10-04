import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/feature/credit_card_2/apply_for_card/model/acc_screen_info_model.dart';
import 'package:glorifi/src/feature/credit_card_2/apply_for_card/screens/acc/employment_status/controller/employment_status_controller.dart';
import 'package:glorifi/src/feature/credit_card_2/apply_for_card/widgets/acc_container.dart';
import 'package:glorifi/src/feature/credit_card_2/apply_for_card/widgets/acc_reactive_box.dart';
import 'package:glorifi/src/utils/responsive/responsive_extensions.dart';

import 'acc_annual_income_screen.dart';

class ACCEmploymentStatusScreen extends GetView<EmploymentStatusController> {
  const ACCEmploymentStatusScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ACCContainer(
      info: ACCScreensInfo.ACCEmployeeStatusScreen,
      children: controller.employmentStatusOptions.map(_buildOptions).toList(),
    );
  }

  Widget _buildOptions(title) {
    return ACCReactiveBox(
      title: title,
      onTap: () async {
        controller.setSelectedEmploymentStatus = title;
        Get.to(() => ACCAnnualIncomeScreen());
      },
    ).paddingOnly(bottom: 24.h);
  }
}
