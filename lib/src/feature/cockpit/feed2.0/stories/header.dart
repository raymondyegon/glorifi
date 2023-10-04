import 'package:flutter/material.dart';
import 'package:glorifi/src/feature/cockpit/feed2.0/greeting/greeting.dart';
import 'package:glorifi/src/feature/cockpit/profile/profile_sections/profile_header.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive.dart';

class Header extends StatelessWidget {
  final Widget child;
  final Color color;

  const Header(
      {Key? key, required this.child, this.color: GlorifiColors.midnightBlue})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 1.sh,
        width: 1.sw,
        color: color,
        child: Stack(children: [
          child,
          Column(children: [
            SizedBox(
              height: 46.h,
            ),
            ProfileHeader(
                color: GlorifiColors.white,
                buttonColor: Colors.black.withOpacity(0.15),
                pointsColor: GlorifiColors.white),
            SizedBox(
              height: 30.h,
            ),
            Greeting(),
          ]),
        ]));
  }
}
