import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:budget_wise/data/models/transaction_dto.dart';
import 'package:budget_wise/app_config/theme/system/app_colors.dart';

class TransactionGraph extends StatelessWidget {
  final List<TransactionDto> txs;
  final dynamic viewType;
  const TransactionGraph(
      {required this.txs, required this.viewType, super.key});

  Map<String, double> _groupedTotals() {
    if (viewType.toString() == 'TransactionViewType.date') {
      final Map<String, double> map = {};
      for (var hour = 0; hour < 24; hour++) {
        final total = txs
            .where((t) => t.transactionDate.hour == hour)
            .fold(0.0, (sum, t) => sum + t.amount);
        if (total > 0) {
          map['${hour.toString().padLeft(2, '0')}:00'] = total;
        }
      }
      return map;
    } else {
      final formatter = DateFormat('yyyy-MM-dd');
      final Map<String, double> map = {};
      for (final tx in txs) {
        final key = formatter.format(tx.transactionDate);
        map[key] = (map[key] ?? 0) + tx.amount;
      }
      return map;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (txs.isEmpty) {
      return const SizedBox(height: 120);
    }
    final grouped = _groupedTotals();
    final keys = grouped.keys.toList();
    final values = grouped.values.toList();
    final maxVal =
        values.isNotEmpty ? values.reduce((a, b) => a > b ? a : b) : 1.0;
    return SizedBox(
      height: 120,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          for (int i = 0; i < keys.length; i++)
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    height: 80 * (values[i] / (maxVal == 0 ? 1 : maxVal)),
                    width: 16,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    viewType.toString() == 'TransactionViewType.date'
                        ? keys[i].substring(0, 2)
                        : keys[i].substring(8, 10),
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
