import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:shimmer/shimmer.dart';

class BundleDetailsTextShimmer extends StatelessWidget {
  final String text;
  final TextStyle? textStyle;
  final Color highlightColor;
  final Color baseColor;

  const BundleDetailsTextShimmer({
    Key? key,
    required this.text,
    required this.textStyle,
    this.highlightColor: GlorifiColors.grey,
    this.baseColor: GlorifiColors.grey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width,
      child: Shimmer.fromColors(
        baseColor: baseColor,
        highlightColor: highlightColor,
        child: Text(
          text,
          textAlign: TextAlign.left,
          style: textStyle,
        ),
      ),
    );
  }
}
