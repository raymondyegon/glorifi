import 'package:flutter/material.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:shimmer/shimmer.dart';

class AccountCardShimmer extends StatelessWidget {
  const AccountCardShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      height: 87,
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
    );
  }
}
