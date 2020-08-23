import 'package:flutter/material.dart';

class MagnifierPainter extends CustomPainter {
  final double strokeWidth;
  final Color color;
  const MagnifierPainter({this.strokeWidth = 5, this.color = Colors.black});

  @override
  void paint(Canvas canvas, Size size) {
    Paint circlePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..color = color;

    canvas.drawCircle(
        size.center(Offset(0, 0)), size.longestSide / 2, circlePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class CrosshairMagnifierPainter extends CustomPainter {
  final double strokeWidth;
  final Color color;
  const CrosshairMagnifierPainter(
      {this.strokeWidth = 5, this.color = Colors.black});

  @override
  void paint(Canvas canvas, Size size) {
    Paint circlePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..color = color;

    Paint crossHairPaint = Paint()..color = Colors.black;

    canvas.drawCircle(
        size.center(Offset(0, 0)), size.longestSide / 2, circlePaint);
    canvas.drawLine(size.topCenter(Offset(0, 0)),
        size.bottomCenter(Offset(0, 0)), crossHairPaint);
    canvas.drawLine(size.centerLeft(Offset(0, 0)),
        size.centerRight(Offset(0, 0)), crossHairPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
