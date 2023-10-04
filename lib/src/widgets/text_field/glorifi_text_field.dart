import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive_extensions.dart';
import 'package:us_states/us_states.dart';

class TwoColumnGloriFiSilverField extends StatelessWidget {
  final Widget textField1;
  final Widget textField2;

  const TwoColumnGloriFiSilverField(
      {Key? key, required this.textField1, required this.textField2})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      // mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          flex: 1,
          child: textField1,
        ),
        SizedBox(width: 10.0),
        Expanded(flex: 1, child: textField2),
      ],
    );
  }
}

class GloriFiRadioButton extends StatelessWidget {
  final String title;
  final int value;
  final int groupValue;
  final ValueChanged<int?> onChanged;

  const GloriFiRadioButton(
      {Key? key,
      required this.title,
      required this.onChanged,
      required this.value,
      required this.groupValue})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          border: Border.all(color: GlorifiColors.silver.withOpacity(0.5)),
          borderRadius: BorderRadius.circular(10),
        ),
        margin: EdgeInsets.only(bottom: 20.h),
        child: Row(children: [
          Theme(
              data: ThemeData(
                //here change to your color
                toggleableActiveColor: GlorifiColors.midnightBlue,
                unselectedWidgetColor: GlorifiColors.midnightBlue,
              ),
              child: Radio(
                  value: value, groupValue: groupValue, onChanged: onChanged)),
          Text(
            title,
          ),
        ]));
  }
}

class GloriFiCheckBox extends StatelessWidget {
  final ValueChanged<bool?> onChanged;
  final Widget child;
  final bool checked;
  final hasBorder;

  const GloriFiCheckBox(
      {Key? key,
      required this.onChanged,
      required this.child,
      required this.checked,
      this.hasBorder = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(vertical: 13),
        margin: EdgeInsets.only(bottom: 20.h),
        decoration: BoxDecoration(
          border: Border.all(
              color: hasBorder
                  ? GlorifiColors.silver.withOpacity(0.5)
                  : Colors.transparent),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(children: [
          Theme(
              data: ThemeData(
                checkboxTheme: CheckboxThemeData(
                  fillColor: MaterialStateProperty.all<Color>(
                      GlorifiColors.silver.withOpacity(0.5)),
                  checkColor:
                      MaterialStateProperty.all<Color>(GlorifiColors.darkBlue),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
              child: Checkbox(
                value: checked,
                onChanged: onChanged,
              )),
          Container(
            child: child,
            width: hasBorder ? 0.6.sw : 0.7.sw,
          ),
        ]));
  }
}

class StateDropDown extends StatelessWidget {
  final String? value;
  final ValueChanged<String?> onChanged;

  const StateDropDown({Key? key, this.value, required this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var states = USStates.getAllNames();

    return GlorifiDropDown(
      items: states,
      label: 'State',
      value: states.contains(value) ? value : null,
      onChanged: onChanged,
    );
  }
}

class GlorifiDropDown extends StatelessWidget {
  final String? value;
  final ValueChanged<String?> onChanged;
  final String label;
  final List<String> items;

  const GlorifiDropDown(
      {Key? key,
      this.value,
      required this.onChanged,
      required this.label,
      required this.items})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(bottom: 10),
        child: DropdownButtonHideUnderline(
            child: ButtonTheme(
                alignedDropdown: false,
                child: DropdownButtonFormField<String>(
                    isExpanded: true,
                    hint: Text(label),
                    dropdownColor: Colors.white,
                    decoration: InputDecoration(
                        filled: true,
                        isDense: true,
                        fillColor: GlorifiColors.white,
                        contentPadding: EdgeInsets.only(
                          top: 18,
                          bottom: 17,
                          left: 12,
                          right: 12,
                        ),
                        isCollapsed: true,
                        errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: GlorifiColors.redError, width: 1),
                            borderRadius: BorderRadius.circular(10.0)),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: GlorifiColors.silver, width: 1),
                            borderRadius: BorderRadius.circular(10.0)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: GlorifiColors.silver, width: 1),
                            borderRadius: BorderRadius.circular(10.0))),
                    validator:
                        GlorifiTextField.requiredFieldValidator('your state'),
                    value: value,
                    menuMaxHeight: 1000,
                    onChanged: onChanged,
                    items: List<DropdownMenuItem<String>>.generate(items.length,
                        (int index) {
                      return DropdownMenuItem(
                        alignment: AlignmentDirectional.centerStart,
                        value: items[index],
                        child: Text(
                          items[index],
                          style:
                              TextStyle(color: GlorifiColors.darkBlueTint[500]),
                          textAlign: TextAlign.center,
                        ),
                      );
                    })))));
  }
}

class GlorifiTextField extends StatefulWidget {
  final String? initialValue;
  final String? label;
  late String? Function(String?) validator;
  final ValueChanged<String>? onChanged;
  final TextEditingController? textEditingController;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final bool showVisibilityOptions;
  final FocusNode? focusNode;
  final bool autofocus;
  final bool enabled;
  final TextCapitalization textCapitalization;
  final Function? onTap;

