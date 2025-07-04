import 'package:budget_wise/presentation/sheets/select_transaction_type_screen.dart';
import 'package:flutter/material.dart';

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
