import 'package:budget_wise/src/bloc/navigate_screen_bloc/navigate_screen_bloc.dart';
import 'package:budget_wise/src/home.dart';
import 'package:budget_wise/src/presentation/constant/router.dart';
import 'package:budget_wise/src/presentation/screens/home_screen/home_screen.dart';
import 'package:budget_wise/src/presentation/screens/plan_screen/plan_screen.dart';
import 'package:budget_wise/src/presentation/screens/transactions_screen/transactions_screen.dart';
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

        /// Specifies the theme data for the application.
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

        /// The `supportedLocales` list specifies the locales that the app supports.
        ///
        /// - `Locale('en')`: English locale.
        /// - `Locale('th')`: Thai locale.
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('en'), // English
          Locale('th'), // Spanish
        ],
        home: const AppHome(),

        // TODO : AppRouter Blocc managing state
        routes: {
          AppRouter.home: (context) => const HomeScreen(),
          AppRouter.transaction: (context) => const TransactionsScreen(),
          AppRouter.plan: (context) => const PlanScreen(),
        },
      ),
    );
  }
}
