import 'package:flutter/widgets.dart';

class VerticalScrollViewTodayTransaction extends StatelessWidget {
  const VerticalScrollViewTodayTransaction({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Today Transactions"),
        SizedBox(height: 16),

        // add list view avoid over flow
        SizedBox(
          height: 225,
          child: ListView.builder(
              itemCount: 20,
              itemBuilder: (context, index) => Container(
                    decoration: BoxDecoration(
                      color: Color(0xff7c94b6),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    margin: EdgeInsets.only(bottom: 12),
                    padding: EdgeInsets.all(14),
                    child: Row(
                      children: [
                        Container(),
                        const Row(
                          children: [Column(), Text("aaaa")],
                        )
                      ],
                    ),
                  )),
        ),
      ],
    );
  }
}
