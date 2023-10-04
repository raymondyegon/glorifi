import 'package:advance_pdf_viewer_fork/advance_pdf_viewer_fork.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/core/logger.dart';
import 'package:glorifi/src/feature/credit_card_2/apply_for_card/model/acc_screen_info_model.dart';
import 'package:glorifi/src/feature/credit_card_2/apply_for_card/screens/processing/acc_processing_controller.dart';
import 'package:glorifi/src/feature/credit_card_2/apply_for_card/widgets/acc_container.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/routes/app_pages.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive_extensions.dart';
import 'package:glorifi/src/utils/text_constants.dart';
import 'package:glorifi/src/widgets/buttons/primary_buton_dark.dart';

import 'controller/acc_agreement_controller.dart';

class ACCAcceptCardAgreement extends GetView<ACCAgreementController> {
  ACCAcceptCardAgreement({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ACCContainer(
      info: ACCScreensInfo.ACCAcceptCardHolder,
      children: _content(),
      onContinue: null,
    );
  }

  List<Widget> _content() {
    return <Widget>[
      controller.isDocumentLoading.value
          ? Center(child: CircularProgressIndicator.adaptive())
          : SizedBox(
              height: 300,
              child: PDFViewer(
                document: controller.document!,
                zoomSteps: 1,
                scrollDirection: Axis.horizontal,
                showNavigation: false,
                showPicker: false,
                showIndicator: false,
              ),
            ),
      SizedBox(height: 24.h),
      Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Obx(
            () => InkWell(
              onTap: () => controller.isProductAccepted.toggle(),
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 2),
                    borderRadius: BorderRadius.all(Radius.circular(05))),
                child: controller.isProductAccepted.isTrue
                    ? Center(child: Icon(Icons.check, size: 18))
                    : SizedBox(height: 18, width: 18),
              ),
            ),
          ),
          SizedBox(width: 15),
          Expanded(
            child: Text(
              TextConstants.acc_accept_agreement,
              textAlign: TextAlign.justify,
              style: captionRegular14Primary(
                color: GlorifiColors.darkGrey80,
              ),
            ),
          )
        ],
      ),
      SizedBox(height: 12.h),
      Obx(() {
        return PrimaryDarkButton(
          title: "I ACCEPT",
          hasRightArrow: true,
          enabled: controller.isProductAccepted.value,
          onTap: () {

            Get.find<ACCProcessingController>()
                .toggleIsFromCardHolderAgreementScreen(true);
            Get.toNamed(Routes.accProcessing);
          },
        );
      }),
      SizedBox(height: 15.h),
      TextButton(
        child: Center(
          child: Text(
            "Not Now",
            style: leadSemiBold18Primary(color: GlorifiColors.darkBlue),
          ),
        ),
        onPressed: () => Get.toNamed(Routes.accCardCancelation),
      ),
    ];
  }
}
