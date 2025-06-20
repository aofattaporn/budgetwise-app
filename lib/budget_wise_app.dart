import 'package:budget_wise/features/plan/presentation/bloc/current_plan_boc/current_plan_boc.dart';
import 'package:budget_wise/features/plan/presentation/bloc/plan_all_bloc/plan_selector_bloc.dart';
import 'package:budget_wise/features/plan/presentation/bloc/plan_item_bloc/plan_item_bloc.dart';
import 'package:budget_wise/app_config/routes/app_routes.dart';
import 'package:budget_wise/app_config/routes/app_screens.dart';
import 'package:budget_wise/shared/constant/business_constant.dart';
import 'package:budget_wise/shared/constant/common_constant.dart';
import 'package:budget_wise/app_config/di/di.dart';
import 'package:budget_wise/app_config/start_up.dart';
import 'package:budget_wise/app_config/theme/modules/app_dark_theme.dart';
import 'package:budget_wise/app_config/theme/modules/app_light_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:budget_wise/features/account/presentation/bloc/account_bloc.dart';
import 'package:budget_wise/features/transaction/presentation/bloc/transaction_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await startUpConfigs();
  runApp(const BudgetWiseApp());
}

class BudgetWiseApp extends StatelessWidget {
  const BudgetWiseApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => sl<CurrentPlanBloc>()),
        BlocProvider(create: (_) => sl<PlanSelectorBloc>()),
        BlocProvider(create: (_) => sl<PlanItemBloc>()),
        BlocProvider(create: (_) => sl<AccountBloc>()),
        BlocProvider(create: (_) => sl<TransactionBloc>()),
        BlocProvider(create: (_) => ThemeCubit()),
      ],
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, themeMode) {
          return MaterialApp(
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
            theme: AppLightTheme.lightTheme,
            darkTheme: AppDarkTheme.darkTheme,
            themeMode: themeMode,
            initialRoute: AppRoutes.mainScreen,
            onGenerateRoute: AppPages.generateRoute,
          );
        },
      ),
    );
  }
}

class ThemeCubit extends Cubit<ThemeMode> {
  ThemeCubit() : super(ThemeMode.system);
  void toggleTheme() {
    emit(state == ThemeMode.light ? ThemeMode.dark : ThemeMode.light);
  }
}
