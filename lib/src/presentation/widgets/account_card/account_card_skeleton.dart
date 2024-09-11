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
        height: widget.fullsize == true ? 150 : null,
        width: widget.fullsize == true
            ? MediaQuery.sizeOf(context).width * 0.9
            : 240,
        margin: const EdgeInsets.only(left: 5, right: 36, bottom: 20, top: 0),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: const Alignment(0.8, 1),
              colors: [
                const Color.fromARGB(255, 238, 230, 230),
                const Color.fromRGBO(225, 234, 238, 1)
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
            Text(
              "Last Operated",
              style: TextStyle(
                  fontSize: 10, color: const Color.fromRGBO(192, 192, 192, 1)),
            ),
            Text(
              "Wed Sep 4 / 2024",
              style: TextStyle(
                  fontSize: 10, color: const Color.fromRGBO(192, 192, 192, 1)),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                RichText(
                  text: TextSpan(
                      text: 'Faks Balance B',
                      style: TextStyle(
                        fontSize: 16,
                        color: const Color.fromRGBO(192, 192, 192, 1),
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
      ),
    );
  }
}
