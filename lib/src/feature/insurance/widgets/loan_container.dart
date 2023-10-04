import 'package:flutter/material.dart';
import 'package:glorifi/src/utils/responsive/responsive.dart';

class LoanContainer extends StatelessWidget {
  const LoanContainer({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      curve: Curves.bounceInOut,
      duration: Duration(milliseconds: 1000),
      decoration: BoxDecoration(
          color: Colors.transparent, borderRadius: BorderRadius.circular(5)),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 24.0.h, horizontal: 16.w),
        child: child,
      ),
    );
  }
}
