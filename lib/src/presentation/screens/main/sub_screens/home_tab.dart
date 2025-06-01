import 'package:budget_wise/budget_wise_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:budget_wise/src/presentation/bloc/account_bloc/account_bloc.dart';
import 'package:budget_wise/src/presentation/bloc/account_bloc/account_state.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  String get _greeting {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Good morning';
    if (hour < 18) return 'Good afternoon';
    return 'Good evening';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: const Text("Account Overview"),
        actions: [
          IconButton(
            icon: const Icon(Icons.brightness_6),
            onPressed: () {
              context.read<ThemeCubit>().toggleTheme();
            },
          ),
        ],
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(_greeting,
                            style: Theme.of(context).textTheme.titleMedium),
                        const SizedBox(height: 4),
                        Text('Total Balance',
                            style: Theme.of(context).textTheme.bodySmall),
                        BlocBuilder<AccountBloc, AccountState>(
                          builder: (context, state) {
                            double total = 0;
                            if (state is AccountLoaded) {
                              total = state.accounts
                                  .fold(0, (sum, a) => sum + a.currentBalance);
                            }
                            return Text(
                              '\u0e3f' + total.toStringAsFixed(2),
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineMedium
                                  ?.copyWith(fontWeight: FontWeight.bold),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // Accounts Card
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: BlocBuilder<AccountBloc, AccountState>(
                    builder: (context, state) {
                      if (state is AccountLoaded && state.accounts.isNotEmpty) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Accounts',
                                style: Theme.of(context).textTheme.titleMedium),
                            const SizedBox(height: 8),
                            ...state.accounts.map((a) => Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(a.name,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge),
                                    Text(
                                        '\u0e3f' +
                                            a.currentBalance.toStringAsFixed(2),
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge),
                                  ],
                                )),
                          ],
                        );
                      }
                      return const Text('No accounts found');
                    },
                  ),
                ),
              ),
            ),

            // Spending Chart (placeholder)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
                child: SizedBox(
                  height: 160,
                  child: Center(
                      child: Text('Spending Chart (Coming Soon)',
                          style: Theme.of(context).textTheme.bodyMedium)),
                ),
              ),
            ),
            // Recent Transactions (placeholder)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Recent Transactions',
                          style: Theme.of(context).textTheme.titleMedium),
                      const SizedBox(height: 8),
                      Text('Recent transactions will appear here.'),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
