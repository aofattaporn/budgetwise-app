import 'package:flutter/material.dart';

class TransactionsScreen extends StatefulWidget {
  const TransactionsScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _TransactionsScreenState createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen> {
  String _selectedFilter = 'Date';
  DateTime _selectedDate = DateTime.now();
  List<String> _transactions = [];

  void _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        // Fetch transactions for the selected date
        _transactions = _fetchTransactionsByDate(_selectedDate);
      });
    }
  }

  List<String> _fetchTransactionsByDate(DateTime date) {
    // Replace with actual logic to fetch transactions by date
    return ['Transaction 1', 'Transaction 2', 'Transaction 3'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transactions'),
      ),
      body: Column(
        children: [
          DropdownButton<String>(
            value: _selectedFilter,
            items: <String>['Date', 'Week', 'Month']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                _selectedFilter = newValue!;
                // Handle filter change logic here
              });
            },
          ),
          if (_selectedFilter == 'Date')
            ListTile(
              title:
                  Text("Select Date: ${_selectedDate.toLocal()}".split(' ')[0]),
              trailing: const Icon(Icons.calendar_today),
              onTap: () => _selectDate(context),
            ),
          Expanded(
            child: ListView.builder(
              itemCount: _transactions.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_transactions[index]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
