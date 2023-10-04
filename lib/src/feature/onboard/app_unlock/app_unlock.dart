import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:glorifi/src/feature/onboard/app_unlock/unlock_screen_new.dart';
import 'package:local_auth/local_auth.dart';

class AppUnlock extends StatefulWidget {
  const AppUnlock({Key? key}) : super(key: key);

  @override
  State<AppUnlock> createState() => _AppUnlockState();

  static Future<bool> authenticateWithBiometrics() async {
    final LocalAuthentication localAuthentication = LocalAuthentication();
    bool isBiometricSupported = await localAuthentication.isDeviceSupported();
    bool canCheckBiometrics = await localAuthentication.canCheckBiometrics;

    bool isAuthenticated = false;

    if (isBiometricSupported && canCheckBiometrics) {
      isAuthenticated = await localAuthentication.authenticate(
        localizedReason: 'This is the reason why we need biometrics',
        biometricOnly: false,
      );
    }

    return isAuthenticated;
  }
}

class _AppUnlockState extends State<AppUnlock> {
  // ignore: unused_field
  bool _localAuthFlag = false;

  @override
  void initState() {
    init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue,
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        elevation: 0,
      ),
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              ElevatedButton(onPressed: unlockApp, child: Text("Unlock")),
            ]),
      ),
    );
  }

  void lockApp() {}

  Future<void> unlockApp() async {
    setState(() {
      Get.to(() => UnlockScreenNew());
    });
  }

  void init() {}

  Future<List<BiometricType>> getBiometricType(
      LocalAuthentication localAuthentication) {
    return Future.value(localAuthentication.getAvailableBiometrics());
  }
}
