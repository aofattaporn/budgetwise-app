import 'package:budget_wise/src/bloc/accounts/accounts_bloc.dart';
import 'package:budget_wise/src/bloc/accounts/accounts_state.dart';
import 'package:budget_wise/src/bloc/accounts/accounts_event.dart';
import 'package:budget_wise/src/presentation/screens/account_details/accounts_details.dart';
import 'package:budget_wise/src/presentation/screens/account_details/create_account/create_account.dart';
import 'package:budget_wise/src/presentation/ui/generic_txt_btn.dart';
import 'package:budget_wise/src/presentation/widgets/account_card/account_card.dart';
import 'package:budget_wise/src/presentation/widgets/account_card/account_card_failure.dart';
import 'package:budget_wise/src/presentation/widgets/account_card/account_card_skeleton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class ShowAllAccountsHomepage extends StatelessWidget {
  final String greetings = "Welcome";

  const ShowAllAccountsHomepage({
    super.key,
  });

  _popUpShowCreateAccount(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return CreateAccount();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // Get the current date and format it
    String currentDate = DateFormat('EEE d MMM yyyy').format(DateTime.now());

    // Dispatch the GetAllAccountsEvent when the widget is built
    context.read<AccountBloc>().add(GetAllAccountsEvent());

    return BlocListener<AccountBloc, AccountState>(
      listener: (BuildContext context, state) {
        if (state is CreateAccountSuccess ||
            state is DeleteAccountSuccess ||
            state is UpdateAccountSuccess) {
          context.read<AccountBloc>().add(GetAllAccountsEvent());
        }
      },
      child: SizedBox(
        height: MediaQuery.sizeOf(context).height * 0.26,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      greetings,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                    ),
                    Text(currentDate, style: const TextStyle(fontSize: 14)),
                  ],
                ),
                GenericTxtBTN(
                    title: "+ Create account",
                    handler: () => _popUpShowCreateAccount(context)),
              ],
            ),
            const SizedBox(height: 30),
            showAllAccounts(),
          ],
        ),
      ),
    );
  }

  SingleChildScrollView showAllAccounts() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      clipBehavior: Clip.none,
      child: BlocBuilder<AccountBloc, AccountState>(builder: (context, state) {
        // * CASEE : GET: All Accounts success
        if (state is GetAllAccountsSuccess && state.data.isNotEmpty) {
          return Row(
            children: [
              for (int index = 0; index < state.data.length; index++)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        CupertinoPageRoute(
                            builder: (context) =>
                                AccountDetails(account: state.data[index])),
                      );
                    },
                    child: AccountCard(
                      account: state.data[index],
                    ),
                  ),
                ),
            ],
          );
        }

        // * CASEE : GET: All Accounts loading
        else if (state is GetAllAccountsLoading) {
          return Row(
            children: [
              for (int index = 0; index < 3; index++)
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: AccountCardSkeleton(),
                ),
            ],
          );
        }

        // * CASEE : GET: All Accounts failure
        else {
          return const AccountCardFailure();
        }
      }),
    );
  }
}
