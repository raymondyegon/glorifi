import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/controllers/app_lock_notifier.dart';
import 'package:glorifi/src/core/data_helper.dart';
import 'package:glorifi/src/feature/onboard/create_profile_plus/widgets/profile_colors.dart';
import 'package:glorifi/src/routes/app_pages.dart';
import 'package:local_auth/local_auth.dart';
import 'package:provider/provider.dart';

class UnlockScreenNew extends StatefulWidget {
  UnlockScreenNew({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => UnlockState();

  static Future<bool> authenticateWithBiometrics() async {
    final LocalAuthentication localAuthentication = LocalAuthentication();
    bool isBiometricSupported = await localAuthentication.isDeviceSupported();
    bool canCheckBiometrics = await localAuthentication.canCheckBiometrics;

    bool isAuthenticated = false;

    if (isBiometricSupported && canCheckBiometrics) {
      isAuthenticated = await localAuthentication.authenticate(
        localizedReason: 'This is the reason why we need biometrics',
        biometricOnly: true,
      );
    }

    return isAuthenticated;
  }
}

class UnlockState extends State<UnlockScreenNew> {
  bool _localAuthFlag = false;
  var dataHelper = DataHelperImpl.instance;

  @override
  void initState() {
    checkBiometricSetup();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        backgroundColor: profileBackgroundColor,
        body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Image.asset(
                  'assets/images/logo_new.png',
                  height: 150.0,
                  width: 150.0,
                ).paddingOnly(top: 40),
              ),
              Row(
                children: [
                  Image.asset(
                    'assets/images/qn_mark.png',
                    height: 25.0,
                    width: 25.0,
                  ).paddingOnly(bottom: 15, left: 15),
                  Spacer(),
                  Text(
                    "Change User",
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ).paddingOnly(bottom: 15, right: 15),
                ],
              ),
            ]),
      ),
      onWillPop: () => Future.value(false),
    );
  }

  Future<void> unlockApp() async {
    _localAuthFlag = await UnlockScreenNew.authenticateWithBiometrics();
    setState(() {
      _localAuthFlag;
      if (_localAuthFlag) {
        if (Navigator.canPop(context)) {
          Provider.of<AppLockNotifier>(context, listen: false)
            ..setAppLocked = false
            ..setAllowAutoLock = false;
          Navigator.pop(context);
        } else {
          SystemNavigator.pop();
        }

        dataHelper.cacheHelper.getRefreshToken().then((value) => {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    "Biometric Auth Successful - Refresh Token : $value",
                    textAlign: TextAlign.center,
                  ),
                ),
              )
            });
      } else {
        _showMyDialog('Biometric Authentication Failure',
            'You will be redirected to Sign In page');
      }
    });
  }

  Future<void> _showMyDialog(String title, String message) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Text(message),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Continue'),
              onPressed: () {
                Navigator.of(context).pop();
                if (Navigator.canPop(context)) {
                  Navigator.pop(context);
                } else {
                  SystemNavigator.pop();
                }
                Provider.of<AppLockNotifier>(context, listen: false)
                    .setAllowAutoLock = false;
                Get.toNamed(Routes.login);
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> checkBiometricSetup() async {
    final LocalAuthentication localAuthentication = LocalAuthentication();
    bool isBiometricSupported = await localAuthentication.isDeviceSupported();
    bool canCheckBiometrics = await localAuthentication.canCheckBiometrics;
    if (isBiometricSupported && canCheckBiometrics) {
      unlockApp();
    } else {
      _showMyDialog("Alert",
          "Biometrics hasn't setup on your device. You will be redirected to Sign In page");
    }
  }
}
