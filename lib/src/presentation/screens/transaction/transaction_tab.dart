import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:budget_wise/src/presentation/bloc/transaction_bloc/transaction_bloc.dart';
import 'package:budget_wise/src/presentation/bloc/transaction_bloc/transaction_event.dart';
import 'package:budget_wise/src/presentation/bloc/transaction_bloc/transaction_state.dart';
import 'package:budget_wise/features/transaction/data/models/transaction_dto.dart';
import 'package:intl/intl.dart';
import 'component/view_type_bar.dart';
import 'component/second_row.dart';
import 'component/transaction_graph.dart';
import 'component/grouped_transaction_list.dart';
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
      return {
        for (var hour = 0; hour < 24; hour++)
          if (txs.any((t) => t.transactionDate.hour == hour))
            '${hour.toString().padLeft(2, '0')}:00':
                txs.where((t) => t.transactionDate.hour == hour).toList(),
      };
    } else {
      final formatter = DateFormat('yyyy-MM-dd');
      final Map<String, List<TransactionDto>> grouped = {};
      for (final tx in txs) {
        final key = formatter.format(tx.transactionDate);
        grouped.putIfAbsent(key, () => []).add(tx);
      }
      return grouped;
    }
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
                    ViewTypeBar(
                      viewType: _viewType,
                      onChanged: _onViewTypeChanged,
                    ),
                    SecondRow(
                      viewType: _viewType,
                      selectedDate: _selectedDate,
                      selectedWeek: _selectedWeek,
                      selectedMonth: _selectedMonth,
                      onDateChipSelected: _onDateChipSelected,
                      onPickDate: _pickDate,
                      onPrevWeek: _onPrevWeek,
                      onNextWeek: _onNextWeek,
                      onPickWeek: _pickWeek,
                      onPrevMonth: _onPrevMonth,
                      onNextMonth: _onNextMonth,
                      onPickMonth: _pickMonth,
                    ),
                    TransactionGraph(
                      txs: txs,
                      viewType: _viewType,
                    ),
                    const SizedBox(height: 8),
                    GroupedTransactionList(
                      grouped: grouped,
                      viewType: _viewType,
                    ),
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
