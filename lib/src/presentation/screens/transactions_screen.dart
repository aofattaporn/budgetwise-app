import 'package:flutter/widgets.dart';

class TransactionsScreen extends StatefulWidget {
  const TransactionsScreen({super.key});

  @override
  State<TransactionsScreen> createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Transaction',
        style: TextStyle(fontSize: 24),
      ),
    );
  }
}
