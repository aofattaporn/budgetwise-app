import 'package:budget_wise/src/data/models/account.dart';
import 'package:budget_wise/src/data/models/planning_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PlanPocketCreate extends StatelessWidget {
  final Planning planning;
  final Account? account;
  final bool isFullSize;
  final IconData iconData;

  PlanPocketCreate({
    required this.iconData,
    required this.isFullSize,
    required this.planning,
    required this.account,
    super.key,
  });

  String formatNumber(String rawNumber) {
    String cleanedValue = rawNumber.replaceAll(RegExp(r'[^\d.]'), '');

    if (cleanedValue.isEmpty || cleanedValue == '.') return '';
    List<String> parts = cleanedValue.split('.');
    final NumberFormat formatter = NumberFormat('#,###');
    String formattedIntegerPart = formatter.format(int.parse(parts[0]));
    if (parts.length > 1) {
      String decimalPart = parts[1];
      return '$formattedIntegerPart.$decimalPart';
    }

    return formattedIntegerPart;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 145,
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 10,
            blurRadius: 15,
            offset: const Offset(3, 6),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                height: isFullSize ? 58 : 36,
                width: isFullSize ? 58 : 36,
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(240, 240, 240, 1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(iconData,
                    color: Colors.grey, size: isFullSize ? 32 : 20),
              ),
              SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(planning.name,
                      style: TextStyle(
                          color: planning.name == "Planning"
                              ? Colors.grey.shade400
                              : Colors.black,
                          fontSize: isFullSize ? 20 : 14,
                          fontWeight: isFullSize ? FontWeight.bold : null,
                          overflow: TextOverflow.clip)),
                  Text(
                    account != null
                        ? account!.accountName
                        : "Account Selecting",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color:
                          account != null ? Colors.black : Colors.grey.shade400,
                    ),
                  ),
                ],
              )
            ],
          ),
          Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text('${formatNumber(planning!.limit.toString())} B',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                    color: planning.limit == 0
                        ? Colors.grey.shade400
                        : Colors.black,
                  )),
            ],
          )
        ],
      ),
    );
  }
}
