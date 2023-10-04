import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/controllers/DeveloperOptionsController.dart';
import 'package:glorifi/src/controllers/global_appstate_notifier.dart';
import 'package:glorifi/src/environment/environment.dart';
import 'package:glorifi/src/feature/banking/controller/my_bank_controller.dart';
import 'package:glorifi/src/feature/banking/widgets/alert_dialog.dart';
import 'package:glorifi/src/feature/cockpit/feed2.0/products/products_screen.dart';
import 'package:glorifi/src/feature/credit_card_2/apply_for_card/controller/acc_controller.dart';
import 'package:glorifi/src/feature/credit_card_2/dashboard/models/cc_dashboard_model.dart';
import 'package:glorifi/src/feature/credit_card_2/dashboard/screens/cc_dashboard_screen.dart';
import 'package:glorifi/src/feature/feature_flag/feature_flag_controller.dart';
import 'package:glorifi/src/feature/onboard/edit_profile/edit_profile_landing/widget/logout_dialog.dart';
import 'package:glorifi/src/font_style_global.dart';
import 'package:glorifi/src/routes/app_pages.dart';
import 'package:glorifi/src/services/my_bank_service.dart';
import 'package:glorifi/src/services/session_manager_service.dart';
import 'package:glorifi/src/utils/glorifi_assets.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:glorifi/src/utils/responsive/responsive.dart';
import 'package:glorifi/src/utils/share/share_app_util.dart';
import 'package:glorifi/src/utils/snackbar_util.dart';
import 'package:glorifi/src/widgets/tap/ripple.dart';
import 'package:provider/provider.dart';

