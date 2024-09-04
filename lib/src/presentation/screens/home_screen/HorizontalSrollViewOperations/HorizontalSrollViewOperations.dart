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
              Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    color: Color(0xff7c94b6),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: IconButton(
                        onPressed: () {}, icon: Icon(Icons.line_axis)),
                  )),
              SizedBox(width: 25),
              Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    color: Color(0xff7c94b6),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: IconButton(
                        onPressed: () {}, icon: Icon(Icons.line_axis)),
                  )),
              SizedBox(width: 25),
              Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    color: Color(0xff7c94b6),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: IconButton(
                        onPressed: () {}, icon: Icon(Icons.line_axis)),
                  )),
            ],
          ),
        )
      ],
    );
  }
}
