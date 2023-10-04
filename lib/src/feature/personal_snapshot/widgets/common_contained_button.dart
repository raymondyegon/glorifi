import 'package:flutter/material.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';

class CommonContainedButton extends StatelessWidget {
  const CommonContainedButton({
    Key? key,
    required this.text,
    this.onTap,
    this.isLoading = false,
  }) : super(key: key);

  final void Function()? onTap;
  final String text;
  final bool isLoading;

  final double radius = 8;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isLoading ? () {} : onTap,
      borderRadius: BorderRadius.all(Radius.circular(radius)),
      child: Container(
        height: 64,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        width: double.infinity,
        decoration: BoxDecoration(
          color: onTap == null
              ? GlorifiColors.silver
              : GlorifiColors.primaryDarkButtonColor,
          borderRadius: BorderRadius.all(Radius.circular(radius)),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              isLoading
                  ? CircularProgressIndicator(
                      color: GlorifiColors.white,
                    )
                  : Expanded(
                      child: Text(
                        text,
                        style: bodyBold18Primary(
                            color: GlorifiColors.productsBgWhite),
                        textAlign: TextAlign.center,
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
