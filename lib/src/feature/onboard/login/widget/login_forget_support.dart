import 'package:flutter/material.dart';
import 'package:glorifi/src/feature/onboard/widgets/underline_text.dart';

class LoginForgetPasswordSupportWidget extends StatelessWidget {
  final Function()? onTapForgetPass;
  final Function()? onTapSupport;
  final bool isDesktop;

  const LoginForgetPasswordSupportWidget({
    Key? key,
    this.onTapForgetPass,
    this.onTapSupport,
    this.isDesktop = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
          isDesktop ? MainAxisAlignment.center : MainAxisAlignment.spaceBetween,
      children: [
        Spacer(),
        UnderlineText(
          text: "Support",
          onTap: onTapSupport,
        ),
      ],
    );
  }
}
