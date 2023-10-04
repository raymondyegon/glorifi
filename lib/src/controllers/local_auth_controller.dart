import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:glorifi/src/core/cache/cache_client.dart';
import 'package:glorifi/src/core/cache/cache_keys.dart';
import 'package:glorifi/src/core/logger.dart';
import 'package:local_auth/local_auth.dart';

class LocalAuth {
  static Future<bool> authenticateWithBiometrics() async {
    final LocalAuthentication localAuthentication = LocalAuthentication();
    bool isBiometricSupported = await localAuthentication.isDeviceSupported();
    bool canCheckBiometrics = await localAuthentication.canCheckBiometrics;

    bool isAuthenticated = false;

    if (isBiometricSupported && canCheckBiometrics) {
      isAuthenticated = await localAuthentication.authenticate(
        localizedReason: 'This is the reason why we need biometrics',
        biometricOnly: true,
        sensitiveTransaction: false,
      );
    }

    return isAuthenticated;
  }

  static Future<bool> checkDeviceIfHasLocalBio() async {
    if (kIsWeb) {
      return false;
    }
    final LocalAuthentication localAuthentication = LocalAuthentication();
    bool isBiometricSupported = await localAuthentication.isDeviceSupported();
    bool canCheckBiometrics = await localAuthentication.canCheckBiometrics;
    BiometricType? _bioType = await getAvailableBiometrics();
    bool hasLB = isBiometricSupported && canCheckBiometrics && _bioType != null;
    return hasLB;
  }

  static Future<BiometricType?> getAvailableBiometrics() async {
    final CacheClient cacheClient = CacheClient();
    final LocalAuthentication localAuthentication = LocalAuthentication();
    BiometricType? _bioType;
    List<BiometricType> availableBiometrics =
        await localAuthentication.getAvailableBiometrics();
    if (availableBiometrics.contains(BiometricType.face) && Platform.isIOS) {
      _bioType = BiometricType.face;
      cacheClient.putString(CacheKeys.biometricTypeKey, "Face ID");
    } else if (availableBiometrics.contains(BiometricType.fingerprint)) {
      _bioType = BiometricType.fingerprint;
      cacheClient.putString(CacheKeys.biometricTypeKey, "Fingerprint");
    }
    return _bioType;
  }

  static Future<bool> isLocalBioEnabled() async {
    final LocalAuthentication localAuthentication = LocalAuthentication();
    bool isBiometricSupported = await localAuthentication.isDeviceSupported();
    bool deviceRegistered = await _deviceHasRegisteredBiometric();

    Log.info("isBiometricSupported $isBiometricSupported");
    Log.info("deviceRegistered $deviceRegistered");

    return isBiometricSupported && deviceRegistered;
  }

  static Future<bool> _deviceHasRegisteredBiometric() async {
    final LocalAuthentication localAuthentication = LocalAuthentication();
    List<BiometricType> registeredBiometrics = [];
    try {
      if (Platform.isIOS) {
        registeredBiometrics =
            await localAuthentication.getAvailableBiometrics();
      } else if (Platform.isAndroid) {
        //For android LocalAuth can not determine if only fingerprint is active
        //see https://pub.dev/packages/local_auth#android-integration last part
        //So we need to implement our own method
        registeredBiometrics = await getAvailableBiometricForAndroid();
      }
    } on PlatformException catch (e) {
      registeredBiometrics = <BiometricType>[];
      Log.error(e);
    }

    registeredBiometrics.forEach((element) {
      Log.info("registeredBiometrics $element");
    });

    return registeredBiometrics.contains(BiometricType.fingerprint) ||
        registeredBiometrics.contains(BiometricType.face);
  }

  static Future<List<BiometricType>> getAvailableBiometricForAndroid() async {
    List<BiometricType> registeredBiometrics = [];
    try {
      MethodChannel _channel = MethodChannel('LOCAL_BIO');
      bool deviceHasEnrolledFingerprint =
          await _channel.invokeMethod('hasFingerprint');
      if (deviceHasEnrolledFingerprint) {
        registeredBiometrics = [BiometricType.fingerprint];
      }
    } on PlatformException catch (e) {
      registeredBiometrics = <BiometricType>[];
      Log.error(e);
    }

    return registeredBiometrics;
  }
}
