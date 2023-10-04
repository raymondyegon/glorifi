import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive.dart';
import '../../../widgets/headline_description.dart';
import '../../../widgets/footer_reward.dart';

class CCReward extends StatelessWidget {
  final String title;
  final String desc;
  final String reward;
  final String apr;
  final int annualFee;
  final bool isFromBrassDetailsScreen;

  const CCReward(
      {required this.title,
      required this.desc,
      required this.reward,
      required this.apr,
      required this.annualFee,
      this.isFromBrassDetailsScreen = false,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: GlorifiColors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: isFromBrassDetailsScreen ? 0 : 15,
            color: GlorifiColors.black.withOpacity(.080),
          ),
        ],
      ),
      child: Container(
        margin: EdgeInsets.only(
            top: isFromBrassDetailsScreen ? 59.h : 48.h,
            left: 24.h,
            right: 32.h),
        child: Column(
          children: [
            HeadlineDescription(
              title: title,
              desc: desc,
            ).marginOnly(bottom: 50.h),
            Divider(
              thickness: 5.h,
              color: GlorifiColors.lightBrown,
            ).marginOnly(bottom: 30.h),
            FooterReward(
              reward: reward,
              apr: apr,
              annualFee: annualFee,
              isFromBrassDetailsScreen: isFromBrassDetailsScreen,
            )
          ],
        ),
      ),
    );
  }
}
