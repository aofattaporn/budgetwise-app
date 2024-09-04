import 'package:budget_wise/src/data/models/Account.dart';
import 'package:budget_wise/src/presentation/widgets/AccountCard/AccountCard.dart';
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
