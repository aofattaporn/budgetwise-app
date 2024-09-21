import 'package:budget_wise/src/bloc/accounts/accounts_bloc.dart';
import 'package:budget_wise/src/bloc/plans/plans_bloc.dart';
import 'package:budget_wise/src/bloc/users/users_bloc.dart';
import 'package:budget_wise/src/data/repositories/planning_repository.dart';
import 'package:budget_wise/src/presentation/screens/home_screen/home_screen.dart';
import 'package:budget_wise/src/presentation/screens/plan_screen/plan_screen.dart';
import 'package:budget_wise/src/presentation/screens/transactions_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    return MultiBlocProvider(
      providers: [
        BlocProvider<AccountBloc>(
          create: (BuildContext context) => AccountBloc(),
        ),
        BlocProvider<UsersBloc>(
          create: (BuildContext context) => UsersBloc(),
        ),
        BlocProvider<PlansBloc>(
          create: (BuildContext context) => PlansBloc(),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(
            scaffoldBackgroundColor: Color.fromRGBO(250, 250, 250, 1)),
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
            backgroundColor: Color.fromRGBO(250, 250, 250, 1),
          ),
          // backgroundColor: Colors.white,
          body: _widgetOptions.elementAt(_selectedIndex),
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, 0.1),
                  blurRadius: 20,
                ),
              ],
            ),
            child: BottomNavigationBar(
              elevation: 10,
              backgroundColor: Color.fromRGBO(250, 250, 250, 1),
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
        ),
      ),
    );
  }
}
