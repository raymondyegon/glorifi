import 'package:flutter/foundation.dart';

enum BundleType {
  None,
  HomeFront,
  Heroes,
  Protect,
}

extension BundleTypeExtension on BundleType {
  static BundleType toBundleType(String bundleType) {
    return BundleType.values.firstWhere(
        (e) => describeEnum(e).trim().toUpperCase() == bundleType.toUpperCase(),
        orElse: () => BundleType.None);
  }

  static String toBundleTypeString(BundleType bundleType) =>
      describeEnum(bundleType);
}