class ProfileMenu extends StatelessWidget {
  const ProfileMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 56.w,
        vertical: 56.h,
      ),
      color: GlorifiColors.white,
      child: Wrap(
        children: [
          // TODO: Best practicify this
          _buttonRow(
            "assets/images/profile.svg",
            "Profile and Settings",
            () {
              Get.toNamed(
                Routes.editProfileLanding,
                preventDuplicates: false,
              );
            },
          ),
          _buttonRow(
            GlorifiAssets.chatBubble,
            "Help and Support",
            () {
              Get.toNamed(
                Routes.faqCategoriesListingScreen,
                preventDuplicates: false,
              );
            },
          ),
          Visibility(
            visible: !kIsWeb,
            child: _buttonRow(
              "assets/images/share.svg",
              "Share App",
              () async {
                await ShareAppUtil.showShareApp(null, null, null);
              },
            ),
          ),

          _buttonRow(
            "assets/images/legal_icon.svg",
            "About and Legal",
            () => Get.toNamed(Routes.settings, preventDuplicates: false),
          ),

          Container(
            padding: EdgeInsets.symmetric(
              vertical: 16.h,
            ),
            child: Divider(
              color: GlorifiColors.defaultGradientStartColor,
              thickness: 0.5,
            ),
          ),
          _buttonRow("assets/images/logout.svg", "Sign Out", () {
            if (kIsWeb) {
              final sessionManager = Get.find<SessionManagerService>();
              sessionManager.logout();
            } else {
              _showLogoutDialog(context);
            }
          }),
          if (Environment().config is! ProdConfig)
            _buttonRow(
              "assets/icons/alert_circle.svg",
              "Developer Options",
              _showDevOptionsModal,
              color: GlorifiColors.darkRed,
            ),
        ],
      ),
    );
  }

  _showLogoutDialog(BuildContext context) {
    final sessionManager = Get.find<SessionManagerService>();
    showDialog(
        context: context,
        useRootNavigator: true,
        builder: (BuildContext context) {
          return LogoutDialog(onLogoutConfirm: () {
            sessionManager.logout();
          });
        });
  }

  _showDevOptionsModal() {
    final controller = Get.put(ACCController());
    final controllerCCDashBoard = Get.put(MyBankController());
    final DeveloperOptionsController _developerOptionsController =
        Get.find<DeveloperOptionsController>();

    Get.bottomSheet(
      Consumer<GlobalAppStateNotifier>(builder: (context, appState, child) {
          return SingleChildScrollView(
              child: Container(
          padding: const EdgeInsets.all(20),
          color: Colors.white,
          height: Get.height * 0.8,
          child: Column(
            children: [
              Text(
                'These options are available only for builds with DEV config.',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                ),
              ),
              Row(
                children: [
                  Expanded(child: Text('Use sandbox environment for Plaid')),
                  Switch(
                      value: appState.isPlaidSandbox,
                      onChanged: (val) {
                        appState.togglePlaidSandbox();
                      })
                ],
              ),
              Ripple(
                onTap: () async {
                  Get.back();
                  await Get.toNamed(Routes.creditCardBenefits);
                },
                child: Obx(() {
                  return Row(
                    children: [
                      Expanded(
                          child: Text(
                              'Apply for Credit Card [Mock: ${controller.isMockEnabled ? "Enabled" : "Disabled"}]')),
                      Switch(
                        value: controller.isMockEnabled,
                        onChanged: controller.toggleMock,
                      )
                    ],
                  );
                }),
              ),
              Ripple(
                onTap: () async {},
                child: Obx(() {
                  return Row(
                    children: [
                      Expanded(
                          child: Text(
                                'Show Credit Cards [Mock: ${controllerCCDashBoard.isMockEnabled.value ? "Enabled" : "Disabled"}]')),
                      Switch(
                        value: controllerCCDashBoard.isMockEnabled.value,
                        onChanged: (bool value) =>
                            controllerCCDashBoard.isMockEnabled.value = value,
                      )
                    ],
                  );
                }),
                ),
                Obx(
                  () => Row(
                    children: [
                      Expanded(child: Text('Enable credit score mocks')),
                      Switch(
                        value: _developerOptionsController
                            .isMockedCreditScoreEnabled.isTrue,
                        onChanged: (bool value) => _developerOptionsController
                            .isMockedCreditScoreEnabled.value = value,
                      )
                    ],
                  ),
                ),
                Divider().paddingSymmetric(vertical: 10),
                Ripple(
                    onTap: () async {
                      CCDashboardModel? cc =
                          await MyBankService()
                          .getCreditCardAccount(
                              controllerCCDashBoard.isMockEnabled.value);
                      if (cc != null) {
                        Get.back();
                        await Get.toNamed(Routes.ccDashboard, arguments: {
                          "accountModel": cc,
                          "isMockEnabled":
                              controllerCCDashBoard.isMockEnabled.value
                        });
                      } else {
                        glorifiAlertDialog(
                            "User does not have a credit card to display",
                            "",
                            "Okay");
                      }
                    },
                    child: Row(
                      children: [
                        Expanded(child: Text('Credit Card Dashboard')),
                      ],
                    )),
                SizedBox(
                  height: 20,
                ),
                Ripple(
                    onTap: () async {
                      Get.back();
                      await Get.toNamed(Routes.creditCardStatementsScreen);
                    },
                    child: Row(
                      children: [
                        Expanded(child: Text('Statement hub  ')),
                      ],
                    )),
                SizedBox(
                  height: 20,
                ),
                Ripple(
                    onTap: () async {
                      Get.back();
                      Get.find<FeatureFlagController>()
                          .showProductsTab
                          .toggle();
                    },
                    child: Row(
                      children: [
                        Expanded(child: Text('Toggle Products Tab')),
                      ],
                    )),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ));
        },
      ),
      barrierColor: GlorifiColors.barrierColor,
      isDismissible: true,
    );
  }

  Widget _buttonRow(
    String iconName,
    String title,
    Function() onTap, {
    Color color = GlorifiColors.darkBlueColor,
  }) {
    return Ripple(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 24.h,
        ),
        child: Row(
          children: [
            SvgPicture.asset(iconName, height: 20.h, width: 20.w, color: color),
            SizedBox(
              width: 25.w,
            ),
            Text(
              title,
              style: bodySemiBold18Primary(
                color: color,
              ),
              textAlign: TextAlign.start,
            ),
          ],
        ),
      ),
    );
  }
}
