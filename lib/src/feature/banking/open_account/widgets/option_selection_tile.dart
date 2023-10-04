import 'package:flutter/material.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive_extensions.dart';

class OptionSelectionTile extends StatelessWidget {
  const OptionSelectionTile({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.sw,
      decoration: BoxDecoration(
        color: GlorifiColors.white,
        borderRadius: BorderRadius.circular(8.r),
      ),
      padding: EdgeInsets.all(24.r),
      margin: EdgeInsets.only(bottom: 20.h),
      child: Text(
        title,
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: GlorifiColors.darkBlueTint[500],
        ),
      ),
    );
  }
}
