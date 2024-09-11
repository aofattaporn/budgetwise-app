import 'package:budget_wise/src/data/models/account.dart';
import 'package:budget_wise/src/presentation/widgets/account_card/account_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AccountDetails extends StatelessWidget {
  final Account account;

  const AccountDetails({super.key, required this.account});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
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
    );
  }
}
