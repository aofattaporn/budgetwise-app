import 'package:flutter/material.dart';

class TransactionItem extends StatelessWidget {
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
      padding: const EdgeInsets.all(16),
      clipBehavior: Clip.none,
      child: Row(
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
                child: const Icon(Icons.home_outlined,
                    color: Colors.grey, size: 30),
              ),

              const SizedBox(width: 16), // Spacing between icon and text

              // Text Column
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Rental Income",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    "14 July 2021",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ],
          ),

          // Amount
          const Text(
            "+\$6,500.00",
            style: TextStyle(
              color: Colors.green,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
