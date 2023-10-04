import 'package:flutter/material.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive_extensions.dart';
import 'package:glorifi/src/widgets/loading/glorifi_spinner.dart';

class CarouselCardButton extends StatefulWidget {
  const CarouselCardButton({Key? key, this.buttonText, this.onTap}) : super(key: key);

  final buttonText;
  final Function? onTap;

  @override
  State<CarouselCardButton> createState() => _CarouselCardButtonState();
}

class _CarouselCardButtonState extends State<CarouselCardButton> {
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: loading
          ? () {}
          : () async {
              try {
                loading = true;
                setState(() {});
                await widget.onTap!();
              } finally {
                loading = false;
                setState(() {});
              }
            },
      child: Container(
        constraints: BoxConstraints(
          minHeight: 28.h,
          minWidth: 95.w,
        ),
        decoration: BoxDecoration(
          color: GlorifiColors.darkBlueTint[500],
          borderRadius: BorderRadius.circular(4),
          border: Border.all(
            color: GlorifiColors.darkBlueTint[200]!,
          ),
        ),
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Text(
                  widget.buttonText,
                  style: xSmallSemiBold12Primary(
                    color: loading ? Colors.transparent : GlorifiColors.white,
                  ),
                ),
                if (loading)
                  GlorifiSpinner(
                    size: 20.r,
                  )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
