import 'package:budget_wise/src/data/models/Account.dart';
import 'package:flutter/material.dart';

class AccountCard extends StatelessWidget {
  final bool? isSelected;
  final Account account;
  final bool? fullsize;

  const AccountCard({
    super.key,
    this.isSelected,
    this.fullsize,
    required this.account,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: this.fullsize == true ? 150 : null,
      width:
          this.fullsize == true ? MediaQuery.sizeOf(context).width * 0.9 : 240,
      margin: const EdgeInsets.only(left: 5, right: 36, bottom: 20, top: 0),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: const Alignment(0.8, 1),
            colors: (isSelected == true || isSelected == null)
                ? [
                    account.colorStart,
                    account.colorEnd,
                  ]
                : [
                    const Color.fromRGBO(250, 240, 240, 1),
                    const Color.fromRGBO(225, 234, 238, 1)
                  ]),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: (isSelected == true || isSelected == null)
                ? Colors.grey.withOpacity(0.3)
                : Colors.grey.withOpacity(0),
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
                  style: TextStyle(
                      fontSize: this.fullsize == true ? 24 : null,
                      fontWeight: FontWeight.bold,
                      color: isSelected == true || isSelected == null
                          ? Colors.white
                          : const Color.fromRGBO(192, 192, 192, 1)))
            ],
          ),
          Text(
            "Last Operated",
            style: TextStyle(
                fontSize: 10,
                color: isSelected == true || isSelected == null
                    ? Colors.white
                    : const Color.fromRGBO(192, 192, 192, 1)),
          ),
          Text(
            "Wed Sep 4 / 2024",
            style: TextStyle(
                fontSize: 10,
                color: isSelected == true || isSelected == null
                    ? Colors.white
                    : const Color.fromRGBO(192, 192, 192, 1)),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              RichText(
                text: TextSpan(
                    text: '${account.Balance.toString()} ',
                    style: TextStyle(
                      fontSize: 16,
                      color: isSelected == true || isSelected == null
                          ? Colors.white
                          : const Color.fromRGBO(192, 192, 192, 1),
                    ),
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
