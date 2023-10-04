import 'package:flutter/material.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';

class EBSWidgetContainer extends StatelessWidget {
  final Widget child;
  const EBSWidgetContainer({required this.child, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        decoration: BoxDecoration(
          color: GlorifiColors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: child,
        ),
      ),
    );
  }
}
