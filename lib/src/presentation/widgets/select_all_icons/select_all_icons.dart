import 'package:budget_wise/src/presentation/constant/icons.dart';
import 'package:flutter/material.dart';

class SelectAllIcons extends StatelessWidget {
  final Function(int) onIconSelected; // Add this callback

  const SelectAllIcons({
    required this.onIconSelected,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      clipBehavior: Clip.none,
      scrollDirection: Axis.horizontal,
      child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
        for (int index = 0; index < IconConstants.icons.length; index++)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () => onIconSelected(index),
              child: Container(
                height: 42,
                width: 42,
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(240, 240, 240, 1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(IconConstants.icons[index],
                    color: Colors.grey, size: 24),
              ),
            ),
          ),
      ]),
    );
  }
}
