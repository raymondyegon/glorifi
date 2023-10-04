import 'package:flutter/material.dart';
import 'package:glorifi/src/feature/banking/open_account/model/oao_screen.dart';
import 'package:glorifi/src/feature/banking/open_account/widgets/oao_exit_container.dart';

class CreditCardFurtherReview extends StatelessWidget {
  const CreditCardFurtherReview({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OAOExitContainer(
      title: OAOScreensInfo.OAOFurtherReview.title,
      ctaTitle: OAOScreensInfo.OAOFurtherReview.ctaTitle,
      subtitle: OAOScreensInfo.OAOFurtherReview.subtitle!,
    );
  }
}
