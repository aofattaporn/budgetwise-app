import 'package:budget_wise/src/presentation/theme/system/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:budget_wise/src/presentation/bloc/account_bloc/account_bloc.dart';
import 'package:budget_wise/src/presentation/bloc/account_bloc/account_state.dart';
import 'package:budget_wise/src/presentation/bloc/account_bloc/account_event.dart';
import 'package:budget_wise/src/presentation/bloc/plan_all_bloc/plan_selector_bloc.dart';
import 'package:budget_wise/src/presentation/bloc/plan_all_bloc/plan_selector_state.dart';
import 'package:budget_wise/src/presentation/bloc/plan_all_bloc/plan_selector_event.dart';
import 'package:budget_wise/src/presentation/widgets/common_widget.dart';

class CreateTransactionSheet extends StatefulWidget {
  const CreateTransactionSheet({super.key});

  @override
  State<CreateTransactionSheet> createState() => _CreateTransactionSheetState();
}

class _CreateTransactionSheetState extends State<CreateTransactionSheet> {
  int _typeIndex = 0; // 0 = Expense, 1 = Saving
  String? _selectedAccountId;
  String? _selectedPlanId;
  final _amountController = TextEditingController();
  final _noteController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  bool _isSubmitting = false;

  @override
  void dispose() {
    _amountController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  void _reloadAccountsIfNeeded(BuildContext context, AccountState state) {
    if (state is! AccountLoaded || state.accounts.isEmpty) {
      context.read<AccountBloc>().add(FetchAllAccounts());
    }
  }

  void _reloadPlansIfNeeded(BuildContext context, PlanSelectorState state) {
    if (state is! AllPlanLoaded || state.planList.isEmpty) {
      context.read<PlanSelectorBloc>().add(FetchAllMonthPlanEvent());
    }
  }

  void _showDatePicker(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: Theme.of(context).colorScheme.copyWith(
                  primary: Theme.of(context).colorScheme.primary,
                ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) setState(() => _selectedDate = picked);
  }

  void _submit() {
    final amount = double.tryParse(_amountController.text.trim()) ?? 0.0;
    if (_selectedAccountId == null || amount <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text('Please select an account and enter a valid amount.',
                style: Theme.of(context).textTheme.bodyMedium)),
      );
      return;
    }
    setState(() => _isSubmitting = true);

    // TODO: Dispatch create transaction event here

    // Simulate success
    Future.delayed(const Duration(seconds: 1), () {
      setState(() => _isSubmitting = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            backgroundColor: AppColors.primary,
            content: Text('Transaction created!',
                style: Theme.of(context).textTheme.bodyMedium)),
      );
      Navigator.of(context).pop();
    });
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
          color: colorScheme.background,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // iOS-style drag handle
                Center(
                  child: Container(
                    width: 40,
                    height: 5,
                    margin: const EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                ),
                Center(
                  child: Text(
                    'Create Transaction',
                    style: textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: colorScheme.primary,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                // iOS-style segmented control
                Center(
                  child: CupertinoSegmentedControl<int>(
                    children: const {
                      0: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Text('Expense'),
                      ),
                      1: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Text('Saving'),
                      ),
                    },
                    groupValue: _typeIndex,
                    onValueChanged: (i) => setState(() => _typeIndex = i),
                    selectedColor: colorScheme.primary,
                    borderColor: colorScheme.primary,
                    unselectedColor: colorScheme.surface,
                  ),
                ),
                const SizedBox(height: 24),
                BlocBuilder<AccountBloc, AccountState>(
                  builder: (context, state) {
                    _reloadAccountsIfNeeded(context, state);
                    if (state is AccountLoading) {
                      return const LinearProgressIndicator();
                    }
                    final accounts =
                        state is AccountLoaded ? state.accounts : [];
                    return DropdownButtonFormField<String>(
                      value: _selectedAccountId,
                      decoration: InputDecoration(
                        labelText: 'Account',
                        labelStyle: textTheme.bodyMedium,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                        filled: true,
                        fillColor: colorScheme.surfaceVariant,
                      ),
                      items: accounts
                          .map((a) => DropdownMenuItem<String>(
                                value: a.id,
                                child:
                                    Text(a.name, style: textTheme.bodyMedium),
                              ))
                          .toList(),
                      onChanged: (v) => setState(() => _selectedAccountId = v),
                    );
                  },
                ),
                const SizedBox(height: 20),
                BlocBuilder<PlanSelectorBloc, PlanSelectorState>(
                  builder: (context, state) {
                    _reloadPlansIfNeeded(context, state);
                    final plans = (state is AllPlanLoaded)
                        ? state.planList.where((p) => !p.isArchived).toList()
                        : [];
                    return DropdownButtonFormField<String>(
                      value: _selectedPlanId,
                      decoration: InputDecoration(
                        labelText: 'Plan',
                        labelStyle: textTheme.bodyMedium,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                        filled: true,
                        fillColor: colorScheme.surfaceVariant,
                      ),
                      items: plans
                          .map((p) => DropdownMenuItem<String>(
                                value: p.id,
                                child:
                                    Text(p.name, style: textTheme.bodyMedium),
                              ))
                          .toList(),
                      onChanged: (v) => setState(() => _selectedPlanId = v),
                    );
                  },
                ),
                const SizedBox(height: 20),
                CommonWidget.textField(
                  textEditingController: _amountController,
                  placeholder: 'Amount',
                  isNumberOnly: true,
                ),
                const SizedBox(height: 20),
                CommonWidget.textField(
                  textEditingController: _noteController,
                  placeholder: 'Note (optional)',
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Text('Date:', style: textTheme.bodyMedium),
                    const SizedBox(width: 8),
                    Text(
                      '${_selectedDate.year}-${_selectedDate.month.toString().padLeft(2, '0')}-${_selectedDate.day.toString().padLeft(2, '0')}',
                      style: textTheme.bodyMedium
                          ?.copyWith(color: colorScheme.primary),
                    ),
                    IconButton(
                      icon: const Icon(Icons.calendar_today),
                      onPressed: () => _showDatePicker(context),
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                SizedBox(
                  width: double.infinity,
                  child: CommonWidget.commonElevatedBtn(
                    label: 'Create Transaction',
                    onPressed: _isSubmitting ? () {} : _submit,
                    isDisable: _isSubmitting,
                  ),
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
