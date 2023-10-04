import 'package:glorifi/src/widgets/shared/hyperlink_handler.dart';
import 'dart:js' as js;

class WebHyperLinkHandler extends HyperLinkHandler {
  @override
  void openUrl(String url) {
    js.context.callMethod('open', [url]);
  }
}
