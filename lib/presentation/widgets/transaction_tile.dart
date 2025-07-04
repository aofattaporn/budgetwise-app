import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:budget_wise/data/models/transaction_dto.dart';
import 'package:budget_wise/app_config/theme/system/app_colors.dart';

class TransactionTile extends StatelessWidget {
  final TransactionDto tx;
  const TransactionTile({required this.tx, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Icon(
          tx.type == 'expense' ? Icons.arrow_upward : Icons.arrow_downward,
          color: tx.type == 'expense' ? AppColors.error : AppColors.primary,
        ),
        title: Text(tx.name, style: Theme.of(context).textTheme.bodyLarge),
        subtitle: Text(DateFormat('HH:mm').format(tx.transactionDate)),
        trailing: Text(
          (tx.type == 'expense' ? '-' : '+') + tx.amount.toStringAsFixed(2),
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color:
                    tx.type == 'expense' ? AppColors.error : AppColors.primary,
                fontWeight: FontWeight.bold,
              ),
        ),
      ),
    );
  }
}
