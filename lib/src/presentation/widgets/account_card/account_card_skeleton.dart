import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class AccountCardSkeleton extends StatefulWidget {
  final bool? fullsize;

  const AccountCardSkeleton({
    super.key,
    this.fullsize,
  });

  @override
  State<AccountCardSkeleton> createState() => _AccountCardState();
}

class _AccountCardState extends State<AccountCardSkeleton> {
  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      child: Container(
        height: 120,
        width: widget.fullsize == true
            ? MediaQuery.sizeOf(context).width * 0.9
            : 240,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment(0.8, 1),
              colors: [
                Color.fromARGB(255, 238, 230, 230),
                Color.fromRGBO(225, 234, 238, 1)
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
                Text("Fake Data",
                    style: TextStyle(
                        fontSize: widget.fullsize == true ? 24 : null,
                        fontWeight: FontWeight.bold,
                        color: const Color.fromRGBO(192, 192, 192, 1)))
              ],
            ),
            const Text(
              "Last Operated",
              style: TextStyle(
                  fontSize: 10, color: Color.fromRGBO(192, 192, 192, 1)),
            ),
            const Text(
              "Wed Sep 4 / 2024",
              style: TextStyle(
                  fontSize: 10, color: Color.fromRGBO(192, 192, 192, 1)),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                RichText(
                  text: const TextSpan(
                      text: 'Faks Balance B',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color.fromRGBO(192, 192, 192, 1),
                      ),
                      children: <TextSpan>[
                        TextSpan(
                            text: 'B',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ]),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
