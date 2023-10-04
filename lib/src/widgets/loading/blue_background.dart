import 'package:flutter/material.dart';
import 'package:glorifi/src/feature/cockpit/feed2.0/stories/header.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive.dart';
import 'package:glorifi/src/widgets/loading/glorifi_spinner.dart';

class BlueBackground extends StatelessWidget {
  final bool addHeader;
  final bool addSpinner;

  const BlueBackground(
      {Key? key, this.addHeader = false, this.addSpinner = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1.sh,
      width: 1.sw,
      color: GlorifiColors.midnightBlueColor,
      child: addHeader
          ? Header(
              child: Align(
                  alignment: Alignment.center,
                  child: Container(
                      padding: EdgeInsets.only(top: 50.h),
                      child:
                          addSpinner ? GlorifiSpinner() : SizedBox.shrink())))
          : Container(),
    );
  }
}
