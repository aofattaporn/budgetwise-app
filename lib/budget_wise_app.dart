import 'package:budget_wise/app_config/di/bloc_di/bloc_di.dart';
import 'package:budget_wise/app_config/routes/app_routes.dart';
import 'package:budget_wise/app_config/routes/app_screens.dart';
import 'package:budget_wise/shared/constant/business_constant.dart';
import 'package:budget_wise/shared/constant/common_constant.dart';
import 'package:budget_wise/app_config/start_up.dart';
import 'package:budget_wise/app_config/theme/modules/app_dark_theme.dart';
import 'package:budget_wise/app_config/theme/modules/app_light_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

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
      providers: getBlocProviders(),
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
