import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:glorifi/src/core/base/urls.dart';
import 'package:glorifi/src/feature/banking/servicing/ebs_controller.dart';
import 'package:glorifi/src/feature/banking/servicing/widgets/ebs_container.dart';
import 'package:glorifi/src/widgets/loading/glorifi_spinner.dart';

class EBSManagePinScreen extends GetView<EBSController> {
  const EBSManagePinScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return EBSContainer(
      title: "Manage PIN",
      children: _content(),
      showSettings: false,
    );
    });
    
  }

  List<Widget> _content() {
    if (controller.loadingPinStuff.value) {
      return [
        Expanded(
          child: Center(
            child: GlorifiSpinner(),
          ),
        )
      ];
    }
    final oneTime = controller.managePinResponse.value.oneTimeToken;
    final userToken = controller.managePinResponse.value.userToken;
    final applicationId = controller.managePinResponse.value.applicationId;
    final cardToken = controller.details.cardMarqetaRef;
    final successUrl = controller.managePinResponse.value.successUrl ?? '';
    final url = Urls.setPinUrl;
    final src =
        '$url?one_time_token=$oneTime&user_token=$userToken&card_token=$cardToken&application_id=$applicationId&success_url=$successUrl&display_headers=false';
    return [
      Expanded(
        child: InAppWebView(
          initialUrlRequest: URLRequest(url: Uri.parse(src)),
        ),
      )
    ];
  }
}
