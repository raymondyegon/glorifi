import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/feature/banking/servicing/ebs_controller.dart';
import 'package:glorifi/src/feature/banking/servicing/screens/account_settings/ebs_manage_pin_screen.dart';
import 'package:glorifi/src/feature/banking/servicing/screens/account_settings/ebs_statements_screen.dart';
import 'package:glorifi/src/feature/banking/servicing/widgets/eba_widget_container.dart';
import 'package:glorifi/src/feature/banking/servicing/widgets/ebs_container.dart';
import 'package:glorifi/src/feature/banking/servicing/widgets/row_button.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/routes/app_pages.dart';
import 'package:glorifi/src/utils/glorifi_assets.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive.dart';
import 'package:glorifi/src/utils/text_constants.dart';
import 'package:glorifi/src/widgets/loading/glorifi_spinner.dart';
import 'package:flutter_switch/flutter_switch.dart';

class EBSAccountSettingsScreen extends GetView<EBSController> {
  const EBSAccountSettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return EBSContainer(
        title: 'Account Details',
        children: _content(),
        showSettings: false,
        screenBackground: GlorifiColors.white,
      );
    });
  }

  List<Widget> _content() {
    return [
      Expanded(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ..._innerContent(),
            ],
          ),
        ),
      )
    ];
  }

  List<Widget> _innerContent() {
    switch (controller.details.accountType) {
      case "Consumer Checking":
        return [
          _card(),
          _accountDetails(),
          if (controller.cardStatus.value != "UNACTIVATED") _pinManagement(),
          _statements(),
          _atm(),
          _wireMoney(),
        ];
      default:
        return [
          _accountDetails(),
          _statements(),
          _atm(),
          _wireMoney(),
        ];
    }
  }

  Widget _accountDetails() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 40.0.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  'Account Details',
                  style: smallBold16Primary(
                    color: GlorifiColors.ebonyBlue,
                  ),
                ),
              ),
              IconButton(
                onPressed: controller.toggleAccountDetailsVisibility,
                icon: SvgPicture.asset(
                  GlorifiAssets.eyeOff,
                  color: GlorifiColors.black,
                ),
              ),
            ],
          ),
          SizedBox(height: 6),
          _accountDetailsRow(
              'Account Number', _obscureText(controller.details.accountNumber), true),
          _accountDetailsRow(
              'Routing Number', _obscureText(controller.details.routingNumber), true),
          _accountDetailsRow('Wire Routing Number', '', false),
          SizedBox(height: 16.h),
        ],
      ),
    );
  }

  Widget _accountDetailsRow(String left, String right, bool includeDivider) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 13.0.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                left,
                style: captionRegular14Primary(
                  color: GlorifiColors.ebonyBlue,
                ),
              ),
              Text(
                right,
                style: smallSemiBold16Primary(
                  color: GlorifiColors.cornflowerBlue,
                ),
              ),
            ],
          ),
        ),
        if (includeDivider)
          Divider(
            color: GlorifiColors.borderGrey,
          )
      ],
    );
  }

  String _obscureText(String text) {
    if (controller.obscuredDetails) {
      if (text.length > 4) {
        final obscuredPart =
            List<String>.generate(text.length - 4, (int index) => '*', growable: false);
        final String last4 = text.substring(text.length - 4, text.length);
        return obscuredPart.join() + last4;
      }
      final obscuredPart = List<String>.generate(text.length, (int index) => '*', growable: false);
      return obscuredPart.join();
    } else {
      return text;
    }
  }

  Widget _statements() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.0.w),
      child: RowButton(
        showShadow: false,
        asset: 'assets/icons/statements.svg',
        title: TextConstants.statements,
        onTap: () {
          Get.to(() => EBSStatementsScreen());
        },
      ),
    );
  }

  Widget _card() {
    return Obx(() {
      switch (controller.cardStatus.value) {
        case "UNACTIVATED":
          return _inactiveCard();
        case "ACTIVE":
        case "SUSPENDED":
          return _activeCard();
        default:
          if (controller.cardTransitionLoading.value == true) {
            return EBSWidgetContainer(
              child: Center(
                child: GlorifiSpinner(
                  size: 25,
                ),
              ),
            );
          }
          return Padding(
            padding: EdgeInsets.fromLTRB(32.w, 38.h, 32.w, 24.h),
            child: RowButton(
              border: Border.all(color: GlorifiColors.altoGrey),
              asset: GlorifiAssets.creditCard,
              title: "Order a Card",
              onTap: () async {
                return controller.onOrderDebitCard();
              },
            ),
          );
      }
    });
  }

  Widget _activeCard() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 37.0.w),
      child: Column(
        children: [
          SizedBox(height: 27.h),
          
          Image.network(
            controller.details.cardArt.first,
            width: double.infinity,
          ),
          _accountDetailsRow('Card Number', '*${controller.details.cardLastFour}', false),
          SizedBox(height: 36.h),
          Obx(() {
            if (controller.cardTransitionLoading.value) {
              return GlorifiSpinner(
                size: 25,
              ).paddingOnly(right: 16);
            }
            return Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Card status',
                        style: smallBold16Primary(
                          color: GlorifiColors.ebonyBlue,
                        ),
                      ),
                    ),
                    FlutterSwitch(
                      onToggle: (val) {
                        if (val) {
                          controller.unlockCard();
                        } else {
                          controller.lockCard();
                        }
                      },
                      activeColor: GlorifiColors.darkBlueTint[500]!,
                      value: controller.cardStatus.value == "ACTIVE",
                      height: 20,
                      width: 36,
                      toggleSize: 14,
                      activeToggleColor: GlorifiColors.white,
                    ),
                    SizedBox(width: 10),
                    Text(
                      controller.cardStatus.value == "ACTIVE" ? 'On' : 'Off',
                      style: captionSemiBold14Primary(color: GlorifiColors.midnightBlue),
                    ),
                    SizedBox(width: 13.w),
                  ],
                ),
                SizedBox(height: 30.h),
                Text(
                  'You can temporarily turn your card on and off. You’re in control.',
                  style: captionRegular14Primary(),
                ),
                if (controller.cardTransitionErrorString.value.isNotEmpty)
                  Text(
                    controller.cardTransitionErrorString.value,
                    style: captionBold14Primary(color: GlorifiColors.redError),
                  ),
                SizedBox(height: 26.h),
              ],
            );
          }),
        ],
      ),
    );
  }

  Widget _inactiveCard() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 37.0.w),
      child: Column(
        children: [
          SizedBox(height: 27.h),
          
          Image.network(
            controller.details.cardArt.first,
            width: double.infinity,
          ),
          _accountDetailsRow('Card Number', '*${controller.details.cardLastFour}', false),
          SizedBox(height: 16.h),
          Obx(() {
            if (controller.cardTransitionLoading.value) {
              return GlorifiSpinner(
                size: 25,
              ).paddingOnly(right: 16);
            } else {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 3.0.w),
                child: Column(
                  children: [
                    RowButton(
                      asset: GlorifiAssets.power,
                      title: 'Activate Card',
                      onTap: controller.activateCard,
                      backgroundColor: GlorifiColors.cornflowerBlue,
                      textColor: Colors.white,
                      leadingIconColor: Colors.lightBlue,
                    ),
                    if (controller.cardTransitionErrorString.value.isNotEmpty)
                      Text(
                        controller.cardTransitionErrorString.value,
                        style: captionBold14Primary(color: GlorifiColors.redError),
                      )
                  ],
                ),
              );
            }
          }),
          SizedBox(height: 22.h),
        ],
      ),
    );
  }

  Widget _pinManagement() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.0.w),
      child: RowButton(
        showShadow: false,
        asset: 'assets/icons/pin.svg',
        title: TextConstants.changePin,
        onTap: () {
          controller.fetchPinCredentials();
          Get.to(() => EBSManagePinScreen());
        },
      ),
    );
  }

  Widget _atm() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.0.w),
      child: RowButton(
        showShadow: false,
        asset: GlorifiAssets.findAtm,
        title: TextConstants.findATM,
        onTap: () {
          Get.toNamed(Routes.findAtms);
        },
      ),
    );
  }

  Widget _wireMoney() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.0.w),
      child: RowButton(
        showShadow: false,
        asset: GlorifiAssets.reportMoney,
        title: TextConstants.wireMoney,
        onTap: () {
          Get.toNamed(Routes.ebsWireInstructions);
        },
      ),
    );
  }
}
