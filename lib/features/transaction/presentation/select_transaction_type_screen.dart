import 'package:flutter/material.dart';
import 'package:budget_wise/shared/common/pagination_dots.dart';

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
              _TypeButton(
                icon: Icons.remove_circle_outline,
                label: 'Expense',
                onTap: () => selectType(TransactionType.expense),
              ),
              _TypeButton(
                icon: Icons.savings_outlined,
                label: 'Saving',
                onTap: () => selectType(TransactionType.saving),
              ),
              _TypeButton(
                icon: Icons.compare_arrows_outlined,
                label: 'Transfer',
                onTap: () => selectType(TransactionType.transfer),
              ),
            ],
          ),
        ],
      );
    } else {
      content = CreateTransactionSubScreen(
        transactionType: selectedType!,
        onBack: goBack,
      );
    }

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                if (currentStep == 1)
                  IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: goBack,
                  ),
                Expanded(
                  child: Center(
                    child: Text(
                      'Create Transaction',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                ),
                if (currentStep == 1) SizedBox(width: 48), // for symmetry
              ],
            ),
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
}

class _TypeButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  const _TypeButton(
      {required this.icon, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(32),
          child: CircleAvatar(
            radius: 32,
            backgroundColor:
                Theme.of(context).colorScheme.primary.withOpacity(0.1),
            child: Icon(icon,
                size: 32, color: Theme.of(context).colorScheme.primary),
          ),
        ),
        const SizedBox(height: 8),
        Text(label, style: Theme.of(context).textTheme.bodyMedium),
      ],
    );
  }
}

class CreateTransactionSubScreen extends StatelessWidget {
  final TransactionType transactionType;
  final VoidCallback onBack;
  const CreateTransactionSubScreen(
      {super.key, required this.transactionType, required this.onBack});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Form for $transactionType'),
    );
  }
}
