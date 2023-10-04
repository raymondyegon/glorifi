import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/feature/personal_snapshot/credit_score/detail_screen/widgets/credit_score_details.dart';
import 'package:glorifi/src/feature/personal_snapshot/credit_score/detail_screen/widgets/credit_score_gauge.dart';
import 'package:glorifi/src/controllers/credit_score_detail_screen_controller.dart';

class CreditScoreContainer extends StatelessWidget {
  const CreditScoreContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<CreditScoreDetailScreenController>();

    return Container(
      width: double.infinity,
      color: Color(0xFF141B3F),
      child: Column(
        children: [
          Text(
            'As of 05/30/2022',
            style: TextStyle(
              fontSize: 12,
              color: Color(0xFFCFD8E6),
            ),
          ),
          Stack(
            alignment: Alignment.bottomCenter,
            children: [
              CreditScoreGauge(
                  controller.creditScoreModel.value.data!.creditScore),
              Positioned(
                bottom: 20,
                child: CreditScoreDetails(
                  date: '05/15/2022',
                  scoreChange: 2,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
