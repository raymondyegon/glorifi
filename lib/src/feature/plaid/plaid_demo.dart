import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/controllers/plaid_controller.dart';
import 'package:glorifi/src/routes/app_pages.dart';
import 'package:glorifi/src/utils/text_constants.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';

class PlaidDemo extends StatelessWidget {
  PlaidController plaidController = Get.put(PlaidController());

  PlaidDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        child: Obx(() {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                onPressed: () => Get.toNamed(Routes.plaidSuccessScreen),
                /*onPressed: () => PlaidLink.open(
                  configuration: plaidController.linkTokenConfiguration!),*/
                child: plaidController.isLoading.value
                    ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CircularProgressIndicator(
                          color: GlorifiColors.white,
                        ),
                      )
                    : Text(TextConstants.openPlaidLinkText),
              ),
            ],
          );
        }),
      ),
    );
  }
}
