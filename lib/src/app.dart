import 'package:budget_wise/src/presentation/screens/home_screen/home_screen.dart';
import 'package:budget_wise/src/presentation/screens/plan_screen.dart';
import 'package:budget_wise/src/presentation/screens/transactions_screen.dart';
import 'package:flutter/material.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // Index to keep track of the current selected tab
  int _selectedIndex = 0;

  // List of widgets to display based on the selected tab
  final List<Widget> _widgetOptions = const <Widget>[
    HomeScreen(),
    TransactionsScreen(),
    PlanScreen()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(),
        body: _widgetOptions.elementAt(_selectedIndex),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home_work_outlined),
              label: 'home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.line_axis),
              label: 'transactions',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.cloud),
              label: 'plan',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.purple,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
