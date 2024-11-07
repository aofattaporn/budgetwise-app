import 'package:budget_wise/src/bloc/accounts/accounts_bloc.dart';
import 'package:budget_wise/src/bloc/plans/plans_bloc.dart';
import 'package:budget_wise/src/bloc/plansOverview/month_picker_bloc.dart';
import 'package:budget_wise/src/bloc/transactions/transactions_bloc.dart';
import 'package:budget_wise/src/bloc/usersFin/usersfin_bloc.dart';
import 'package:budget_wise/src/presentation/screens/home_screen/home_screen.dart';
import 'package:budget_wise/src/presentation/screens/plan_screen/plan_screen.dart';
import 'package:budget_wise/src/presentation/screens/transactions_screen/transactions_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // Index to keep track of the current selected tab
  int _selectedIndex = 0;

  // List of widgets to display based on the selected tab
  final List<Widget> _widgetOptions = <Widget>[
    const HomeScreen(),
    TransactionsScreen(),
    const PlanScreen()
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
        BlocProvider<UsersFinBloc>(
          create: (BuildContext context) => UsersFinBloc(),
        ),
        BlocProvider<PlansBloc>(
          create: (BuildContext context) => PlansBloc(),
        ),
        BlocProvider<TransactionsBloc>(
          create: (BuildContext context) => TransactionsBloc(),
        ),
        BlocProvider<MonthPickerBloc>(
          create: (BuildContext context) => MonthPickerBloc(),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(
            scaffoldBackgroundColor: Color.fromRGBO(250, 250, 250, 1)),
        debugShowCheckedModeBanner: false,
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('en'), // English
          Locale('th'), // Spanish
        ],
        home: Scaffold(
          appBar: AppBar(
            backgroundColor: Color.fromRGBO(250, 250, 250, 1),
          ),
          // backgroundColor: Colors.white,
          body: _widgetOptions.elementAt(_selectedIndex),
          bottomNavigationBar: Container(
            decoration: const BoxDecoration(
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
