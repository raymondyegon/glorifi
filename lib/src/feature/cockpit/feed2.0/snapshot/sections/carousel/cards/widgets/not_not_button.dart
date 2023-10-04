import 'package:flutter/material.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive_extensions.dart';
import 'package:glorifi/src/widgets/buttons/primary_button.dart';

class NotNowButton extends StatelessWidget {
  final Function()? onTap;

  const NotNowButton({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.only(left: 16, right: 16),
          decoration: BoxDecoration(
              color: Colors.transparent,
              border: Border.all(
                color: GlorifiColors.lightBlue,
                width: 0.8,
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(8),
              )),
          height: 40,
          child: Center(
            child: Text(
              'Not Now',
              style: xSmallBold12Primary(
                color: GlorifiColors.darkGrey80,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
