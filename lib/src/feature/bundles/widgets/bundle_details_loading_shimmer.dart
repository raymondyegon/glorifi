import 'package:flutter/material.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive_extensions.dart';
import 'package:shimmer/shimmer.dart';

class BundleDetailsLoadingShimmer extends StatelessWidget {
  final Color highlightColor;
  final Color baseColor;
  final double? height;
  final bool rounded;

  BundleDetailsLoadingShimmer({
    Key? key,
    required this.height,
    this.highlightColor: GlorifiColors.grey,
    this.baseColor: GlorifiColors.grey,
    this.rounded = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      highlightColor: highlightColor,
      baseColor: baseColor.withOpacity(0.2),
      child: Container(
        height: height!.h,
        width: double.infinity,
        decoration: BoxDecoration(
          color: GlorifiColors.grey,
          borderRadius: rounded
              ? BorderRadius.all(
                  Radius.circular(
                    1.h,
                  ),
                )
              : null,
        ),
      ),
    );
  }
}
