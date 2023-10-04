import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/utils/glorifi_assets.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive_extensions.dart';
import 'package:glorifi/src/widgets/loading/glorifi_spinner.dart';

class CarouselCardIconButton extends StatefulWidget {
  const CarouselCardIconButton({Key? key, this.buttonText, this.onTap})
      : super(key: key);

  final buttonText;
  final Function? onTap;

  @override
  State<CarouselCardIconButton> createState() => _CarouselCardIconButtonState();
}

class _CarouselCardIconButtonState extends State<CarouselCardIconButton> {
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
        height: 48,
        width: 48,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: GlorifiColors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 1,
              offset: Offset(0, 1),
            ),
          ],
        ),
        child: Center(
          child: widget.buttonText == "Get Score"
              ? SvgPicture.asset(
                  GlorifiAssets.linkBankAccount,
                  color: Colors.black,
                  width: 28,
                  height: 28,
                )
              : widget.buttonText == "Link Account" && loading
                  ? Container(
                      width: 28,
                      height: 28,
                      child: CircularProgressIndicator(),
                    )
                  : Icon(
                      Icons.add,
                      size: 28,
                    ),
        ),
      ),
    );
  }
}
