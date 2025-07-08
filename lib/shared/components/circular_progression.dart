import 'package:budget_wise/shared/widgets/progression/multi_segment_painter.dart';
import 'package:flutter/material.dart';

class CircularProgression extends StatelessWidget {
  final double size;
  final List<double> segmentUsages;
  final List<Color> segmentColors;
  const CircularProgression({
    super.key,
    required this.size,
    required this.segmentUsages,
    required this.segmentColors,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
        size: Size(size, size),
        painter: MultiSegmentPainter(segmentUsages, segmentColors, 10, 0));
  }
}
