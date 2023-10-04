import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/utils/responsive/responsive.dart';

class CCPartner extends StatelessWidget {
  final List<String> partners;

  const CCPartner({required this.partners, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      direction: Axis.horizontal,
      spacing: 40.h,
      runSpacing: 39.h,
      children: List.generate(
        partners.length,
        (index) => Image.asset(
          partners[index],
          height: 53.h,
          width: 80.w,
        ),
      ),
    ).marginOnly(left: 24.w, right: 32.w, top: 46.h, bottom: 46.h);
  }
}
