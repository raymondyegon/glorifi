import 'package:flutter/material.dart';
import 'package:glorifi/src/utils/responsive/responsive_extensions.dart';

class CustomContainer extends StatelessWidget {
  final Widget child;

  const CustomContainer({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 16.w,
        vertical: 16.h,
      ),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          16.sp,
        ),
        border: Border.all(
          color: Colors.black26.withOpacity(0.1),
        ),
        color: Colors.black26.withOpacity(0.1),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 16.w,
          vertical: 16.h,
        ),
        child: child,
      ),
    );
  }
}
