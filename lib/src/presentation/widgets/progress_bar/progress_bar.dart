import 'package:flutter/material.dart';

class ProgressBar extends StatelessWidget {
  final bool isFullSize;
  final double progress; // Value between 0 and 1

  const ProgressBar({
    required this.isFullSize,
    required this.progress,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // constraints.maxWidth gives the width of the parent
        double parentWidth = constraints.maxWidth;

        return Container(
          decoration: BoxDecoration(
            color: const Color.fromRGBO(240, 240, 240, 1),
            borderRadius: BorderRadius.circular(10),
          ),
          height: isFullSize ? 12 : 8,
          width: parentWidth, // Take full width of the parent
          child: Stack(
            children: [
              // Progress indicator (inside the parent)
              Container(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment(0.8, 1),
                    colors: [
                      Color.fromRGBO(147, 121, 224, 1),
                      Color.fromRGBO(174, 120, 214, 1),
                      Color.fromRGBO(215, 128, 225, 1),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                // Width of the progress bar is based on the parent's width and the progress value
                width: parentWidth * progress,
              ),
            ],
          ),
        );
      },
    );
  }
}
