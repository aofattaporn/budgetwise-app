import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HorizontalSrollViewOperations extends StatelessWidget {
  const HorizontalSrollViewOperations({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Operations"),
        const SizedBox(height: 16),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          reverse: false,
          child: Row(
            children: [
              Column(
                children: [
                  Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.1),
                            spreadRadius: 5,
                            blurRadius: 50,
                            offset: const Offset(2, 4),
                          )
                        ],
                      ),
                      child: Center(
                        child: IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.arrow_upward_outlined)),
                      )),
                  const SizedBox(height: 4),
                  const Text("Tranfer")
                ],
              ),
              const SizedBox(width: 25),
              Column(
                children: [
                  Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.1),
                            spreadRadius: 5,
                            blurRadius: 50,
                            offset: const Offset(2, 4),
                          )
                        ],
                      ),
                      child: Center(
                        child: IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.arrow_downward_rounded)),
                      )),
                  const SizedBox(height: 4),
                  const Text("Incoming")
                ],
              ),
              const SizedBox(width: 25),
              Column(
                children: [
                  Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.1),
                            spreadRadius: 5,
                            blurRadius: 50,
                            offset: const Offset(2, 4),
                          )
                        ],
                      ),
                      child: Center(
                        child: IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.autorenew_rounded)),
                      )),
                  const SizedBox(height: 4),
                  const Text("Change")
                ],
              ),
              const SizedBox(width: 25),
            ],
          ),
        )
      ],
    );
  }
}
