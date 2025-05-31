import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:budget_wise/src/presentation/bloc/transaction_bloc/transaction_bloc.dart';
import 'package:budget_wise/src/presentation/bloc/transaction_bloc/transaction_event.dart';
import 'package:budget_wise/src/presentation/bloc/transaction_bloc/transaction_state.dart';
import 'package:budget_wise/src/domain/models/transaction_dto.dart';
import 'package:budget_wise/src/presentation/theme/system/app_colors.dart';
import 'package:intl/intl.dart';
// import 'package:fl_chart/fl_chart.dart'; // Uncomment if using fl_chart

enum TransactionViewType { date, week, month }

class TransactionTab extends StatefulWidget {
  const TransactionTab({super.key});

  @override
  State<TransactionTab> createState() => _TransactionTabState();
}

class _TransactionTabState extends State<TransactionTab> {
  TransactionViewType _viewType = TransactionViewType.date;
  DateTime _selectedDate = DateTime.now();
  DateTime _selectedWeek = DateTime.now(); // always the first day of week
  DateTime _selectedMonth = DateTime(DateTime.now().year, DateTime.now().month);

  @override
  void initState() {
    super.initState();
    _fetchTransactions();
  }

  void _fetchTransactions() {
    DateTime start, end;
    if (_viewType == TransactionViewType.date) {
      start =
          DateTime(_selectedDate.year, _selectedDate.month, _selectedDate.day);
      end = start.add(const Duration(days: 1));
    } else if (_viewType == TransactionViewType.week) {
      final weekday = _selectedWeek.weekday;
      start = _selectedWeek.subtract(Duration(days: weekday - 1));
      start = DateTime(start.year, start.month, start.day);
      end = start.add(const Duration(days: 7));
    } else {
      start = DateTime(_selectedMonth.year, _selectedMonth.month, 1);
      end = DateTime(_selectedMonth.year, _selectedMonth.month + 1, 1);
    }
    context
        .read<TransactionBloc>()
        .add(FetchTransactionsByDateRange(start, end));
  }

  void _onViewTypeChanged(TransactionViewType type) {
    setState(() {
      _viewType = type;
    });
    _fetchTransactions();
  }

  void _onDateChipSelected(DateTime date) {
    setState(() {
      _selectedDate = date;
    });
    _fetchTransactions();
  }

