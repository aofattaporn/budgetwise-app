import 'package:budget_wise/src/common/routes/app_routes.dart';
import 'package:budget_wise/src/common/routes/app_screens.dart';
import 'package:budget_wise/src/common/theme/app_theme.dart';
import 'package:budget_wise/src/core/constant/business_constant.dart';
import 'package:budget_wise/src/core/constant/common_constant.dart';
import 'package:budget_wise/src/core/di/di.dart';
import 'package:budget_wise/src/core/start_up.dart';
import 'package:budget_wise/src/presentation/bloc/main_screen_bloc/main_screen_bloc.dart';
import 'package:budget_wise/src/presentation/bloc/plan_all_month_bloc/plan_all_month_bloc.dart';
import 'package:budget_wise/src/presentation/bloc/plan_bloc/plan_bloc.dart';
import 'package:budget_wise/src/presentation/bloc/plan_item_bloc/plan_item_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  await startUpConfigs();
  runApp(const BudgetWiseApp());
}

class BudgetWiseApp extends StatefulWidget {
  const BudgetWiseApp({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _BudgetWiseAppState createState() => _BudgetWiseAppState();
}

class _BudgetWiseAppState extends State<BudgetWiseApp> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => sl<MainScreenBloc>()),
        BlocProvider(create: (_) => sl<PlanBloc>()),
        BlocProvider(create: (_) => sl<PlanItemBloc>()),
        BlocProvider(create: (_) => sl<PlanAllMonthBloc>()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: BusinessConstant.titleBudgetWise,
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale(CommonConstant.accept_lang_en),
          Locale(CommonConstant.accept_lang_th),
        ],
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.system,
        initialRoute: AppRoutes.mainScreen,
        onGenerateRoute: AppPages.generateRoute,
      ),
    );
  }
}
