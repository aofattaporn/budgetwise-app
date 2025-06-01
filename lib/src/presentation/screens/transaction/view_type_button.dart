import 'package:flutter/material.dart';
import 'transaction_tab.dart';

class ViewTypeButton extends StatelessWidget {
  final TransactionViewType type;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  const ViewTypeButton(
      {required this.type,
      required this.label,
      required this.isSelected,
      required this.onTap,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Expanded(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor:
              isSelected ? colorScheme.primary : colorScheme.surfaceVariant,
          foregroundColor:
              isSelected ? colorScheme.onPrimary : colorScheme.onSurface,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          elevation: isSelected ? 2 : 0,
        ),
        onPressed: onTap,
        child: Text(label, style: Theme.of(context).textTheme.labelLarge),
      ),
    );
  }
}
