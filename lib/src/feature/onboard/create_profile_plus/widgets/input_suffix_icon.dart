import 'package:flutter/material.dart';
import 'package:glorifi/src/widgets/tap/ripple.dart';

///This widget is used to show a icon at the end of a input field
///[iconColor] One can pass icon color to set the icon color
///[onTap] used for set a tap option on the icon
class InputSuffixIcon extends StatelessWidget {
  final IconData iconData;
  final Color iconColor;
  final Function()? onTap;

  const InputSuffixIcon({
    Key? key,
    required this.iconData,
    this.onTap,
    this.iconColor = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Ripple(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(right: 6),
        child: Icon(
          iconData,
          color: iconColor,
          size: 20,
        ),
      ),
    );
  }
}
