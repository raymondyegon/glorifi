import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/feature/credit_card_2/apply_for_card/model/acc_screen_info_model.dart';
import 'package:glorifi/src/feature/credit_card_2/apply_for_card/screens/acc/expense/controller/expense_controller.dart';
import 'package:glorifi/src/feature/credit_card_2/apply_for_card/widgets/acc_container.dart';
import 'package:glorifi/src/feature/credit_card_2/apply_for_card/widgets/accommodation_type_card.dart';
import 'package:glorifi/src/routes/app_pages.dart';

class ACCAccommodationScreen extends GetView<ExpenseController> {
  const ACCAccommodationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ACCContainer(
      info: ACCScreensInfo.ACCAccommodationScreen,
      children: controller.accommodationTypes.map((accommodation) {
        return AccommodationTypeCard(
          title: accommodation,
          onTap: () {
            controller.setSelectedAccommodationType(accommodation);
            Get.toNamed(Routes.accHousingCost);
          },
        );
      }).toList(),
    );
  }
}
