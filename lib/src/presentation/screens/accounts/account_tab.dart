import 'package:budget_wise/src/presentation/screens/accounts/create_account_sheet.dart';
import 'package:flutter/material.dart';
import 'package:budget_wise/src/presentation/common/custom_common_sheet.dart';
import 'package:budget_wise/src/presentation/screens/accounts/components/account_card.dart';
// import 'package:budget_wise/src/presentation/screens/accounts/create_account_sheet.dart';

// TODO: Connect AccountBloc here for real data
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:budget_wise/src/presentation/bloc/account_bloc/account_bloc.dart';
// import 'package:budget_wise/src/presentation/bloc/account_bloc/account_state.dart';
// import 'package:budget_wise/src/presentation/bloc/account_bloc/account_event.dart';

class AccountTab extends StatefulWidget {
  const AccountTab({super.key});

  @override
  State<AccountTab> createState() => _AccountTabState();
}

class _AccountTabState extends State<AccountTab> {
  // Mock data for accounts
  final List<Map<String, dynamic>> _mockAccounts = [
    {
      'name': 'KBank',
      'currentBalance': 12000.50,
      'color': Colors.green,
    },
    {
      'name': 'SCB',
      'currentBalance': 8500.00,
      'color': Colors.purple,
    },
    {
      'name': 'Cash',
      'currentBalance': 2000.00,
      'color': Colors.orange,
    },
  ];

  void _showCreateAccountSheet() {
    CustomCommonSheet(height: 0.38).open(
      context,
      widget: const CreateAccountSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: Replace mock data with BlocBuilder<AccountBloc, AccountState>
    final accounts = _mockAccounts;

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Accounts'),
        centerTitle: true,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
      ),
      body: accounts.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.account_balance_wallet_outlined,
                      size: 64, color: Colors.grey[400]),
                  const SizedBox(height: 16),
                  const Text(
                    'No accounts yet',
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                  const SizedBox(height: 8),
                  ElevatedButton.icon(
                    onPressed: _showCreateAccountSheet,
                    icon: const Icon(Icons.add),
                    label: const Text('Create Account'),
                  ),
                ],
              ),
            )
          : ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: accounts.length,
              separatorBuilder: (_, __) => const SizedBox(height: 16),
              itemBuilder: (context, index) {
                final account = accounts[index];
                return AccountCard(
                  name: account['name'],
                  currentBalance: account['currentBalance'],
                  color: account['color'],
                  onOptionsTap: () {
                    // TODO: Show account options (edit/delete)
                  },
                );
              },
            ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(
            bottom: 32.0), // Move FAB up from bottom nav bar
        child: FloatingActionButton.extended(
          onPressed: _showCreateAccountSheet,
          icon: const Icon(Icons.add),
          label: const Text('Add Account'),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
