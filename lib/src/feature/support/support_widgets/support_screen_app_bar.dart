import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/utils/responsive/responsive.dart';

class SupportScreenAppbar extends StatelessWidget {
  final Widget? body;
  final String? title;
  final TextStyle? titleStyle;

  final bool? isCloseIcon;

  const SupportScreenAppbar(
      {Key? key, this.body, this.title, this.titleStyle, this.isCloseIcon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 64.h,
        backgroundColor: Colors.white,
        elevation: 3,
        centerTitle: false,
        leading: IconButton(
          onPressed: Get.back,
          icon: Icon(
            Icons.arrow_back_ios_outlined,
            size: 16.sp,
            color: Colors.black,
          ),
        ),
        actions: [
          isCloseIcon == true
              ? Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: Icon(
                    Icons.close,
                    color: Colors.black,
                  ),
                )
              : SizedBox.shrink()
        ],
        title: Text(
          title!,
          style: titleStyle,
        ),
      ),
      body: body,
    );
  }
}
