import 'package:budget_wise/src/bloc/accounts/accounts_bloc.dart';
import 'package:budget_wise/src/bloc/accounts/accounts_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AccountCardFailure extends StatelessWidget {
  const AccountCardFailure({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 120,
        width: MediaQuery.sizeOf(context).width * 0.88,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.all(20),
        child: Center(
            child: Column(
          children: [
            Text("No accounts available."),
            TextButton(
              onPressed: () =>
                  {context.read<AccountBloc>().add(GetAllAccountsEvent())},
              child: Text("Click to try again."),
            ),
          ],
        )));
  }
}
