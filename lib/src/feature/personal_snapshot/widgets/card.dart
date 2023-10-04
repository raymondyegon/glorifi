import 'package:flutter/material.dart';
import 'package:glorifi/src/utils/responsive/responsive_extensions.dart';

class GlorifiCard extends StatelessWidget {
  const GlorifiCard({
    Key? key,
    required this.content,
    this.footerWidget,
    this.backgroundColor,
    this.padding,
  }) : super(key: key);

  final Widget content;
  final Widget? footerWidget;
  final String? backgroundColor;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 0),
            color: Colors.black.withOpacity(0.1),
            blurRadius: 55,
          ),
        ],
        color: backgroundColor != null ? Color(int.parse('0xFF$backgroundColor')) : Color(0xFFFFFFFF),
        image: backgroundColor != null
            ? DecorationImage(
                image: AssetImage("assets/images/card-background.png"),
                fit: BoxFit.contain,
                repeat: ImageRepeat.noRepeat,
              )
            : null,
      ),
      child: Column(
        children: [
          Padding(
            padding: padding != null
                ? padding!
                : EdgeInsets.symmetric(
                    horizontal: 24.w,
                    vertical: 24.h,
                  ),
            child: content,
          ),
          if (footerWidget != null) footerWidget!
        ],
      ),
    );
  }
}