  GlorifiTextField({
    Key? key,
    this.initialValue,
    this.label,
    this.onChanged,
    this.focusNode,
    this.textEditingController,
    this.keyboardType,
    this.inputFormatters,
    this.showVisibilityOptions = false,
    this.textCapitalization = TextCapitalization.none,
    this.autofocus = false,
    this.enabled = true,
    this.onTap,
    String? Function(String?)? validator,
  }) : super(key: key) {
    if (validator == null) {
      validator = (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter some text';
        }
        return null;
      };
    }
    this.validator = validator;
  }

  static String? Function(String?) optionalValidator = (value) {
    return null;
  };

  static String? Function(String?) requiredFieldValidator(String fieldDesc) {
    return (value) {
      if (value == null || value.isEmpty) {
        return 'Please enter $fieldDesc';
      }
      return null;
    };
  }

  static String? Function(String?) requiredEmailValidator() {
    return (value) {
      if (value == null || value.isEmpty) {
        return 'Please enter your email';
      } else if (!value.isEmail) {
        return "Invalid email address";
      }
      return null;
    };
  }

  static String? Function(String?) requiredBirthdayDate() {
    return (value) {
      if (value == null || value.isEmpty) {
        return 'Please enter birthday';
      }
      if (value.length != 10) {
        return 'Please enter birthday as DD/MM/YYYY';
      }
      return null;
    };
  }

  static String? Function(String?) requiredSSN(String fieldDesc) {
    return (value) {
      if (value == null || value.isEmpty) {
        return 'Please enter your $fieldDesc';
      }
      if (value.replaceAll(RegExp('[^0-9]'), '').length != 9) {
        return 'Please enter a 9 digit $fieldDesc';
      }
      return null;
    };
  }

  static String? Function(String?) requiredPhoneNumber() {
    return (value) {
      if (value == null || value.isEmpty) {
        return 'Please enter phone number';
      }
      if (value.length != 12) {
        return 'Please enter your 9 digit phone number';
      }
      return null;
    };
  }

  static String? Function(String?) requiredDepositValidation(
      {double min = 0, double? max}) {
    return (value) {
      if (value == null || value.isEmpty) {
        return 'Please enter valid amount';
      }
      value = value.replaceAll(RegExp("[^0-9 .]"), "");

      if (double.parse(value) < min) {
        return 'Initial deposit needs to be at least \$$min';
      }
      if (max != null && double.parse(value) > max) {
        return 'Insufficient funds';
      }
      return null;
    };
  }

  @override
  State<GlorifiTextField> createState() => _GlorifiTextFieldState();
}

class _GlorifiTextFieldState extends State<GlorifiTextField> {
  bool isVisible = true;
  bool isEmpty = false;

  @override
  void initState() {
    if (widget.textEditingController == null) {
      isEmpty =
          widget.initialValue == null || widget.initialValue!.trim() == "";
    } else {
      isEmpty = widget.textEditingController!.text == null ||
          widget.textEditingController!.text.trim() == "";
    }
    widget.textEditingController?.addListener(() {
      if (mounted) {
        setState(() {
          isEmpty = widget.textEditingController!.text == null ||
              widget.textEditingController!.text.trim() == "";
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(bottom: 15.h),
        child: Stack(children: [
          TextFormField(
            onTap: () => widget.onTap?.call(),
            style: TextStyle(color: GlorifiColors.darkBlueTint[500]),
            onChanged: (text) {
              setState(() {
                isEmpty = text == "";
              });
              widget.onChanged?.call(text);
            },
            enabled: widget.enabled,
            autofocus: widget.autofocus,
            textInputAction: TextInputAction.next,
            keyboardType: widget.keyboardType,
            inputFormatters: widget.inputFormatters,
            obscureText: !isVisible,
            textCapitalization: widget.textCapitalization,
            focusNode: widget.focusNode,
            decoration: InputDecoration(
              border: InputBorder.none,
              suffixIcon: widget.showVisibilityOptions
                  ? IconButton(
                      icon: Icon(
                        isVisible
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        setState(() {
                          isVisible = !isVisible;
                        });
                      },
                    )
                  : null,
              hintText: widget.label,
              labelText: isEmpty ? "" : widget.label,
              labelStyle:
                  xSmallRegular12Primary(color: GlorifiColors.dateDarkGrey),
              floatingLabelBehavior: FloatingLabelBehavior.always,
              filled: true,
              fillColor:
                  widget.enabled ? Colors.white : GlorifiColors.lightGrey,
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: GlorifiColors.silver),
                borderRadius: BorderRadius.circular(10.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: GlorifiColors.silver),
                borderRadius: BorderRadius.circular(10.0),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: GlorifiColors.redError),
                borderRadius: BorderRadius.circular(10.0),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: GlorifiColors.redError),
                borderRadius: BorderRadius.circular(10.0),
              ),
              disabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: GlorifiColors.silver),
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            validator: widget.validator,
            initialValue: widget.initialValue,
            controller: widget.textEditingController,
          ),
        ]));
  }
}

class BoxSelection extends StatelessWidget {
  final bool isSelected;
  final String title;
  final String? subtitle;
  final Function onTap;
  final FontWeight? fontWeight;
  final bool isBorderEnabled;
  final bool isShadowEnabled;

  const BoxSelection({
    Key? key,
    this.isSelected: false,
    required this.title,
    this.subtitle,
    required this.onTap,
    this.isBorderEnabled = true,
    this.isShadowEnabled = true,
    this.fontWeight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        highlightColor: Colors.red,
        child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.r),
              border: isBorderEnabled
                  ? Border.all(
                      color: isSelected
                          ? GlorifiColors.lightBlue
                          : GlorifiColors.silver,
                      width: isSelected ? 3 : 0)
                  : null,
              boxShadow: isShadowEnabled
                  ? [
                      BoxShadow(
                        blurRadius: 15,
                        color: GlorifiColors.black.withOpacity(.080),
                        // spreadRadius: 5,
                      )
                    ]
                  : null,
            ),
            width: 1.sw,
            padding: EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                      color: GlorifiColors.darkBlue,
                      fontWeight: fontWeight ?? FontWeight.bold,
                      height: 1.5),
                ),
                if (subtitle != null) Text(subtitle!)
              ],
            )),
        onTap: () => onTap());
  }
}