  Future<void> _pickDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });
      _fetchTransactions();
    }
  }

  void _onPrevWeek() {
    setState(() {
      _selectedWeek = _selectedWeek.subtract(const Duration(days: 7));
    });
    _fetchTransactions();
  }

  void _onNextWeek() {
    setState(() {
      _selectedWeek = _selectedWeek.add(const Duration(days: 7));
    });
    _fetchTransactions();
  }

  Future<void> _pickWeek(BuildContext context) async {
    // Simple: use date picker, then snap to week start
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedWeek,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      final weekday = picked.weekday;
      final weekStart = picked.subtract(Duration(days: weekday - 1));
      setState(() {
        _selectedWeek = weekStart;
      });
      _fetchTransactions();
    }
  }

  void _onPrevMonth() {
    setState(() {
      _selectedMonth = DateTime(_selectedMonth.year, _selectedMonth.month - 1);
    });
    _fetchTransactions();
  }

  void _onNextMonth() {
    setState(() {
      _selectedMonth = DateTime(_selectedMonth.year, _selectedMonth.month + 1);
    });
    _fetchTransactions();
  }

  Future<void> _pickMonth(BuildContext context) async {
    // Use date picker, then snap to first of month
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedMonth,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      helpText: 'Select month',
    );
    if (picked != null) {
      setState(() {
        _selectedMonth = DateTime(picked.year, picked.month);
      });
      _fetchTransactions();
    }
  }

  Map<String, List<TransactionDto>> _groupTransactions(
      List<TransactionDto> txs) {
    if (_viewType == TransactionViewType.date) {
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

  Widget _buildViewTypeBar(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildViewTypeButton(context, TransactionViewType.date, 'By Date'),
          const SizedBox(width: 8),
          _buildViewTypeButton(context, TransactionViewType.week, 'By Week'),
          const SizedBox(width: 8),
          _buildViewTypeButton(context, TransactionViewType.month, 'By Month'),
        ],
      ),
    );
  }

  Widget _buildViewTypeButton(
      BuildContext context, TransactionViewType type, String label) {
    final isSelected = _viewType == type;
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
        onPressed: () => _onViewTypeChanged(type),
        child: Text(label, style: Theme.of(context).textTheme.labelLarge),
      ),
    );
  }

  Widget _buildSecondRow(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    if (_viewType == TransactionViewType.date) {
      final today = DateTime.now();
      final yesterday = today.subtract(const Duration(days: 1));
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              ChoiceChip(
                label: Text(
                  'Yesterday',
                  style: TextStyle(
                    fontWeight: _selectedDate.year == yesterday.year &&
                            _selectedDate.month == yesterday.month &&
                            _selectedDate.day == yesterday.day
                        ? FontWeight.bold
                        : FontWeight.normal,
                    color: _selectedDate.year == yesterday.year &&
                            _selectedDate.month == yesterday.month &&
                            _selectedDate.day == yesterday.day
                        ? Colors.white
                        : Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                selected: _selectedDate.year == yesterday.year &&
                    _selectedDate.month == yesterday.month &&
                    _selectedDate.day == yesterday.day,
                selectedColor: AppColors.primaryDark,
                backgroundColor: Colors.transparent,
                onSelected: (_) => _onDateChipSelected(yesterday),
              ),
              const SizedBox(width: 8),
              ChoiceChip(
                label: Text(
                  'Today',
                  style: TextStyle(
                    fontWeight: _selectedDate.year == today.year &&
                            _selectedDate.month == today.month &&
                            _selectedDate.day == today.day
                        ? FontWeight.bold
                        : FontWeight.normal,
                    color: _selectedDate.year == today.year &&
                            _selectedDate.month == today.month &&
                            _selectedDate.day == today.day
                        ? Colors.white
                        : Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                selected: _selectedDate.year == today.year &&
                    _selectedDate.month == today.month &&
                    _selectedDate.day == today.day,
                selectedColor: AppColors.primaryDark,
                backgroundColor: Colors.transparent,
                onSelected: (_) => _onDateChipSelected(today),
              ),
              const SizedBox(width: 8),
              OutlinedButton.icon(
                style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  side: BorderSide(color: colorScheme.primary),
                ),
                icon: const Icon(Icons.calendar_today, size: 18),
                label: Text(DateFormat('yyyy-MM-dd').format(_selectedDate),
                    style: Theme.of(context).textTheme.bodySmall),
                onPressed: () => _pickDate(context),
              ),
            ],
          ),
        ),
      );
    } else if (_viewType == TransactionViewType.week) {
      final weekStart =
          _selectedWeek.subtract(Duration(days: _selectedWeek.weekday - 1));
      final weekEnd = weekStart.add(const Duration(days: 6));
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              IconButton(
                icon: const Icon(Icons.chevron_left),
                onPressed: _onPrevWeek,
              ),
              Text(
                '${DateFormat('MMM d').format(weekStart)} - ${DateFormat('MMM d, yyyy').format(weekEnd)}',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              IconButton(
                icon: const Icon(Icons.chevron_right),
                onPressed: _onNextWeek,
              ),
              const SizedBox(width: 8),
              OutlinedButton.icon(
                style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  side: BorderSide(color: colorScheme.primary),
                ),
                icon: const Icon(Icons.calendar_today, size: 18),
                label: const Text('Pick Week'),
                onPressed: () => _pickWeek(context),
              ),
            ],
          ),
        ),
      );
    } else {
      // Month
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              IconButton(
                icon: const Icon(Icons.chevron_left),
                onPressed: _onPrevMonth,
              ),
              Text(
                DateFormat('MMMM yyyy').format(_selectedMonth),
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              IconButton(
                icon: const Icon(Icons.chevron_right),
                onPressed: _onNextMonth,
              ),
              const SizedBox(width: 8),
              OutlinedButton.icon(
                style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  side: BorderSide(color: colorScheme.primary),
                ),
                icon: const Icon(Icons.calendar_today, size: 18),
                label: const Text('Pick Month'),
                onPressed: () => _pickMonth(context),
              ),
            ],
          ),
        ),
      );
    }
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
                    _viewType == TransactionViewType.date
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
                _viewType == TransactionViewType.date
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
                    _buildViewTypeBar(context),
                    _buildSecondRow(context),
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
