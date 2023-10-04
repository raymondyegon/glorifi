import 'package:flutter/material.dart';
import 'package:glorifi/src/widgets/shared/gf_webview.dart';

import '../../environment/environment.dart';

class UnqorkScreen extends StatelessWidget {
  const UnqorkScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GFWebview(
        initialUrl:
        Environment().config.unqorkUrl,
        vendor: "unqork",
        pageTitle: 'Unqork');
  }
}
