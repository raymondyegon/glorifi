import 'package:flutter/material.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive_extensions.dart';

class OutlinedButtonWidget extends StatefulWidget {
  final Color? textColor;
  final String text;
  final Function? onTap;
  final Widget? icon;
  late Border? border;
  late List<BoxShadow>? boxShadow;

  OutlinedButtonWidget(
      {Key? key,
      required this.text,
      this.onTap,
      this.textColor = GlorifiColors.cornflowerBlue,
      this.icon,
      this.border,
      this.boxShadow})
      : super(key: key) {
    border = border == null ? Border.all(width: 0.4, color: GlorifiColors.silver) : border;
    boxShadow = boxShadow == null
        ? [BoxShadow(color: Colors.grey.withOpacity(0.2), spreadRadius: 4, blurRadius: 7, offset: Offset(0, 4))]
        : boxShadow;
  }

  @override
  State<OutlinedButtonWidget> createState() => _OutlinedButtonWidgetState();
}

class _OutlinedButtonWidgetState extends State<OutlinedButtonWidget> {
  bool showLoading = false;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.all(
          Radius.circular(8),
        ),
        onTap: showLoading
            ? () {}
            : () async {
                try {
                  showLoading = true;
                  setState(() {});
                  await widget.onTap!();
                } finally {
                  showLoading = false;
                  setState(() {});
                }
              },
        child: Container(
          constraints: BoxConstraints(minHeight: 64.h),
          width: double.infinity,
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: widget.boxShadow,
            border: widget.border,
            borderRadius: BorderRadius.all(
              Radius.circular(8),
            ),
          ),
          child: Stack(children: [
            showLoading
                ? Container(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      color: widget.textColor,
                    ),
                  )
                : widget.icon != null
                    ? widget.icon!
                    : SizedBox.shrink(),
            Container(
                padding: EdgeInsets.only(top: 3),
                child: Center(
                    child: Text(
                  widget.text,
                  style: bodyBold18Primary(
                    color: widget.textColor,
                  ),
                  textAlign: TextAlign.center,
                ))),
          ]),
        ),
      ),
    );
  }
}
