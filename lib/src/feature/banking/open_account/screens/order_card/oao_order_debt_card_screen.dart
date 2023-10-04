import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/custom_render.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/feature/banking/open_account/model/oao_screen.dart';
import 'package:glorifi/src/feature/banking/open_account/oao_controller.dart';
import 'package:glorifi/src/feature/banking/open_account/screens/exit/oao_exit_screen.dart';
import 'package:glorifi/src/feature/banking/open_account/screens/onboarding/oao_shipping_information.dart';
import 'package:glorifi/src/feature/banking/open_account/widgets/oao_container.dart';
import 'package:glorifi/src/feature/banking/open_account/widgets/oao_footer_note.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive.dart';
import 'package:glorifi/src/widgets/loading/shimmer.dart';

// Step 4 of 6
// https://app.asana.com/0/1202239119682092/1202240186732675/f
class OAODebitCardScreen extends GetView<OAOController> {
  const OAODebitCardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OAOContainer(
        children: _content(),
        info: OAOScreensInfo.OAODebitCardScreen,
        disclosureWidget: OAOFooterNote(
            customText: TextSpan(children: [
          TextSpan(
            text: 'By clicking continue, you agree to the ',
          ),
          TextSpan(
              text: "Debit Card Supplemental Terms & Conditions.",
              style: TextStyle(color: GlorifiColors.darkBlue)),
        ])),
        onContinue: () async {
          await Get.to(
            () => OAOShippingScreen(),
          );
        },
        onSkip: () async {
          await Get.to(
            () => OAOExitScreen(),
          );
        });
  }

  List<Widget> _content() {
    var heightOfPlaceHolders = 0.57.sw;
    var debitCardOptionsCount = controller.debitCardOptions.length;
    var childWidthConst = .78;
    var childWidth = childWidthConst / debitCardOptionsCount;

    return [
      SizedBox(height: 20),
      Obx(() => Container(
            child: CachedNetworkImage(
                imageUrl: controller.application.selectedCard.value.cardArt,
                fit: BoxFit.cover,
                placeholder: (context, url) => SizedBox(
                    width: 1.sw,
                    height: heightOfPlaceHolders,
                    child: ShimmeryPlaceHolder()),
                errorWidget: (context, url, error) => SizedBox(
                    width: 1.sw,
                    height: heightOfPlaceHolders,
                    child: ShimmeryPlaceHolder())),
            padding: EdgeInsets.only(bottom: 20.h),
          )),
      if (controller.debitCardOptions.length > 0)
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: controller.debitCardOptions
              .map((element) => InkWell(
                  onTap: () {
                    controller.application.selectedCard(element);
                  },
                  child: Obx(() => Container(
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  blurRadius: 15,
                                  spreadRadius: 5)
                            ],
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            border: Border.all(
                                color: GlorifiColors.white,
                                width: controller.application.selectedCard.value
                                            .cardProductToken ==
                                        element.cardProductToken
                                    ? 3
                                    : 0)),
                        child: CachedNetworkImage(
                            width: childWidth.sw,
                            imageUrl: element.cardArt,
                            fit: BoxFit.cover,
                            placeholder: (context, url) => SizedBox(
                                width: childWidth.sw,
                                height: heightOfPlaceHolders * childWidth,
                                child: ShimmeryPlaceHolder(
                                  radius: 8,
                                )),
                            errorWidget: (context, url, error) => SizedBox(
                                width: childWidth.sw,
                                height: heightOfPlaceHolders * childWidth,
                                child: ShimmeryPlaceHolder(
                                  radius: 8,
                                ))),
                        // child: Image.network(
                        //   element.cardArt,
                        //   width: .26.sw,
                      ))))
              .toList(),
        ),
      SizedBox(height: 30),
      Obx(
        () {
          return Text(
              controller
                  .applicationInProgress.value.selectedCard.value.cardTitle,
              style: TextStyle(
                  color: GlorifiColors.darkBlue,
                  fontWeight: FontWeight.bold,
                  fontSize: 16));
        },
      ),
      SizedBox(height: 5),
      Obx(() {
        return Text(
          controller
              .applicationInProgress.value.selectedCard.value.cardDescription,
          style: TextStyle(fontSize: 16, height: 1.5),
        );
      }),
      SizedBox(
        height: 15.h,
      ),
    ];
  }
}
