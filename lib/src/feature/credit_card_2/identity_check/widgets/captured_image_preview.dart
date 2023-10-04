import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/feature/credit_card_2/identity_check/controller/Identity_check_controller.dart';
import 'package:glorifi/src/utils/responsive/responsive.dart';

class CapturedImagePreview extends GetView<IdentityCheckController> {
  final File image;

  const CapturedImagePreview({required this.image, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 342.w,
      height: 296.h,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.r),
        child: Image.file(
          image,
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
