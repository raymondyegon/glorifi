
import 'package:flutter/material.dart';
import 'package:glorifi/src/feature/banking/open_account/model/oao_screen.dart';
import 'package:glorifi/src/feature/banking/open_account/widgets/oao_exit_container.dart';

class OAOBackScreen extends StatelessWidget {
  const OAOBackScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OAOExitContainer(
      title: OAOScreensInfo.OAOBackScreen.title,
      ctaTitle: OAOScreensInfo.OAOBackScreen.ctaTitle,
      subtitle: OAOScreensInfo.OAOBackScreen.subtitle!,
    );
  }
}
