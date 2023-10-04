import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glorifi/src/feature/banking/controller/glorifi_gradient_progress_indicator_controller.dart';

class GlorifiGradientProgressIndicator
    extends GetView<GlorifiGradientProgressIndicatorController> {
  const GlorifiGradientProgressIndicator({
    Key? key,
    required this.radius,
    required this.strokeWidth,
    required this.gradientColors,
    this.backgroundColor = Colors.transparent,
    this.curveType = Curves.easeInQuad,
  }) : super(key: key);

  final double radius;
  final double strokeWidth;
  final List<Color> gradientColors;
  final Color backgroundColor;
  final Curve curveType;

  @override
  Widget build(BuildContext context) {
    return Obx(() => SizedBox(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Center(
                      child: AnimatedBuilder(
                        animation: controller.animationRotationController,
                        builder: (_, child) {
                          return Transform.rotate(
                            angle: controller
                                    .animationRotationController.value.obs *
                                (pi * 2),
                            child: child,
                          );
                        },
                        child: _GradientCircularProgressIndicator(
                          gradientColors: gradientColors,
                          radius: radius,
                          strokeWidth: strokeWidth,
                          backgroundColor: backgroundColor,
                          value: Tween(begin: 0.0, end: 0.25)
                              .animate(
                                CurvedAnimation(
                                  parent: controller.animationController,
                                  curve: curveType,
                                ),
                              )
                              .value,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}

class _GradientCircularProgressIndicator extends StatelessWidget {
  _GradientCircularProgressIndicator({
    this.strokeWidth = 10.0,
    this.backgroundColor = Colors.transparent,
    required this.radius,
    required this.gradientColors,
    required this.value,
  });

  final double strokeWidth;
  final double value;
  final Color backgroundColor;
  final double radius;
  final List<Color> gradientColors;

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: -pi / 2,
      child: CustomPaint(
        size: Size.fromRadius(radius),
        painter: _GradientCircularProgressPainter(
          strokeWidth: strokeWidth,
          backgroundColor: backgroundColor,
          gradientColors: gradientColors,
          value: value,
          radius: radius,
        ),
      ),
    );
  }
}

class _GradientCircularProgressPainter extends CustomPainter {
  _GradientCircularProgressPainter({
    required this.strokeWidth,
    required this.value,
    this.backgroundColor = Colors.transparent,
    required this.gradientColors,
    this.total = 2 * pi,
    this.radius,
  });

  final double strokeWidth;
  final double value;
  final Color backgroundColor;
  final List<Color> gradientColors;
  final double total;
  final double? radius;

  @override
  void paint(Canvas canvas, Size size) {
    Size paintSize = (radius != null) ? Size.fromRadius(radius!) : size;

    double _value = value;
    _value = _value.clamp(0, 0.25) * total;
    const double _start = 0.2;

    final double _offset = strokeWidth / 2;

    final Rect rect = Offset(_offset, _offset) &
        Size(paintSize.width - strokeWidth, paintSize.height - strokeWidth);

    final paint = Paint()
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..isAntiAlias = true;

    if (backgroundColor != Colors.transparent) {
      paint.color = backgroundColor;
      canvas.drawArc(rect, _start, total, false, paint);
    }

    if (_value > 0) {
      paint.shader = SweepGradient(
        colors: gradientColors,
        endAngle: _value,
        stops: [0, 0.6],
      ).createShader(rect);

      canvas.drawArc(rect, _start, _value, false, paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
