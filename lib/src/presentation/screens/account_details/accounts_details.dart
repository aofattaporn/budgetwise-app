import 'package:budget_wise/src/bloc/accounts/accounts_bloc.dart';
import 'package:budget_wise/src/bloc/accounts/accounts_event.dart';
import 'package:budget_wise/src/data/models/account.dart';
import 'package:budget_wise/src/presentation/widgets/account_card/account_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AccountDetails extends StatelessWidget {
  final Account account;

  const AccountDetails({super.key, required this.account});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AccountBloc, AccountState>(
      listener: (BuildContext context, AccountState state) {
        if (state is DeleteAccountSuccess) {
          Navigator.popUntil(context, (Route<dynamic> route) => route.isFirst);
        }
      },
      child: CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: const Text('Account Details'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_new),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        child: SafeArea(
          child: Material(
            type: MaterialType.transparency,
            child: Padding(
              padding: EdgeInsets.all(28.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Card
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: AccountCard(
                      fullsize: true,
                      account: account,
                      isHanlder: true,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
