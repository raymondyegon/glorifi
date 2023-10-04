import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';

class BiometricSettingsDialogWidget extends StatelessWidget {
  final String iconPath;
  final String title;

  const BiometricSettingsDialogWidget({
    Key? key,
    required this.iconPath,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          SvgPicture.asset(
            iconPath,
            color: GlorifiColors.bgDarkGrey,
            height: 64,
            width: 64,
          ),
          const SizedBox(height: 20),
          Text(title, style: mediumItalic17Thin()),
          Text(
            "Enable biometrics in your device's security settings.",
            style: smallRegular13(),
          ),
        ],
      ),
    );
  }
}
