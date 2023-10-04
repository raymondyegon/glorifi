import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/feature/cockpit/feed2.0/snapshot/sections/insights/insights_controller.dart';

void deleteInsight(BuildContext context, String id) {
  Get.defaultDialog(
    title: "Are you sure you want to delete this Insight?",
    middleText:
        "If you do nothing, Insights will drop off automatically after 35 days",
    titlePadding: EdgeInsets.only(top: 35),
    contentPadding: EdgeInsets.all(20),
    backgroundColor: Colors.white,
    titleStyle: TextStyle(
      color: Color.fromRGBO(31, 59, 115, 1),
      fontSize: 30,
      fontFamily: "univers",
    ),
    middleTextStyle: TextStyle(
      color: Color.fromRGBO(31, 59, 115, 1),
      fontFamily: "OpenSans",
    ),
    barrierDismissible: true,
    radius: 10,
    confirm: Container(
      margin: const EdgeInsets.only(bottom: 25),
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: () {
          final insightsController = Get.find<InsightsController>();
          insightsController.removeInsight(id);
          Navigator.of(context, rootNavigator: true).pop();
          // insightsController.deleteInsight(insight.id);
        },
        child: Container(
          width: Get.width * .67,
          height: 60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: Color.fromRGBO(31, 59, 115, 1),
            ),
          ),
          child: Center(
            child: Text(
              'Remove',
              style: TextStyle(
                color: Color.fromRGBO(31, 59, 115, 1),
                fontFamily: "OpenSans",
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    ),
    cancel: InkWell(
      onTap: () {
        Navigator.of(context, rootNavigator: true).pop();
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Color.fromRGBO(31, 59, 115, 1),
        ),
        width: Get.width * .67,
        height: 60,
        child: Center(
          child: Text(
            'Cancel',
            style: TextStyle(
              color: Colors.white,
              fontFamily: "OpenSans",
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    ),
  );
}
