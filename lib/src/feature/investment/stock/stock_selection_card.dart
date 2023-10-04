import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/feature/investment/controller/stock_selection_controller.dart';
import 'package:glorifi/src/feature/investment/models/stock_selection_model.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive_extensions.dart';

class StockSelectionCard extends StatelessWidget {
  const StockSelectionCard(
      {Key? key, required this.stockSelectionModel, required this.currentIndex})
      : super(key: key);

  final StockSelectionModel stockSelectionModel;
  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<StockSelectionController>();

    return Obx(
      () => InkWell(
        onTap: () {
          controller.index.value = currentIndex;
        },
        child: Card(
          color: GlorifiColors.cardBgColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.h),
          ),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                  color: controller.index.value == currentIndex
                      ? GlorifiColors.textColorBlack
                      : GlorifiColors.cardBgColor,
                  width: 1),
              borderRadius: BorderRadius.circular(15.h),
            ),
            child: Center(
              child: Image.asset(stockSelectionModel.image),
            ),
          ),
        ),
      ),
    );
  }
}
