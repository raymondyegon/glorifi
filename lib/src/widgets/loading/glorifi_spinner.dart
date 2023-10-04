import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:glorifi/src/utils/glorifi_colors.dart';

class GlorifiSpinner extends StatefulWidget {
  const GlorifiSpinner({
    Key? key,
    this.size = 75,
  }) : super(key: key);

  final double size;

  @override
  State<GlorifiSpinner> createState() => _GlorifiSpinnerState();
}

class _GlorifiSpinnerState extends State<GlorifiSpinner>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: 800),
    vsync: this,
  )..repeat(reverse: false);

  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.linear,
  );

  @override
  void initState() {
    _controller.repeat();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      double _size = widget.size;
      if (constraints.maxWidth < widget.size ||
          constraints.maxHeight < widget.size) {
        if (constraints.maxWidth < constraints.maxHeight) {
          _size = constraints.maxWidth;
        } else {
          _size = constraints.maxHeight;
        }
      }

      return AnimatedBuilder(
          animation: _animation,
          builder: (BuildContext context, Widget? child) {
            return child!;
          },
          child: Container(
            width: _size,
            height: _size,
            child: Center(
              child: RotationTransition(
                turns: Tween(begin: 0.0, end: 1.0).animate(_animation),
                child: Stack(
                  children: [
                    CustomPaint(
                      painter: QuarterCirclePainter(strokeWidth: _size / 6.81),
                      size: Size(_size, _size),
                    )
                  ],
                ),
              ),
            ),
          ));
    });
  }
}

class QuarterCirclePainter extends CustomPainter {
  const QuarterCirclePainter({required this.strokeWidth});

  final double strokeWidth;

  @override
  void paint(Canvas canvas, Size size) {
    Paint circlePaint = Paint()
      ..color = GlorifiColors.cornflowerBlue
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;
    canvas.drawCircle(
        Offset(size.width / 2, size.height / 2), size.width / 2, circlePaint);

    Paint arcPaint = Paint()
      ..color = GlorifiColors.red
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..shader = ui.Gradient.linear(
        Offset(size.width / 2, size.width / 2),
        Offset(size.width, size.width / 3),
        [
          Colors.transparent,
          GlorifiColors.lightBlue,
        ],
      );
    canvas.drawArc(Offset(0, 0) & Size(size.width, size.height), 0,
        90 * (math.pi / -180), false, arcPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
