import 'package:budget_wise/src/constant/constants.dart';
import 'package:budget_wise/src/data/models/Account.dart';
import 'package:budget_wise/src/presentation/screens/create_transaction/create_transactions.dart';
import 'package:budget_wise/src/presentation/screens/create_account/create_account.dart';
import 'package:budget_wise/src/presentation/widgets/AccountCard/account_card.dart';
import 'package:flutter/material.dart';

class HorizontalScollviewAccounts extends StatelessWidget {
  const HorizontalScollviewAccounts({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    List<Account> listAcount = [
      Account(
        "SCB",
        14000.0,
        DateTime.now(),
        const Color.fromARGB(255, 82, 29, 125),
        const Color.fromRGBO(108, 51, 163, 1),
      ),
      Account(
        "BBL",
        11588.33,
        DateTime.now(),
        const Color.fromRGBO(25, 23, 20, 1),
        const Color.fromRGBO(34, 52, 174, 1),
      ),
      Account(
        "Cash",
        230,
        DateTime.now(),
        const Color.fromRGBO(0, 0, 0, 1),
        const Color.fromRGBO(22, 109, 59, 1),
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // labels
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
                  begin: Alignment.topLeft, // Gradient start point
                  end: Alignment.bottomRight, // Gradient end point
                ),
                borderRadius:
                    BorderRadius.circular(40), // Optional: Add rounded corners
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
                  foregroundColor: MaterialStateProperty.all(Colors.white),
                ),
              ),
            )
          ],
        ),

        const SizedBox(height: 30),

        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(children: [
            for (int index = 0; index < listAcount.length; index++)
              AccountCard(
                  account: listAcount[index]), // Access account using the index
          ]),
        ),
      ],
    );
  }
}
