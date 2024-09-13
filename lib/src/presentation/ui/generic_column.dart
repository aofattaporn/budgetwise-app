import 'package:flutter/material.dart';

class GenericColumn extends StatelessWidget {
  final List<Widget> genericWidgets;
  final double gapSize;

  const GenericColumn({
    super.key,
    required this.genericWidgets,
    required this.gapSize,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        for (int index = 0; index < genericWidgets.length; index++) ...[
          // Expanded(child: genericWidgets[index]),
          genericWidgets[index],
          if (index < genericWidgets.length - 1) SizedBox(height: gapSize),
        ],
      ],
    );
  }
}
