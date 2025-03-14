// painter - multisegment
import 'package:flutter/material.dart';

class MultiSegmentPainter extends CustomPainter {
  final List<double> values;
  final List<Color> colors;
  final double strokeWidth;
  final double gap;

  MultiSegmentPainter(this.values, this.colors, this.strokeWidth, this.gap);

  @override
  void paint(Canvas canvas, Size size) {
    Offset center = Offset(size.width / 2, size.height / 2);
    double radius = (size.width / 2) -
        (strokeWidth / 2); // Calculate the radius of the circle
    // ignore: unused_local_variable

    print(values);
    double totalProgress = values.fold(0, (sum, value) => sum + value);

    // St p 1: Draw the background circle
    Paint backgroundPaint = Paint()
      // ignore: deprecated_member_use
      ..color = Colors.grey.withOpacity(0.2)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -90 * (3.1415926535 / 180), // Start at 12 o'clock (-90°)
      360 * (3.1415926535 / 180), // Full circle
      false,
      backgroundPaint,
    );

    // Step 2: Draw progress segments with gaps
    double startAngle =
        -90 * (3.1415926535 / 180); // Start from 12 o'clock (-90°)
// Total angle for the progress

    // Iterate through each segment and draw it
    for (int i = 0; i < values.length; i++) {
      Paint segmentPaint = Paint()
        ..color = colors[i]
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth
        ..strokeCap = StrokeCap.round;

      double sweepAngle = values[i] *
          360 *
          (3.1415926535 / 180); // Convert segment value to angle

      if (sweepAngle > 0) {
        // Draw the segment (arc) with the calculated startAngle and sweepAngle
        canvas.drawArc(
          Rect.fromCircle(center: center, radius: radius),
          startAngle,
          sweepAngle,
          false,
          segmentPaint,
        );
      }

      // Add a gap between segments (but ensure that we don't overflow beyond 360°)
      double gapAngle =
          gap * 360 * (3.1415926535 / 180); // Convert gap to angle
      startAngle += sweepAngle +
          gapAngle; // Update start angle by segment angle + gap angle

      // Ensure we don't overflow beyond 360° for the last segment
      if (startAngle >= 2 * 3.1415926535) {
        startAngle -=
            2 * 3.1415926535; // If it exceeds 360°, wrap around to start again
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
