import 'package:flutter/material.dart';

class MultiSegmentPainter extends CustomPainter {
  final List<double> values; // Values in percentage (0 to 100)
  final List<Color> colors;
  final double strokeWidth;
  final double gap;

  MultiSegmentPainter(this.values, this.colors, this.strokeWidth, this.gap);

  @override
  void paint(Canvas canvas, Size size) {
    Offset center = Offset(size.width / 2, size.height / 2);
    double radius = (size.width / 2) - (strokeWidth / 2);

    Paint backgroundPaint = Paint()
      ..color = Colors.grey.withOpacity(0.2)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -90 * (3.1415926535 / 180),
      360 * (3.1415926535 / 180),
      false,
      backgroundPaint,
    );

    double startAngle = -90 * (3.1415926535 / 180);

    double totalValue = values.fold(0, (sum, value) => sum + value);
    if (totalValue > 100) {
      print("Warning: Total values exceed 100%");
      return;
    }

    double totalGapAngle = (values.length - 1) * gap * (3.1415926535 / 180);
    double totalSweepAvailable = 2 * 3.1415926535 - totalGapAngle;

    for (int i = 0; i < values.length; i++) {
      Paint segmentPaint = Paint()
        ..color = colors[i]
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth
        ..strokeCap = StrokeCap.round;

      double sweepAngle = (values[i] / 100) * totalSweepAvailable;

      if (sweepAngle > 0) {
        canvas.drawArc(
          Rect.fromCircle(center: center, radius: radius),
          startAngle,
          sweepAngle,
          false,
          segmentPaint,
        );
      }

      startAngle += sweepAngle + (gap * (3.1415926535 / 180));
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
