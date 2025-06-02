import 'package:budget_wise/app_config/theme/system/app_colors.dart';
import 'package:budget_wise/features/transaction/presentation/sheets/select_transaction_type_screen.dart';
import 'package:budget_wise/shared/utils/user_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:budget_wise/features/account/presentation/bloc/account_bloc.dart';
import 'package:budget_wise/features/account/presentation/bloc/account_state.dart';
import 'package:budget_wise/features/account/presentation/bloc/account_event.dart';
import 'package:budget_wise/shared/widgets/common_widget.dart';
import 'package:budget_wise/features/transaction/presentation/bloc/transaction_bloc.dart';
import 'package:budget_wise/features/transaction/presentation/bloc/transaction_event.dart';
import 'package:budget_wise/features/transaction/presentation/bloc/transaction_state.dart';
import 'package:budget_wise/features/transaction/data/models/transaction_dto.dart';
import 'package:budget_wise/features/plan/presentation/bloc/current_plan_boc/current_plan_boc.dart';
import 'package:budget_wise/features/plan/presentation/bloc/current_plan_boc/current_plan_state.dart';
import 'package:budget_wise/features/plan/presentation/bloc/plan_item_bloc/plan_item_bloc.dart';
import 'package:budget_wise/features/plan/presentation/bloc/plan_item_bloc/plan_item_event.dart';
import 'package:budget_wise/features/plan/presentation/bloc/plan_item_bloc/plan_item_state.dart';

class ExpenseSubScreen extends StatefulWidget {
  final String type;
  final TransactionType transactionType;
  final VoidCallback onBack;

  const ExpenseSubScreen({
    super.key,
    required this.transactionType,
    required this.onBack,
    required this.type,
  });

  @override
  State<ExpenseSubScreen> createState() => _ExpenseSubScreenState();
}

class _ExpenseSubScreenState extends State<ExpenseSubScreen> {
  // Controllers and state
  final _nameController = TextEditingController();
  final _amountController = TextEditingController();
  final _noteController = TextEditingController();
  String? _selectedAccountId;
  String? _selectedPlanItemId;
  DateTime _selectedDate = DateTime.now();
  bool _isSubmitting = false;

  @override
  void dispose() {
    _nameController.dispose();
    _amountController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  // Helpers
  bool get isLoading => _isSubmitting;
  String get formattedDate =>
      '${_selectedDate.year}-${_selectedDate.month.toString().padLeft(2, '0')}-${_selectedDate.day.toString().padLeft(2, '0')}';

  void _reloadAccountsIfNeeded(BuildContext context, AccountState state) {
    if (state is! AccountLoaded || state.accounts.isEmpty) {
      context.read<AccountBloc>().add(FetchAllAccounts());
    }
  }

  void _reloadPlansItemIfNeeded(BuildContext context, PlanItemState state) {
    if (state is! PlanItemLoaded) {
      context.read<PlanItemBloc>().add(FetchAllActivePlanItems());
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
    final name = _nameController.text.trim();
    final amount = double.tryParse(_amountController.text.trim()) ?? 0.0;
    if (name.isEmpty || _selectedAccountId == null || amount <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(
                'Please enter a name, select an account, and enter a valid amount.',
                style: Theme.of(context).textTheme.bodyMedium)),
      );
      return;
    }
    setState(() => _isSubmitting = true);

    final transactionDto = TransactionDto(
      id: null,
      userId: UserUtil.aofUid(),
      planItemId: _selectedPlanItemId,
      accountId: _selectedAccountId!,
      amount: amount,
      type: widget.type,
      name: name,
      note: _noteController.text.trim(),
      transactionDate: _selectedDate,
      createdAt: null,
      updatedAt: null,
    );
    context.read<TransactionBloc>().add(CreateTransaction(transactionDto));
  }

  Widget _buildLoadingIndicator() {
    return const LinearProgressIndicator(
      backgroundColor: AppColors.border,
      color: AppColors.primary,
    );
  }

  Widget _buildAccountDropdown(BuildContext context, AccountState state,
      TextStyle? textStyle, Color fillColor) {
    _reloadAccountsIfNeeded(context, state);
    if (state is AccountLoading) {
      return _buildLoadingIndicator();
    }
    final accounts = state is AccountLoaded ? state.accounts : [];
    return DropdownButtonFormField<String>(
      value: _selectedAccountId,
      decoration: InputDecoration(
        labelText: 'Account',
        labelStyle: textStyle,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
        filled: true,
        fillColor: fillColor,
      ),
      items: accounts
          .map((a) => DropdownMenuItem<String>(
                value: a.id,
                child: Text(a.name, style: textStyle),
              ))
          .toList(),
      onChanged: (v) => setState(() => _selectedAccountId = v),
    );
  }

  Widget _buildPlanItemDropdown(BuildContext context, PlanItemState state,
      TextStyle? textStyle, Color fillColor) {
    _reloadPlansItemIfNeeded(context, state);

    if (state is PlanItemLoading) {
      return _buildLoadingIndicator();
    }
    final items = state is PlanItemLoaded ? state.items : [];
    return DropdownButtonFormField<String>(
      value: _selectedPlanItemId,
      decoration: InputDecoration(
        labelText: 'Plan Item',
        labelStyle: textStyle,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
        filled: true,
        fillColor: fillColor,
      ),
      items: items
          .map((item) => DropdownMenuItem<String>(
                value: item.id,
                child: Row(
                  children: [
                    if (item.iconName != null) Text(item.iconName!),
                    const SizedBox(width: 6),
                    Text(item.name, style: textStyle),
                  ],
                ),
              ))
          .toList(),
      onChanged: (v) => setState(() => _selectedPlanItemId = v),
    );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    final fillColor = colorScheme.surfaceVariant;
    final labelStyle = textTheme.bodyMedium;

    return BlocBuilder<TransactionBloc, TransactionState>(
      builder: (context, tState) {
        return BlocBuilder<CurrentPlanBloc, CurrentPlanState>(
          builder: (context, planState) {
            String? planId;
            if (planState is CurrentPlanLoaded) {
              planId = planState.plan.id;
            }
            // Fetch plan items when planId changes
            if (planId != null) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                context.read<PlanItemBloc>().add(FetchPlanItems(planId!));
              });
            }
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(context),
                  const SizedBox(height: 24),
                  // Transaction Name
                  CommonWidget.textField(
                    textEditingController: _nameController,
                    placeholder: 'Transaction Name',
                  ),
                  const SizedBox(height: 24),
                  BlocBuilder<AccountBloc, AccountState>(
                    builder: (context, state) => _buildAccountDropdown(
                        context, state, labelStyle, fillColor),
                  ),
                  const SizedBox(height: 20),
                  BlocBuilder<PlanItemBloc, PlanItemState>(
                    builder: (context, state) => _buildPlanItemDropdown(
                        context, state, labelStyle, fillColor),
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
                        formattedDate,
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
                      label: tState is TransactionLoading
                          ? 'Creating...'
                          : 'Create Transaction',
                      onPressed: _isSubmitting || tState is TransactionLoading
                          ? () {}
                          : _submit,
                      isDisable: _isSubmitting || tState is TransactionLoading,
                    ),
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      spacing: 16,
      children: [
        Text(
          'Add Expense',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const Icon(Icons.remove_circle_outline)
      ],
    );
  }
}
