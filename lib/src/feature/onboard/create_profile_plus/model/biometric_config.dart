import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:glorifi/src/utils/glorifi_assets.dart';
import 'package:glorifi/src/utils/text_constants.dart';
import 'package:local_auth/local_auth.dart';

class BiometricConfig {
  late BiometricType biometricType;
  late String iconPath;
  late String buttonTitle;
  late String dialogTitle;

  BiometricConfig(BiometricType? biometricType) {
    biometricType = biometricType;
    if (kIsWeb) {
      iconPath = "";
      buttonTitle = TextConstants.secureConstant;
      dialogTitle = "";
    } else if (Platform.isAndroid) {
      iconPath = GlorifiAssets.ic_fingerprint;
      buttonTitle = TextConstants.scanFingerprint;
      dialogTitle = TextConstants.pleaseSetupFingerprint;
    } else if (biometricType == BiometricType.face) {
      iconPath = GlorifiAssets.ic_face_id;
      buttonTitle = TextConstants.useFaceID;
      dialogTitle = TextConstants.pleaseSetupFaceID;
    } else if (biometricType == BiometricType.fingerprint) {
      iconPath = GlorifiAssets.ic_touch_id;
      buttonTitle = TextConstants.useTouchID;
      dialogTitle = TextConstants.PleaseSetupTouchID;
    } else {
      iconPath = GlorifiAssets.ic_face_id;
      buttonTitle = TextConstants.useBiometric;
      dialogTitle = TextConstants.pleaseSetupBiometric;
    }
  }
}
