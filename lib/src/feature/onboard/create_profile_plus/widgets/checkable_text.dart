import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/feature/onboard/create_profile_plus/widgets/profile_colors.dart';
import 'package:glorifi/src/widgets/checkbox/app_checkbox.dart';

class CheckableText extends StatelessWidget {
  final Function(bool?)? onCheckChange;
  bool isChecked;
  final Widget text;
  final Color uncheckedBorderColor;
  final CrossAxisAlignment? crossAxisAlignment;

  CheckableText({
    Key? key,
    required this.text,
    this.onCheckChange,
    this.isChecked = false,
    this.uncheckedBorderColor = profileIconColor,
    this.crossAxisAlignment,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = Get.width;

    final CrossAxisAlignment alignment = crossAxisAlignment == null ? (screenWidth >= 786
        ? CrossAxisAlignment.center
        : CrossAxisAlignment.start) : crossAxisAlignment!;

    return Row(
      crossAxisAlignment: alignment,
      children: [
        Transform.scale(
          scale: 1.4,
          child: AppCheckbox(
            activeColor: profileTitleColor,
            checkColor: profileBackgroundColor,
            uncheckedBorderColor: uncheckedBorderColor,
            onCheckChange: (value) {
              isChecked = value == true;
              onCheckChange?.call(value);
            },
            initialValue: isChecked,
          ),
        ),
        SizedBox(width: 8),
        Expanded(
          child: text,
        )
      ],
    );
  }
}
