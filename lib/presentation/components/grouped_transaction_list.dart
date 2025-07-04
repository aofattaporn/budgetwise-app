import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:budget_wise/data/models/transaction_dto.dart';
import '../widgets/transaction_tile.dart';

class GroupedTransactionList extends StatelessWidget {
  final Map<String, List<TransactionDto>> grouped;
  final dynamic viewType;
  const GroupedTransactionList(
      {required this.grouped, required this.viewType, super.key});

  @override
  Widget build(BuildContext context) {
    if (grouped.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 48),
          child: Text('No transactions found',
              style: Theme.of(context).textTheme.bodyLarge),
        ),
      );
    }
    final keys = grouped.keys.toList()..sort((a, b) => b.compareTo(a));
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: keys.length,
      itemBuilder: (context, i) {
        final groupKey = keys[i];
        final txs = grouped[groupKey]!;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
              child: Text(
                viewType.toString() == 'TransactionViewType.date'
                    ? groupKey
                    : DateFormat('EEE, MMM d').format(DateTime.parse(groupKey)),
                style: Theme.of(context)
                    .textTheme
                    .titleSmall
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            ...txs.map((tx) => TransactionTile(tx: tx)),
          ],
        );
      },
    );
  }
}
