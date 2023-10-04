import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/core/data_helper.dart';
import 'package:glorifi/src/feature/onboard/create_profile_plus/widgets/profile_colors.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';
import 'package:local_auth/local_auth.dart';

class UnlockScreen extends StatefulWidget {
  UnlockScreen(BiometricType biometricType, {Key? key}) : super(key: key);

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

class UnlockState extends State<UnlockScreen> {
  bool _localAuthFlag = false;
  var dataHelper = DataHelperImpl.instance;

  @override
  void initState() {
    // Todo: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        backgroundColor: profileBackgroundColor,
        body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Align(
              //   alignment: Alignment.topCenter,
              //   child: Image.asset(
              //     'assets/images/faceid.png',
              //     height: 150.0,
              //     width: 150.0,
              //   ),
              // ),
              // Image.asset(
              //   'assets/images/faceid.png',
              //   height: 150.0,
              //   width: 150.0,
              // ),
              Align(
                alignment: Alignment.center,
                child: Expanded(
                  child: Center(
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              color: GlorifiColors.biscayBlue),
                          child: Image.asset(
                            'assets/images/faceid.png',
                            height: 150.0,
                            width: 150.0,
                          ),
                        ).paddingOnly(bottom: 20),
                        SizedBox(
                            width: 150,
                            height: 50,
                            child: ElevatedButton(
                              style:
                                  ElevatedButton.styleFrom(primary: profileRed),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "UNLOCK",
                                    style: TextStyle(
                                        color: profileBackgroundColor,
                                        fontSize: 18),
                                  ),
                                ],
                              ),
                              onPressed: unlockApp,
                            ))
                      ],
                    ),
                  ),
                ),
              ),
            ]),
      ),
      onWillPop: () => Future.value(false),
    );
  }

  Future<void> unlockApp() async {
    _localAuthFlag = await UnlockScreen.authenticateWithBiometrics();
    setState(() {
      _localAuthFlag;
      if (_localAuthFlag) {
        if (Navigator.canPop(context)) {
          Navigator.pop(context);
        } else {
          SystemNavigator.pop();
        }
        dataHelper.cacheHelper.getRefreshToken().then((value) => {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(
                "Biometric Auth Successful - Refresh Token : $value",
                textAlign: TextAlign.center,
              )))
            });
      } else {
        Get.defaultDialog(title: "Failure", middleText: "Biometric Auth Error");
      }
    });
  }
}
