import 'package:budget_wise/src/bloc/accounts/accounts_bloc.dart';
import 'package:budget_wise/src/bloc/accounts/accounts_state.dart';
import 'package:budget_wise/src/models/entity/budget_account_entity.dart';
import 'package:budget_wise/src/presentation/widgets/account_card/account_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AccountDetails extends StatefulWidget {
  final BudgetAccountEntity account;
  const AccountDetails({super.key, required this.account});

  @override
  State<AccountDetails> createState() => _AccountDetailsState();
}

class _AccountDetailsState extends State<AccountDetails> {
  late BudgetAccountEntity selectedAccount;

  @override
  void initState() {
    super.initState();
    selectedAccount = widget.account;
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AccountBloc, AccountState>(
      listener: (BuildContext context, AccountState state) {
        if (state is DeleteAccountSuccess) {
          Navigator.popUntil(context, (Route<dynamic> route) => route.isFirst);
        } else if (state is GetAllAccountsSuccess) {
          final updatedAccount = state.data.firstWhere(
            (account) => account.accountId == widget.account.accountId,
            orElse: () => widget.account,
          );

          setState(() {
            selectedAccount = updatedAccount;
          });
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
                      account: selectedAccount,
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
