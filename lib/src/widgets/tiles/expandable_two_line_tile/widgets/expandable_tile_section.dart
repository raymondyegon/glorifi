import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/feature/personal_snapshot/total_debt_detail/total_debt_controller.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive_extensions.dart';

import '../../../../font_style_global.dart';

class ExpandableTileSection extends StatelessWidget {
  const ExpandableTileSection({
    Key? key,
    required this.title,
    this.subtitle,
    required this.trailingText,
    this.onEdit,
    this.isEdit = false, this.superScript,
  }) : super(key: key);

  final String title;
  final String trailingText;
  final String? subtitle;
  final String? superScript;
  final Function()? onEdit;
  final bool isEdit;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          left: 24.w, top: 16, bottom: 16, right: onEdit != null ? 12.w : 20.w),
      child: Row(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              Wrap(
              direction: Axis.horizontal,
              children: [
                Text(
                  title,
                  style: captionBold14Primary(
                    color: GlorifiColors.midnightBlueColor,
                  ),
                ),
                if (superScript != null)
                  Text(
                    '*',
                    style: TextStyle(fontFeatures: [FontFeature.superscripts()]),
                  ),
              ]),


                if (subtitle != null)
                  Text(
                    subtitle!,
                    style: xSmallRegular12Primary(
                      color: GlorifiColors.midnightBlueColor,
                    ),
                  ),
              ],
            ),
          ),
          SizedBox(width: 20.w),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (!isEdit) ...{
                Row(
                  children: [
                    Text(
                      trailingText,
                      style: headlineBold21Secondary(
                        color: GlorifiColors.darkBlue,
                      ).copyWith(letterSpacing: -0.5),
                    ),
                    if (onEdit != null)
                      IconButton(
                        onPressed: onEdit,
                        icon: SvgPicture.asset('assets/icons/edit.svg'),
                        color: GlorifiColors.black,
                      ),
                  ],
                ),
              },
              if (isEdit) EditForm(),
            ],
          ),
        ],
      ),
    );
  }
}

class EditForm extends StatelessWidget {
  const EditForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<TotalDebtController>();
    return Form(
      key: controller.formKey,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: Row(
          children: [
            SizedBox(
              width: 50,
              child: TextFormField(
                controller: controller.monthlyController,
              ),
            ),
            TextButton(
              onPressed: controller.disabledMonthly.value
                  ? null
                  : controller.CancelIncome,
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: controller.disabledMonthly.value
                  ? null
                  : controller.SaveIncome,
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
