import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:budget_wise/src/bloc/main_screen_bloc/main_screen_bloc.dart';
import 'package:budget_wise/src/bloc/navigate_screen_bloc/navigate_screen_bloc.dart';
import 'package:budget_wise/src/bloc/plan_bloc/plan_bloc.dart';
import 'package:budget_wise/src/bloc/plan_detail_bloc/plan_detail_bloc.dart';
import 'package:budget_wise/src/screens/main_screen/main_screen.dart';

class BudgetWiseApp extends StatefulWidget {
  const BudgetWiseApp({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _BudgetWiseAppState createState() => _BudgetWiseAppState();
}

class _BudgetWiseAppState extends State<BudgetWiseApp> {
  final kTitleBudgetWise = "Budget Wise";
  final List<BlocProvider> _blocProviders = [
    BlocProvider<MainScreenBloc>(
      create: (BuildContext context) => MainScreenBloc(),
    ),
    BlocProvider<NavigateScreenBloc>(
      create: (BuildContext context) => NavigateScreenBloc(),
    ),
    BlocProvider<PlanBloc>(
      create: (BuildContext context) => PlanBloc(),
    ),
    BlocProvider<PlanDetailBloc>(
      create: (BuildContext context) => PlanDetailBloc(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: _blocProviders,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: kTitleBudgetWise,
        themeMode: ThemeMode.light,
        theme: ThemeData(
            scaffoldBackgroundColor: const Color.fromARGB(255, 245, 244, 244)),
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('en'), // English
          Locale('th'), // Thai
        ],
        home: const MainScreen(),
      ),
    );
  }
}
