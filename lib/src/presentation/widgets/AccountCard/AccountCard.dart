import 'package:budget_wise/src/data/models/Account.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AccountCard extends StatelessWidget {
  final Account account;

  const AccountCard({
    super.key,
    required this.account,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 240,
      margin: const EdgeInsets.only(left: 5, right: 36, bottom: 20, top: 0),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment(0.8, 1),
            colors: [
              account.colorStart,
              account.colorEnd,
            ]),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 5,
            blurRadius: 12,
            offset: const Offset(3, 6),
          )
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(account.accountName,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white))
            ],
          ),
          const Text(
            "Last Operated",
            style: TextStyle(fontSize: 10, color: Colors.white),
          ),
          const Text(
            "Wed Sep 4 / 2024",
            style: TextStyle(fontSize: 10, color: Colors.grey),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              RichText(
                text: TextSpan(
                    text: account.Balance.toString() + " ",
                    style: const TextStyle(fontSize: 16),
                    children: const <TextSpan>[
                      TextSpan(
                          text: 'B',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ]),
              )
            ],
          ),
        ],
      ),
    );
  }
}
