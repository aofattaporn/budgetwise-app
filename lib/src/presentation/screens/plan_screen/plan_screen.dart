import 'package:budget_wise/src/bloc/plans/plans_bloc.dart';
import 'package:budget_wise/src/bloc/plans/plans_event.dart';
import 'package:budget_wise/src/bloc/plans/plans_state.dart';
import 'package:budget_wise/src/bloc/plan_month_picker/plan_month_picker_bloc.dart';
import 'package:budget_wise/src/bloc/plan_month_picker/plan_month_picker_event.dart';
import 'package:budget_wise/src/bloc/usersFin/usersfin_evenet.dart';
import 'package:budget_wise/src/bloc/usersFin/usersfin_state.dart';
import 'package:budget_wise/src/bloc/usersFin/usersfin_bloc.dart';
import 'package:budget_wise/src/presentation/constant/textstyle.dart';
import 'package:budget_wise/src/presentation/screens/plan_screen/%5Bsheet%5D_create_plan_sheet/create_plan_sheet.dart';
import 'package:budget_wise/src/presentation/screens/plan_screen/budget_monthyear/budget_monthyear_not_found.dart';
import 'package:budget_wise/src/presentation/screens/plan_screen/budget_monthyear/budget_monthyear_success.dart';
import 'package:budget_wise/src/presentation/screens/plan_screen/budget_monthyear/budget_monthyear_failure.dart';
import 'package:budget_wise/src/presentation/screens/plan_screen/budget_monthyear/budget_monthyear_loading.dart';
import 'package:budget_wise/src/presentation/screens/plan_screen/display_plans/display_plans_faillure.dart';
import 'package:budget_wise/src/presentation/screens/plan_screen/display_plans/display_plans_loading.dart';
import 'package:budget_wise/src/presentation/screens/plan_screen/display_plans/display_plans_success.dart';
import 'package:budget_wise/src/presentation/screens/plan_screen/month_year_picker/month_year_picker.dart';
import 'package:budget_wise/src/presentation/theme/color_scheme.dart';
import 'package:budget_wise/src/presentation/theme/padding_scheme.dart';
import 'package:budget_wise/src/presentation/ui/generic_txt_btn.dart';
import 'package:budget_wise/src/presentation/widgets/progress_bar/progress_bar.dart';
import 'package:budget_wise/src/utils/datetime_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PlanScreen extends StatelessWidget {
  const PlanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final MonthPickerBloc monthPickerBloc = MonthPickerBloc();
    final UsersFinBloc usersFinBloc = UsersFinBloc();

    String initialMonthYear = UtilsDateTime.yearMonthFormat(DateTime.now());

    // Initialize default state
    context.read<PlansBloc>().add(GetPlansEvent(monthYear: initialMonthYear));
    monthPickerBloc.add(SetMonthPickerEvent(monthYear: DateTime.now()));

    return SingleChildScrollView(
      clipBehavior: Clip.none,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            width: MediaQuery.of(context).size.width,
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "June 2024",
                  style: TextStyle(
                      fontSize: 16, color: AppColorScheme.onBackground),
                ),
                Text(
                  "3000 B",
                  style: TextStyle(
                      fontSize: 32,
                      color: AppColorScheme.onBackground,
                      fontWeight: FontWeight.bold),
                ),
                ProgressBar(isFullSize: false, progress: 0)
              ],
            ),
          )
        ],
      ),
    );
  }
}
