import 'dart:math';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

class ResponsiveUtil {
  static const Size defaultSize = Size(360, 690);
  static late ResponsiveUtil _instance;

  late Size uiSize;

  late Orientation _orientation;

  late double _pixelRatio;
  late double _textScaleFactor;
  late double _screenWidth;
  late double _screenHeight;
  late double _statusBarHeight;
  late double _bottomBarHeight;

  ResponsiveUtil._();

  factory ResponsiveUtil() {
    return _instance;
  }

  static void init(
    BoxConstraints constraints, {
    Orientation orientation = Orientation.portrait,
    Size designSize = defaultSize,
  }) {
    _instance = ResponsiveUtil._()
      ..uiSize = designSize
      .._orientation = orientation
      .._screenWidth = constraints.maxWidth
      .._screenHeight = constraints.maxHeight;

    var window = WidgetsBinding.instance?.window ?? ui.window;
    _instance._pixelRatio = window.devicePixelRatio;
    _instance._statusBarHeight = window.padding.top;
    _instance._bottomBarHeight = window.padding.bottom;
    _instance._textScaleFactor = window.textScaleFactor;
  }

  Orientation get orientation => _orientation;

  double get textScaleFactor => _textScaleFactor;

  double get pixelRatio => _pixelRatio;

  double get screenWidth => _screenWidth;

  double get screenHeight => _screenHeight;

  double get statusBarHeight => _statusBarHeight / _pixelRatio;

  double get bottomBarHeight => _bottomBarHeight / _pixelRatio;

  double get scaleWidth => _screenWidth / uiSize.width;

  double get scaleHeight => _screenHeight / uiSize.height;

  double get scaleText => min(scaleWidth, scaleHeight);

  double setWidth(num width) => width * scaleWidth;

  double setHeight(num height) => height * scaleHeight;

  double radius(num r) => r * scaleText;

  double setSp(num fontSize) {
    final scaledText = fontSize * scaleText;
    return scaledText > 12 ? scaledText : 12;
  }
}

extension Precision on double {
  double toPrecision(int fractionDigits) {
    final mod = pow(10, fractionDigits.toDouble());
    return (this * mod).round().toDouble() / mod;
  }
}
