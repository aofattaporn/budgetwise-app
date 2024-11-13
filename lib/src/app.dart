import 'package:budget_wise/src/bloc/accounts/accounts_bloc.dart';
import 'package:budget_wise/src/bloc/plans/plans_bloc.dart';
import 'package:budget_wise/src/bloc/plan_month_picker/plan_month_picker_bloc.dart';
import 'package:budget_wise/src/bloc/transactions/transactions_bloc.dart';
import 'package:budget_wise/src/bloc/usersFin/usersfin_bloc.dart';
import 'package:budget_wise/src/home.dart';
import 'package:budget_wise/src/presentation/constant/router.dart';
import 'package:budget_wise/src/presentation/screens/home_screen/home_screen.dart';
import 'package:budget_wise/src/presentation/screens/plan_screen/plan_screen.dart';
import 'package:budget_wise/src/presentation/screens/transactions_screen/transactions_screen.dart';
import 'package:budget_wise/src/presentation/theme/color_scheme.dart';
import 'package:budget_wise/src/presentation/theme/icon_theme.dart';
import 'package:budget_wise/src/presentation/theme/text_theme.dart';
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
  final List<BlocProvider> _blocProviders = [
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
  ];

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: _blocProviders,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,

        /// Specifies the theme data for the application.
        ///
        /// This property is used to define the visual properties of the app, such as colors,
        /// fonts, and other styling elements. It allows for consistent theming across the
        /// entire application.
        title: 'Budget Wise',
        themeMode: ThemeMode.light,
        theme: ThemeData(
            textTheme: AppTextTheme.lightTextTheme,
            colorScheme: AppColorScheme.lightScheme,
            iconTheme: AppIconTheme.lightTheme,
            scaffoldBackgroundColor: const Color.fromRGBO(250, 250, 250, 1)),
        darkTheme: ThemeData(
            textTheme: AppTextTheme.darkTextTheme,
            colorScheme: AppColorScheme.darkScheme,
            iconTheme: AppIconTheme.darkTheme,
            scaffoldBackgroundColor: const Color.fromRGBO(0, 0, 0, 1)),

        /// The `localizationsDelegates` list contains delegates for various localization
        /// classes, which are responsible for providing localized resources for the app.
        ///
        /// - `GlobalMaterialLocalizations.delegate`: Provides localized strings and other
        ///   values for the Material Components library.
        /// - `GlobalWidgetsLocalizations.delegate`: Provides localized strings and other
        ///   values for the basic widget library.
        /// - `GlobalCupertinoLocalizations.delegate`: Provides localized strings and other
        ///   values for the Cupertino library.
        ///
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
        home: AppHome(),
        routes: {
          AppRouter.home: (context) => const HomeScreen(),
          AppRouter.transaction: (context) => const TransactionsScreen(),
          AppRouter.plan: (context) => const PlanScreen(), // Add this line
        },
      ),
    );
  }
}
