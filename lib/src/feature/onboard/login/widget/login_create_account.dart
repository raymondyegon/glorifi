import 'package:flutter/material.dart';
import 'package:glorifi/src/feature/onboard/create_profile_plus/widgets/profile_colors.dart';
import 'package:glorifi/src/utils/glorifi_text_styles.dart';
import 'package:glorifi/src/utils/glorifi_values.dart';
import 'package:glorifi/src/widgets/tap/ripple.dart';

class LoginCreateAccountWidget extends StatelessWidget {
  final Function()? onTap;
  final MainAxisAlignment mainAxisAlignment;

  LoginCreateAccountWidget({
    Key? key,
    this.onTap,
    this.mainAxisAlignment = MainAxisAlignment.center,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: mainAxisAlignment,
      children: [
        Text(
          "Not a member?",
          style: sansNormalStyle.copyWith(
            color: profileTextColor,
          ),
        ),
        SizedBox(width: GlorifiValues.margin_4),
        Ripple(
            onTap: onTap,
            child: Text("Create Account",
                style: sansBoldStyle.copyWith(
                  height: 1.36,
                  shadows: [
                    Shadow(color: profileTextColor, offset: Offset(0, -1.2))
                  ],
                  color: Colors.transparent,
                  decoration: TextDecoration.underline,
                  decorationColor: profileTextColor,
                  decorationThickness: 2,
                )))
      ],
    );
  }
}
