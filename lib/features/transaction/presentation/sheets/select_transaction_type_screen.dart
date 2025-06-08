import 'package:budget_wise/app_config/theme/system/app_colors.dart';
import 'package:budget_wise/features/transaction/presentation/sheets/expense_sub_screen.dart';
import 'package:budget_wise/features/transaction/presentation/sheets/saving_sub_screen.dart';
import 'package:budget_wise/features/transaction/presentation/sheets/transfer_sub_screen.dart';
import 'package:flutter/material.dart';
import 'package:budget_wise/shared/common/pagination_dots.dart';
import '../widgets/type_button.dart';

enum TransactionType { expense, saving, transfer }

class SelectTransactionTypeScreen extends StatefulWidget {
  const SelectTransactionTypeScreen({super.key});

  @override
  State<SelectTransactionTypeScreen> createState() =>
      _SelectTransactionTypeScreenState();
}

class _SelectTransactionTypeScreenState
    extends State<SelectTransactionTypeScreen> {
  int currentStep = 0;
  TransactionType? selectedType;

  void selectType(TransactionType type) {
    setState(() {
      selectedType = type;
      currentStep = 1;
    });
  }

  void goBack() {
    setState(() {
      currentStep = 0;
      selectedType = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget content;
    if (currentStep == 0) {
      content = Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('What type of transaction?',
              style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 32),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TypeButton(
                icon: Icons.remove_circle_outline,
                label: 'Expense',
                onTap: () => selectType(TransactionType.expense),
              ),
              TypeButton(
                isDisable: true,
                icon: Icons.savings_outlined,
                label: 'Saving',
                onTap: () => selectType(TransactionType.saving),
              ),
              TypeButton(
                isDisable: true,
                icon: Icons.compare_arrows_outlined,
                label: 'Transfer',
                onTap: () => selectType(TransactionType.transfer),
              ),
            ],
          ),
        ],
      );
    } else if (selectedType == TransactionType.saving) {
      content = SavingSubScreen(
        transactionType: selectedType!,
        onBack: goBack,
        type: 'saving',
      );
    } else if (selectedType == TransactionType.transfer) {
      content = TransferSubScreen(
        transactionType: selectedType!,
        onBack: goBack,
        parentContext: context,
      );
    } else if (selectedType == TransactionType.expense) {
      content = ExpenseSubScreen(
        transactionType: selectedType!,
        onBack: goBack,
        type: 'expense',
      );
    } else {
      content = const SizedBox.shrink();
    }

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _headerCreateTransaction(context),
            const SizedBox(height: 8),
            Expanded(child: content),
            const SizedBox(height: 24),
            PaginationDots(total: 2, current: currentStep),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  Stack _headerCreateTransaction(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: IconButton(
            icon: const Icon(Icons.arrow_back, color: AppColors.backgroundDark),
            onPressed: goBack,
          ),
        ),
        Center(
          child: Text(
            'Create Transaction',
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
      ],
    );
  }
}
