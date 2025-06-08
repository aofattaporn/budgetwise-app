import 'package:flutter/material.dart';

class TypeButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isDisable;
  final VoidCallback onTap;

  const TypeButton(
      {super.key,
      required this.icon,
      required this.label,
      required this.onTap,
      this.isDisable = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: isDisable ? null : onTap,
          borderRadius: BorderRadius.circular(32),
          child: CircleAvatar(
            radius: 32,
            backgroundColor:
                Theme.of(context).colorScheme.primary.withOpacity(0.1),
            child: Icon(
              icon,
              size: 32,
              color: isDisable
                  ? Theme.of(context).colorScheme.primary.withAlpha(60)
                  : Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }
}
