import 'package:flutter/material.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive.dart';
import 'package:shimmer/shimmer.dart';

class LoadingShimmer extends StatelessWidget {
  const LoadingShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
          ),
          width: double.infinity,
          margin: EdgeInsets.only(
            top: 20,
            left: 24.w,
            right: 24.w,
            bottom: 10,
          ),
          height: 500,
          child: Shimmer.fromColors(
            baseColor: Colors.white60,
            highlightColor: GlorifiColors.greyBgColor.withOpacity(
              0.3,
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              height: 500,
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
          ),
          width: double.infinity,
          margin: EdgeInsets.only(
            top: 20,
            left: 24.w,
            right: 24.w,
          ),
          height: 500,
          child: Shimmer.fromColors(
            baseColor: Colors.white60,
            highlightColor: GlorifiColors.greyBgColor.withOpacity(
              0.3,
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              height: 500,
            ),
          ),
        ),
      ],
    );
  }
}
