import 'package:budget_wise/src/mock/mock_accounts_data.dart';
import 'package:budget_wise/src/presentation/widgets/account_card/account_card.dart';
import 'package:flutter/widgets.dart';

class SelectAllAccounts extends StatelessWidget {
  const SelectAllAccounts({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      clipBehavior: Clip.none,
      scrollDirection: Axis.horizontal,
      child: Row(children: [
        for (int index = 0; index < Mocks.listAccount.length; index++)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {},
              child: AccountCard(
                  isSelected: false, account: Mocks.listAccount[index]),
            ),
          ),
      ]),
    );
  }
}
