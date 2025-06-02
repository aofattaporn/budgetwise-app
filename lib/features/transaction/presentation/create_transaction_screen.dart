import 'package:flutter/material.dart';
import 'package:budget_wise/shared/common/pagination_dots.dart';
import 'select_transaction_type_screen.dart';

class CreateTransactionScreen extends StatelessWidget {
  final TransactionType transactionType;
  const CreateTransactionScreen({super.key, required this.transactionType});

  @override
  Widget build(BuildContext context) {
    // Use transactionType to customize the form as needed
    return Scaffold(
      appBar: AppBar(title: Text('Create Transaction')),
      body: Column(
        children: [
          Expanded(child: Center(child: Text('Form for $transactionType'))),
          const SizedBox(height: 24),
          const PaginationDots(total: 2, current: 1),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
