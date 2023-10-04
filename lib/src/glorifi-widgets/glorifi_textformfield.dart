import 'package:flutter/material.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';

class GlorifiTextFormField extends StatelessWidget {
  final TextInputType keyboardType;
  final String? initialValue;
  final String hintText;
  final Color cursorColor;
  final Color textColor;
  final Color focusBorderColor;
  final Color enableBorderColor;
  final Color outlineBorderColor;
  final Color? errorBorderColor;
  final Color? iconColor;
  final ValueChanged<String>? onChanged;
  final FormFieldValidator<String>? validator;
  final TextEditingController? controller;
  final IconData? icon;
  final int? maxLength;
  final int? maxLines;

  final int? minLines;
  final AutovalidateMode? autovalidateMode;

  final Widget? prefixIcon;

  const GlorifiTextFormField({
    Key? key,
    this.keyboardType = TextInputType.none,
    this.initialValue,
    this.autovalidateMode=AutovalidateMode.onUserInteraction,
    required this.hintText,
    this.cursorColor = Colors.black,
    this.onChanged,
    this.controller,
    this.focusBorderColor = Colors.grey,
    this.enableBorderColor = Colors.grey,
    this.outlineBorderColor =   Colors.grey,
    this.icon,
    this.iconColor,
      this.textColor=GlorifiColors.textColorBlack,
    this.maxLength,
    this.prefixIcon,
    this.maxLines,
    this.errorBorderColor: Colors.transparent,
    this.validator,
    this.minLines,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ignore: todo
    //TODO move the items to theme later.
    return icon == null
        ? TextFormField(
            controller: controller,
            keyboardType: keyboardType,
            cursorColor: cursorColor,
            initialValue: initialValue,
            maxLength: maxLength,
            maxLines: maxLines,
            minLines: minLines,
            style: TextStyle(color: textColor),
            onChanged: onChanged,
            decoration: InputDecoration(
                hintText: hintText,
                prefixIcon: prefixIcon,
                alignLabelWithHint: true,
                fillColor: Colors.white,
                hintStyle: smallRegular16Primary(),
                filled: true,
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: focusBorderColor, width: 2.0),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: enableBorderColor, width: 2.0),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                border: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: outlineBorderColor, width: 2.0),
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                errorBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: errorBorderColor!, width: 2.0),
                    borderRadius: BorderRadius.all(Radius.circular(10.0)))),
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: TextFormField(
                  controller: controller,
                  keyboardType: keyboardType,
                  cursorColor: cursorColor,
                  initialValue: initialValue,
                  style: const TextStyle(
                      color: Colors.black,
                      fontFamily: 'OpenSans',
                      fontSize: 16),
                  onChanged: onChanged,
                  maxLength: maxLength,
                  validator: validator,
                  decoration: InputDecoration(
                    hintText: hintText,
                    counterText: "",
                    alignLabelWithHint: true,
                    fillColor: Colors.white,
                    hintStyle: TextStyle(
                        color: Colors.grey,
                        fontFamily: 'OpenSans',
                        fontSize: 16),
                    filled: true,
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: focusBorderColor, width: 1.0),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: enableBorderColor, width: 1.0),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    border: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: outlineBorderColor, width: 1.0),
                        borderRadius: BorderRadius.all(Radius.circular(10.0))),
                  ),
                ),
              ),
              Icon(
                icon,
                color: iconColor,
                size: 18,
              )
            ],
          );
  }
}
