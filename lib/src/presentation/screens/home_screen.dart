import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class Account {
  String accountName;
  double Balance;

  Account(this.accountName, this.Balance);
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> items = List<String>.generate(5, (i) => 'Item $i');

  // TODO : Account Class
  var listAcount = [
    Account("SCB", 14000.0),
    Account("BBL", 11588.33),
    Account("Cash", 230),
  ];

  var list = [
    "one",
    "two",
    "three",
    "four",
    "one",
    "two",
    "three",
    "four",
    "one",
    "two",
    "three",
    "four"
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // TODO: Account-overciew
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // labels
                const Row(
                  children: [],
                ),

                const Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Welcome",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                    ),
                    Text("4 (Wed) Sep 2024", style: TextStyle(fontSize: 14)),
                  ],
                ),

                const SizedBox(height: 30),

                // accounts
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  reverse: false,
                  child: Row(
                    children: [
                      Container(
                        height: 120,
                        width: 240,
                        decoration: BoxDecoration(
                          color: const Color(0xff7c94b6),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Padding(
                            padding: EdgeInsets.all(20),
                            child: Column(
                              children: [
                                Row(
                                  children: [Text("SCB")],
                                )
                              ],
                            )),
                      ),
                      SizedBox(width: 50),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 30),

            // TODO: Operations
            Column(
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
            ),

            const SizedBox(height: 30),

            Column(
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
            ),
          ],
        ));
  }
}
