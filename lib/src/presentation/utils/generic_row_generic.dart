import 'package:flutter/material.dart';

class GenericRow extends StatelessWidget {
  final List<Widget> genericWidgets;
  final double gapSize;

  const GenericRow({
    super.key,
    required this.genericWidgets,
    required this.gapSize,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        for (int index = 0; index < genericWidgets.length; index++) ...[
          Expanded(child: genericWidgets[index]),
          if (index < genericWidgets.length - 1) SizedBox(width: gapSize),
        ],
      ],
    );
  }
}
