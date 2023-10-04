import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BaseTapStory extends StatelessWidget {
  final Widget child;
  final Widget? modal;
  final Function? onTap;

  const BaseTapStory(
      {Key? key, required this.modal, this.onTap, required Widget this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          if (modal != null) {
            Get.bottomSheet(
                Stack(children: [
                  modal!,
              ]),
                isScrollControlled: true,
            );
          }
          onTap?.call();
        },
        child: child);
  }
}
