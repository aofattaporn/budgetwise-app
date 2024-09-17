import 'package:budget_wise/src/mock/mock_accounts_data.dart';
import 'package:flutter/material.dart';

class SelectAllIcons extends StatelessWidget {
  const SelectAllIcons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      clipBehavior: Clip.none,
      scrollDirection: Axis.horizontal,
      child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
        for (int index = 0; index < 20; index++)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {},
              child: Container(
                height: 42,
                width: 42,
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(240, 240, 240, 1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(Icons.home_outlined, color: Colors.grey, size: 24),
              ),
            ),
          ),
      ]),
    );
  }
}
