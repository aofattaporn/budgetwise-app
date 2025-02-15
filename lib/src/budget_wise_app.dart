import 'package:budget_wise/src/bloc/main_screen_bloc/main_screen_bloc.dart';
import 'package:budget_wise/src/bloc/navigate_screen_bloc/navigate_screen_bloc.dart';
import 'package:budget_wise/src/screens/main_screen/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

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
  ];

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: _blocProviders,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: kTitleBudgetWise,
        themeMode: ThemeMode.light,

        // TODO : Managing theme
        // theme: ThemeData(
        //     textTheme: AppTextTheme.lightTextTheme,
        //     colorScheme: AppColorScheme.lightScheme,
        //     iconTheme: AppIconTheme.lightTheme,
        //     scaffoldBackgroundColor: const Color.fromRGBO(250, 250, 250, 1)),
        // darkTheme: ThemeData(
        //     textTheme: AppTextTheme.darkTextTheme,
        //     colorScheme: AppColorScheme.darkScheme,
        //     iconTheme: AppIconTheme.darkTheme,
        //     scaffoldBackgroundColor: const Color.fromRGBO(0, 0, 0, 1)),

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
