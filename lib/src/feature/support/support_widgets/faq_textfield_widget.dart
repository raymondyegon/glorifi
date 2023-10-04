import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_utils/src/extensions/widget_extensions.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive_extensions.dart';

class FaqTextField extends StatelessWidget {
  final TextEditingController? controller;
  final onChanged;
  final String hint;
  final int? minLines;
  final String title;
  final TextStyle? hintStyle;
  final String errorText;
  final bool? isValid;
  final Widget? suffixWidget;
  final TextInputType textInputType;
  final List<TextInputFormatter>? inputFormatter;
  final bool? isDecoration;
  final bool? isCapitalizationNeeded;

  const FaqTextField(
      {Key? key,
      this.controller,
      this.onChanged,
      this.hintStyle,
      this.errorText: '',
      this.isValid,
      this.hint: '',
      this.minLines,
      this.title: '',
      this.suffixWidget,
      this.textInputType: TextInputType.text,
      this.inputFormatter,
      this.isDecoration,
      this.isCapitalizationNeeded})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: formLabel(
            color: GlorifiColors.darkBlue,
          ),
        ).paddingOnly(
          bottom: 6.h,
        ),
        TextFormField(
          enabled: true,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          controller: controller,
          style: formInput(color: GlorifiColors.midnightBlue),
          textAlign: TextAlign.start,
          onChanged: onChanged,
          maxLines: null,
          textCapitalization:
              (isCapitalizationNeeded != null && isCapitalizationNeeded == true)
                  ? TextCapitalization.sentences
                  : TextCapitalization.none,
          minLines: minLines,
          inputFormatters: inputFormatter,
          decoration: InputDecoration(
            filled: true,
            fillColor: GlorifiColors.white,
            border: OutlineInputBorder(
              borderSide: isDecoration == null
                  ? BorderSide(
                  color: GlorifiColors.black.withOpacity(
                    0.5,
                  ),
                  width: 1)
                  : BorderSide(color: GlorifiColors.white.withOpacity(
                0.5,
              ), width: 0),
              borderRadius: BorderRadius.all(
                Radius.circular(
                  8.0.r,
                ),
              ),
            ),

            focusedBorder: OutlineInputBorder(
              borderSide: isDecoration == null
                  ? BorderSide(
                color: (isValid != null && isValid == true)
                    ? GlorifiColors.redError
                    : GlorifiColors.black.withOpacity(
                  0.3,
                ),
                width: 1,
              )
                  : BorderSide(
                color: (isValid != null && isValid == true)
                    ? GlorifiColors.redError
                    : GlorifiColors.white.withOpacity(
                  0.5,
                ),
                width: 0,
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(8.0.r),
              ),
            ),

            disabledBorder: OutlineInputBorder(
              borderSide: isDecoration == null
                  ? BorderSide(
                color: (isValid != null && isValid == true)
                    ? GlorifiColors.redError
                    : GlorifiColors.black.withOpacity(
                  0.3,
                ),
                width: 1,
              )
                  : BorderSide(
                color: (isValid != null && isValid == true)
                    ? GlorifiColors.lightRed
                    : GlorifiColors.white.withOpacity(
                  0.5,
                ),
                width: 0,
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(8.0.r),
              ),
            )
            ,
            enabledBorder: OutlineInputBorder(
              borderSide: isDecoration == null
                  ? BorderSide(
                color: (isValid != null && isValid == true)
                    ? GlorifiColors.lightRed
                    : GlorifiColors.black.withOpacity(
                  0.3,
                ),
                width: 1,
              )
                  : BorderSide(
                color: (isValid != null && isValid == true)
                    ? GlorifiColors.lightRed
                    : GlorifiColors.white.withOpacity(
                  0.5,
                ),
                width: 0,
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(8.0.r),
              ),
            ),
            suffixIcon: suffixWidget,
            hintStyle: hintStyle,
            hintText: hint,
          ),
          keyboardType: textInputType,
        ),
        errorText.isNotEmpty
            ? Text(
                errorText,
                style: captionRegular14Primary(
                  color: GlorifiColors.lightRed,
                ),
              ).paddingOnly(
                top: 4.h,
              )
            : SizedBox.shrink(),
      ],
    );
  }
}
