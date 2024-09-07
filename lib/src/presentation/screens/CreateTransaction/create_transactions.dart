import 'package:budget_wise/src/data/models/Account.dart';
import 'package:budget_wise/src/presentation/widgets/AccountCard/AccountCard.dart';
import 'package:budget_wise/src/presentation/widgets/utils/customInoutField.dart';
import 'package:flutter/material.dart';

class CreateTransacction extends StatelessWidget {
  const CreateTransacction({
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
    return Container(
      padding: const EdgeInsets.only(top: 60),
      color: const Color.fromRGBO(250, 250, 250, 1),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(250, 250, 250, 1),
          leading: IconButton(
              icon: const Icon(Icons.close),
              onPressed: () => Navigator.pop(context)),
          title: const Text(
            "Transaction ",
            style: TextStyle(fontSize: 20),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const SizedBox(height: 35),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: CustomInputField(labelText: "Title"),
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    child: CustomInputField(labelText: "Date"),
                  ),
                ],
              ),
              // date

              const SizedBox(height: 20),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: CustomInputField(labelText: "Tramfer"),
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    child: CustomInputField(
                        labelText: "Ammounts", suffixText: "B"),
                  ),
                ],
              ),

              const SizedBox(height: 20),
              const CustomInputField(maxLines: 3, minLines: 3),

              const SizedBox(height: 20),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(children: [
                  for (int index = 0; index < listAcount.length; index++)
                    AccountCard(account: listAcount[index]),
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


// Container(
//   color: Colors.white,
//   child: Center(
//     child: Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       mainAxisSize: MainAxisSize.min,
//       children: <Widget>[
//         const Text('Modal BottomSheet'),
//         ElevatedButton(
//           child: const Text('Close BottomSheet'),
//           onPressed: () => Navigator.pop(context),
//         ),
//       ],
//     ),
//   ),
// );
