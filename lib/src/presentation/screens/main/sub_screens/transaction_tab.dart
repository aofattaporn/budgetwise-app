import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:budget_wise/src/presentation/bloc/transaction_bloc/transaction_bloc.dart';
import 'package:budget_wise/src/presentation/bloc/transaction_bloc/transaction_event.dart';
import 'package:budget_wise/src/presentation/bloc/transaction_bloc/transaction_state.dart';
import 'package:budget_wise/src/domain/models/transaction_dto.dart';
import 'package:budget_wise/src/presentation/widgets/common_widget.dart';
import 'package:budget_wise/src/presentation/theme/system/app_colors.dart';
import 'package:intl/intl.dart';
// import 'package:fl_chart/fl_chart.dart'; // Uncomment if using fl_chart

enum TransactionFilter { today, week, month }

class TransactionTab extends StatefulWidget {
  const TransactionTab({super.key});

  @override
  State<TransactionTab> createState() => _TransactionTabState();
}

class _TransactionTabState extends State<TransactionTab> {
  TransactionFilter _filter = TransactionFilter.today;
  DateTime _now = DateTime.now();

  @override
  void initState() {
    super.initState();
    _fetchTransactions();
  }

  void _fetchTransactions() {
    DateTime start, end;
    if (_filter == TransactionFilter.today) {
      start = DateTime(_now.year, _now.month, _now.day);
      end = start.add(const Duration(days: 1));
    } else if (_filter == TransactionFilter.week) {
      final weekday = _now.weekday;
      start = _now.subtract(Duration(days: weekday - 1));
      start = DateTime(start.year, start.month, start.day);
      end = start.add(const Duration(days: 7));
    } else {
      start = DateTime(_now.year, _now.month, 1);
      end = DateTime(_now.year, _now.month + 1, 1);
    }
    context
        .read<TransactionBloc>()
        .add(FetchTransactionsByDateRange(start, end));
  }

  void _onFilterChanged(TransactionFilter filter) {
    setState(() {
      _filter = filter;
    });
    _fetchTransactions();
  }

  Map<String, List<TransactionDto>> _groupTransactions(
      List<TransactionDto> txs) {
    if (_filter == TransactionFilter.today) {
      // Group by hour
      return {
        for (var hour = 0; hour < 24; hour++)
          if (txs.any((t) => t.transactionDate.hour == hour))
            '${hour.toString().padLeft(2, '0')}:00':
                txs.where((t) => t.transactionDate.hour == hour).toList(),
      };
    } else {
      // Group by day
      final formatter = DateFormat('yyyy-MM-dd');
      final Map<String, List<TransactionDto>> grouped = {};
      for (final tx in txs) {
        final key = formatter.format(tx.transactionDate);
        grouped.putIfAbsent(key, () => []).add(tx);
      }
      return grouped;
    }
  }

  Widget _buildFilterBar(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildFilterButton(context, TransactionFilter.today, 'Today'),
          const SizedBox(width: 8),
          _buildFilterButton(context, TransactionFilter.week, 'Week'),
          const SizedBox(width: 8),
          _buildFilterButton(context, TransactionFilter.month, 'Month'),
        ],
      ),
    );
  }

  Widget _buildFilterButton(
      BuildContext context, TransactionFilter filter, String label) {
    final isSelected = _filter == filter;
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
        onPressed: () => _onFilterChanged(filter),
        child: Text(label, style: Theme.of(context).textTheme.labelLarge),
      ),
    );
  }

  Widget _buildGraph(List<TransactionDto> txs) {
    // Placeholder for graph. Replace with fl_chart or similar if available.
    if (txs.isEmpty) {
      return const SizedBox(height: 120);
    }
    // Example: show total per group as a bar
    final grouped = _groupTransactions(txs);
    final keys = grouped.keys.toList();
    final values = grouped.values
        .map((list) => list.fold(0.0, (sum, t) => sum + t.amount))
        .toList();
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
                    _filter == TransactionFilter.today
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

  Widget _buildGroupedList(Map<String, List<TransactionDto>> grouped) {
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
                _filter == TransactionFilter.today
                    ? '$groupKey'
                    : DateFormat('EEE, MMM d').format(DateTime.parse(groupKey)),
                style: Theme.of(context)
                    .textTheme
                    .titleSmall
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            ...txs.map((tx) => _buildTransactionTile(tx)).toList(),
          ],
        );
      },
    );
  }

  Widget _buildTransactionTile(TransactionDto tx) {
    final colorScheme = Theme.of(context).colorScheme;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: BlocBuilder<TransactionBloc, TransactionState>(
          builder: (context, state) {
            if (state is TransactionLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is TransactionLoaded) {
              final txs = state.transactions;
              final grouped = _groupTransactions(txs);
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildFilterBar(context),
                    _buildGraph(txs),
                    const SizedBox(height: 8),
                    _buildGroupedList(grouped),
                  ],
                ),
              );
            }
            if (state is TransactionError) {
              return Center(child: Text(state.message));
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
