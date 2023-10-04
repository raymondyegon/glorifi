import 'package:flutter/material.dart';

class DrawDottedHorizontalLine extends CustomPainter {
  DrawDottedHorizontalLine(this.index) {
    _paint = Paint();
    _paint?.color = index <= 3
        ? Color(0xFF444E60).withOpacity(0.3)
        : index == 4
            ? Color(0xFF444E60).withOpacity(0.5)
            : Color(0xFF444E60).withOpacity(1); //dots color
    _paint?.strokeWidth = 1; //dots thickness
    _paint?.strokeCap = StrokeCap.square; //dots corner edges
  }

  Paint? _paint;
  final int index;

  @override
  void paint(Canvas canvas, Size size) {
    for (double i = -300; i < 300; i = i + 2) {
      if (i % 3 == 0)
        canvas.drawLine(Offset(i, 0.0), Offset(i + 4, 0.0), _paint!);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
