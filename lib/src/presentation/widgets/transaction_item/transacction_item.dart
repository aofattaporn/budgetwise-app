import 'package:budget_wise/src/data/models/transaction.dart';
import 'package:budget_wise/src/presentation/constant/icons.dart';
import 'package:budget_wise/src/utils/DateTie.dart';
import 'package:flutter/material.dart';

class TransactionItem extends StatelessWidget {
  final Transaction transaction;

  TransactionItem(this.transaction);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0),
            spreadRadius: 5,
            blurRadius: 20,
            offset: const Offset(0, 0), // changes position of shadow
          ),
        ],
      ),
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
      padding: const EdgeInsets.all(12),
      clipBehavior: Clip.none,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              // Icon with background
              Container(
                height: 45,
                width: 45,
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(
                      240, 240, 240, 1), // Light gray background
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(IconConstants.icons[transaction.indexIcon!],
                    color: Colors.grey, size: 30),
              ),

              const SizedBox(width: 16), // Spacing between icon and text

              // Text Column
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: transaction.planName,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: Colors.black,
                          ),
                        ),
                        TextSpan(
                          text: " " +
                              transaction.accountName!, // The appended text
                          style: TextStyle(
                            fontWeight: FontWeight
                                .normal, // You can change the style here
                            fontSize: 14,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    transaction.name,
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    UtilsDateTime.formatDate(transaction.createDate!),
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ],
          ),

          // Amount
          Text(
            "+" + transaction.amount.toString() + " B",
            style: TextStyle(
              color: Colors.green,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
