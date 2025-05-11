import 'package:flutter/material.dart';

class CommonFloatingActionButton extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData icon;
  final ShapeBorder? shape;

  static const deaultShap = CircleBorder();

  const CommonFloatingActionButton({
    super.key,
    required this.onPressed,
    required this.icon,
    this.shape = deaultShap,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      shape: const CircleBorder(),
      backgroundColor: Theme.of(context).colorScheme.primary,
      child: Icon(
        icon,
        color: Theme.of(context).colorScheme.onPrimary,
      ),
    );
  }
}
