import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/widgets/tap/ripple.dart';

class ShareAppButton extends StatelessWidget {
  final Function() onTap;

  const ShareAppButton({Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Ripple(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Share this app', style: _getTextStyle()),
            const SizedBox(width: 8),
            SvgPicture.asset('assets/images/share.svg')
          ],
        ),
      ),
    );
  }

  _getTextStyle() => TextStyle(
      color: GlorifiColors.white,
      fontSize: 16,
      fontFamily: "univers",
      fontWeight: FontWeight.w400);
}
