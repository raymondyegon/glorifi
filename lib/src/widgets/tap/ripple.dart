import 'package:flutter/material.dart';

///This widget is used to set on tap on any widget with a ripple effect
///[child] the child widget on which the tap will be perform
///[rippleColor] one can set the ripple color using this
///[rippleRadius] set the radius of the ripple
class Ripple extends StatelessWidget {
  final Function()? onTap;
  final Widget? child;
  final Color rippleColor;
  final double rippleRadius;

  const Ripple({
    Key? key,
    this.child,
    required this.onTap,
    this.rippleColor = Colors.black38,
    this.rippleRadius = 8,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(rippleRadius),
        highlightColor: rippleColor,
        onTap: onTap,
        child: child,
      ),
    );
  }
}
