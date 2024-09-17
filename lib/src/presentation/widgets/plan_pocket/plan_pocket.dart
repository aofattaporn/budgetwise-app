import 'package:flutter/material.dart';

class PlanPocket extends StatelessWidget {
  bool isFullSize;
  PlanPocket({
    required this.isFullSize,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
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
                child: Icon(Icons.home_outlined,
                    color: Colors.grey, size: isFullSize ? 32 : 20),
              ),
              SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("data testing",
                      style: TextStyle(
                          fontSize: isFullSize ? 20 : 14,
                          fontWeight: isFullSize ? FontWeight.bold : null,
                          overflow: TextOverflow.clip)),
                  Text(
                    "SCB",
                    style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                  ),
                ],
              )
            ],
          ),
          Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("B 5000 / 2000"),
              IntrinsicWidth(
                  child: Container(
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(240, 240, 240, 1),
                  borderRadius: BorderRadius.circular(10),
                ),
                height: 10,
                width: MediaQuery.sizeOf(context).width,
              ))
            ],
          ),
        ],
      ),
    );
  }
}
