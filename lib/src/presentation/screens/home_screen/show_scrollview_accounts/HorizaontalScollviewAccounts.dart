import 'package:budget_wise/src/bloc/accounts/accounts_bloc.dart';
import 'package:budget_wise/src/bloc/accounts/accounts_event.dart';
import 'package:budget_wise/src/bloc/accounts/accounts_state.dart';
import 'package:budget_wise/src/presentation/screens/create_account/create_account.dart';
import 'package:budget_wise/src/presentation/widgets/account_card/account_card.dart';
import 'package:budget_wise/src/presentation/widgets/account_card/account_card_skeleton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HorizontalScollviewAccounts extends StatelessWidget {
  const HorizontalScollviewAccounts({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // Dispatch the GetAllAccountsEvent when the widget is built
    context.read<AccountBloc>().add(GetAllAccountsEvent());

    return BlocListener<AccountBloc, AccountState>(
      listener: (BuildContext context, state) {
        if (state is CreateAccountSuccess) {
          context.read<AccountBloc>().add(GetAllAccountsEvent());
        }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Welcome",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                  ),
                  Text("Wed 4 Sep 2024", style: TextStyle(fontSize: 14)),
                ],
              ),
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFF9379E0), // Purple shade
                      Color(0xFFAE78D6), // Lighter purple
                      Color(0xFFD780E1), // Pinkish purple
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(40),
                ),
                child: TextButton(
                  onPressed: () {
                    showModalBottomSheet<void>(
                      context: context,
                      isScrollControlled: true,
                      builder: (BuildContext context) {
                        return CreateAccount();
                      },
                    );
                  },
                  child: Text(
                    "create account",
                    style: TextStyle(fontSize: 12),
                  ),
                  style: ButtonStyle(
                    foregroundColor: WidgetStateProperty.all(Colors.white),
                  ),
                ),
              )
            ],
          ),
          const SizedBox(height: 30),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: BlocBuilder<AccountBloc, AccountState>(
                builder: (context, state) {
              if (state is GetAllAccountsSuccess) {
                return Row(
                  children: [
                    for (int index = 0; index < state.data.length; index++)
                      AccountCard(
                        account: state.data[index],
                      ),
                  ],
                );
              } else if (state is GetAllAccountsLoading) {
                // Display loading indicator when accounts are loading
                return AccountCardSkeleton();
              } else {
                // Handle other states or errors
                return Center(child: Text("No accounts available."));
              }
            }),
          ),
        ],
      ),
    );
  }
}
