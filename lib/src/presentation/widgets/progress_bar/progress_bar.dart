import 'package:flutter/material.dart';

class ProgressBar extends StatelessWidget {
  final double progress; // Value between 0 and 1

  const ProgressBar({
    required this.progress,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IntrinsicWidth(

        // liit progress 100%
        child: Container(
      decoration: BoxDecoration(
        color: const Color.fromRGBO(240, 240, 240, 1),
        borderRadius: BorderRadius.circular(10),
      ),
      height: 12,
      width: MediaQuery.sizeOf(context).width,

      // inprogess gate
      child: Stack(
        children: [
          // Progress indicator
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: const Alignment(0.8, 1),
                  colors: [
                    Color.fromRGBO(147, 121, 224, 1),
                    Color.fromRGBO(174, 120, 214, 1),
                    Color.fromRGBO(215, 128, 225, 1),
                  ]),
              borderRadius: BorderRadius.circular(10),
            ),
            width: MediaQuery.sizeOf(context).width *
                progress, // Adjust width based on progress
          ),
        ],
      ),
    ));
  }
}
