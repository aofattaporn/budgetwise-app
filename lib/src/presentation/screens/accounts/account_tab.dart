import 'package:budget_wise/src/presentation/screens/accounts/create_account_sheet.dart';
import 'package:flutter/material.dart';
import 'package:budget_wise/src/presentation/common/custom_common_sheet.dart';
import 'package:budget_wise/src/presentation/screens/accounts/components/account_card.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:budget_wise/src/presentation/bloc/account_bloc/account_bloc.dart';
import 'package:budget_wise/src/presentation/bloc/account_bloc/account_state.dart';
import 'package:budget_wise/src/presentation/bloc/account_bloc/account_event.dart';

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
  @override
  void initState() {
    super.initState();
    context.read<AccountBloc>().add(FetchAllAccounts());
  }

  void _showCreateAccountSheet() {
    CustomCommonSheet(height: 0.38).open(
      context,
      widget: CreateAccountSheet(
        onSubmit: (accountDto) {
          context.read<AccountBloc>().add(CreateAccount(accountDto));
          Navigator.of(context).pop();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Accounts'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            child: Material(
              color: Theme.of(context).colorScheme.primary,
              shape: const CircleBorder(),
              child: IconButton(
                icon: const Icon(Icons.add, color: Colors.white),
                tooltip: 'Add Account',
                onPressed: _showCreateAccountSheet,
              ),
            ),
          ),
        ],
      ),
      body: BlocBuilder<AccountBloc, AccountState>(
        builder: (context, state) {
          if (state is AccountLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is AccountLoaded) {
            final accounts = state.accounts;
            if (accounts.isEmpty) {
              return Center(
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
                  ],
                ),
              );
            }
            return ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: accounts.length,
              separatorBuilder: (_, __) => const SizedBox(height: 16),
              itemBuilder: (context, index) {
                final account = accounts[index];
                return AccountCard(
                  name: account.name,
                  currentBalance: account.currentBalance,
                  color: Theme.of(context).colorScheme.primary,
                  onOptionsTap: () {
                    // TODO: Show account options (edit/delete)
                  },
                );
              },
            );
          } else if (state is AccountError) {
            return Center(
                child: Text(state.message,
                    style: const TextStyle(color: Colors.red)));
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
