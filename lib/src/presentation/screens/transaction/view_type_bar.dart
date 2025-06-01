import 'package:flutter/material.dart';
import 'view_type_button.dart';
import 'transaction_tab.dart';

class ViewTypeBar extends StatelessWidget {
  final TransactionViewType viewType;
  final ValueChanged<TransactionViewType> onChanged;
  const ViewTypeBar({required this.viewType, required this.onChanged, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ViewTypeButton(
            type: TransactionViewType.date,
            label: 'By Date',
            isSelected: viewType == TransactionViewType.date,
            onTap: () => onChanged(TransactionViewType.date),
          ),
          const SizedBox(width: 8),
          ViewTypeButton(
            type: TransactionViewType.week,
            label: 'By Week',
            isSelected: viewType == TransactionViewType.week,
            onTap: () => onChanged(TransactionViewType.week),
          ),
          const SizedBox(width: 8),
          ViewTypeButton(
            type: TransactionViewType.month,
            label: 'By Month',
            isSelected: viewType == TransactionViewType.month,
            onTap: () => onChanged(TransactionViewType.month),
          ),
        ],
      ),
    );
  }
}
