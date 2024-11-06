import 'package:budget_wise/src/bloc/accounts/accounts_bloc.dart';
import 'package:budget_wise/src/bloc/accounts/accounts_state.dart';
import 'package:budget_wise/src/models/entity/budget_account_entity.dart';
import 'package:budget_wise/src/presentation/widgets/account_card/account_card.dart';
import 'package:budget_wise/src/presentation/widgets/account_card/account_card_failure.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SelectAllAccounts extends StatelessWidget {
  final Function(BudgetAccountEntity) onAccountSelected;
  BudgetAccountEntity? accountVisit;

  SelectAllAccounts({
    required this.accountVisit,
    required this.onAccountSelected,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AccountBloc, AccountState>(builder: (context, state) {
      if (state is GetAllAccountsSuccess) {
        return SingleChildScrollView(
          clipBehavior: Clip.none,
          scrollDirection: Axis.horizontal,
          child: Row(children: [
            for (int index = 0; index < state.data.length; index++)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    BudgetAccountEntity selectedAccount = BudgetAccountEntity(
                      accountId: state.data[index].accountId,
                      accountName: state.data[index].accountName,
                      balance: state.data[index].balance,
                      createDate: state.data[index].createDate,
                      updatePlanDate: state.data[index].updatePlanDate,
                      colorIndex: state.data[index].colorIndex,
                    );

                    accountVisit = selectedAccount;
                    onAccountSelected(selectedAccount); // Call the callback
                  },
                  child: AccountCard(
                    isSelected:
                        accountVisit?.accountId == state.data[index].accountId,
                    account: state.data[index],
                  ),
                ),
              ),
          ]),
        );
      } else {
        return AccountCardFailure();
      }
    });
  }
}
