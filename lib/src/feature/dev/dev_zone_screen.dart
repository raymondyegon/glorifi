import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/controllers/app_lock_notifier.dart';
import 'package:glorifi/src/controllers/development/dev_zone_controller.dart';
import 'package:glorifi/src/feature/demo/app_bar_demo.dart';
import 'package:glorifi/src/routes/app_pages.dart';
import 'package:glorifi/src/utils/glorifi_values.dart';
import 'package:provider/provider.dart';

import '../../environment/environment.dart';
import '../banking/controller/my_bank_controller.dart';

class DevZoneScreen extends GetView<DevZoneController> {
  const DevZoneScreen({Key? key}) : super(key: key);
  static const routeName = '/devZone';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(GlorifiValues.padding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Current environment: ${Environment().config.name}',
                  textAlign: TextAlign.center,
                ),
                const Text(
                  'Pick a feature!',
                  textAlign: TextAlign.center,
                ),
                // AppLockWidget(),
                ElevatedButton(
                  onPressed: () {
                    Get.toNamed(Routes.splash, arguments: true);
                  },
                  child: const Text('Auth'),
                ),
                ElevatedButton(
                  onPressed: () {
                    controller.navigateToCreateProfilePlus();
                  },
                  child: const Text('Create Profile'),
                ),
                ElevatedButton(
                  onPressed: () {
                    controller.navigateToNavBarScreen();
                  },
                  child: const Text('Feed'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Get.toNamed(Routes.valueScreens);
                  },
                  child: const Text('Value Screen'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Get.toNamed(Routes.login);
                  },
                  child: const Text('Login'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Get.toNamed(Routes.localAuthDemo);
                  },
                  child: const Text('LocalAuth Demo'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Get.toNamed(Routes.plaidDemo);
                  },
                  child: const Text('Plaid Demo'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Get.toNamed(Routes.imagePickerDemo);
                  },
                  child: const Text('Image Picker Demo'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Get.toNamed(Routes.appUnlock);
                  },
                  child: const Text('App Unlock Demo'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Get.toNamed(Routes.backbasePage);
                  },
                  child: const Text('Connect to Backbase'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Get.toNamed(Routes.unqorkPage);
                  },
                  child: const Text('Connect to Unqork'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Get.toNamed(Routes.video);
                  },
                  child: const Text('Video Player Demo'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Get.toNamed(Routes.cashOnHand);
                  },
                  child: const Text('Cash On Hand Details'),
                ),

                ElevatedButton(
                  onPressed: () {
                    Get.toNamed(Routes.creditCardScreen);
                  },
                  child: const Text('Credit Card'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Get.toNamed(Routes.personalSnapShotFullState);
                  },
                  child: const Text('Personal Snapshot State'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Get.toNamed(Routes.faqCategoriesListingScreen);
                  },
                  child: const Text('Support Account Screen'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Get.toNamed(Routes.reusableTextWidget);
                  },
                  child: const Text('Reusable text widget'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Get.toNamed(Routes.brokerage);
                  },
                  child: const Text('Brokerage'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Get.to(() => GlorifiAppBarDemo());
                  },
                  child: const Text('Glorifi Appbar'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Get.toNamed(Routes.creditUsage);
                  },
                  child: const Text('Credit Usage'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Get.toNamed(Routes.createPassword);
                  },
                  child: const Text('CREATE PASSWORD'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AppLockWidget extends StatefulWidget {
  const AppLockWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<AppLockWidget> createState() => _AppLockWidgetState();
}

class _AppLockWidgetState extends State<AppLockWidget> {
  @override
  Widget build(BuildContext context) {
    final AppLockNotifier _appLockController =
        Provider.of<AppLockNotifier>(context, listen: true);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          StreamBuilder<int>(
              stream: _appLockController.timerStream,
              builder: (context, data) {
                if (data.hasData && _appLockController.allowAutoLock) {
                  return Text('Auto lock app: ${data.data}');
                } else {
                  return SizedBox();
                }
              }),
          Switch(
            value: _appLockController.allowAutoLock,
            onChanged: (value) {
              _appLockController.setAllowAutoLock = value;
            },
          ),
        ],
      ),
    );
  }
}
