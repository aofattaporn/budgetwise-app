import 'package:budget_wise/src/presentation/widgets/icon/box_icon.dart';
import 'package:flutter/material.dart';

class LabeledIconRow extends StatelessWidget {
  final String label;
  final VoidCallback onSelectIcon;

  const LabeledIconRow({
    super.key,
    required this.label,
    required this.onSelectIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Flexible(
          flex: 3,
          child: Center(
            child: BoxedIcon(iconData: Icons.home_outlined),
          ),
        ),
        const SizedBox(width: 16),
        Flexible(
          flex: 7,
          child: Align(
            alignment: Alignment.centerRight,
            child: TextButton.icon(
              onPressed: onSelectIcon,
              icon: const Icon(Icons.arrow_forward_outlined),
              label: const Text('Select Icon'),
              style: TextButton.styleFrom(
                foregroundColor: Colors.black,
                textStyle: const TextStyle(fontSize: 14),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
