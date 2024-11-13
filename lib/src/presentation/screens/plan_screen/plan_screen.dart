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
import 'package:budget_wise/src/presentation/theme/padding_scheme.dart';
import 'package:budget_wise/src/presentation/ui/generic_txt_btn.dart';
import 'package:budget_wise/src/utils/datetime_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PlanScreen extends StatelessWidget {
  const PlanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final MonthPickerBloc monthPickerBloc = MonthPickerBloc();
    String monthYear = UtilsDateTime.yearMonthFormat(DateTime.now());
    context.read<UsersFinBloc>().add(GetSalaryEvent(monthYear: monthYear));
    context.read<PlansBloc>().add(GetPlansEvent(monthYear: monthYear));
    monthPickerBloc.add(SetMonthPickerEvent(monthYear: DateTime.now()));

    void onMonthYearPicked(DateTime newDate) {
      String month = UtilsDateTime.yearMonthFormat(newDate);
      context.read<UsersFinBloc>().add(GetSalaryEvent(monthYear: month));
      context.read<PlansBloc>().add(GetPlansEvent(monthYear: month));
      monthPickerBloc.add(SetMonthPickerEvent(monthYear: newDate));
    }

    void showCreatePlanModal(
        BuildContext context, double currentTotalUsage, limitAmount) {
      showModalBottomSheet<void>(
        context: context,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return CreatePlanSheet(
              isEdit: false, monthYear: monthPickerBloc.monthYear);
        },
      ).whenComplete(
          () => context.read<PlansBloc>().add(GetCurrentSpendingEvent()));
    }

    Row buildMonthUsageSelectionRow(context) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Month for Budget plan:  ',
              style: Theme.of(context).textTheme.bodySmall),
          GestureDetector(
            onTap: () => MonthYearPickerBuilder()
                .setInitialDate(monthPickerBloc.monthYear)
                .setOnDateSelected(onMonthYearPicked)
                .build()
                .chooseDate(context),
            child: Text(
                UtilsDateTime.monthYearFormat(monthPickerBloc.monthYear),
                style: Theme.of(context).textTheme.headlineSmall),
          ),
        ],
      );
    }

    Padding buildBudgetHeader() {
      return Padding(
        padding: AppPaddingScheme.horizontalMedium,
        child:
            BlocBuilder<UsersFinBloc, UsersFinState>(builder: (context, state) {
          if (state is GetSalaryAndMontYearLoading) {
            return const BudgetLimitLabelLoading();
          } else if (state is GetSalaryAndMontYearSuccess) {
            return BudgetLimitLabel(
                widget: buildMonthUsageSelectionRow(context),
                onDateSelected: onMonthYearPicked,
                currentUsage: state.data.usages,
                limitBudgetPlan: state.data.salary,
                monthYear: monthPickerBloc.monthYear);
          } else if (state is GetSalaryAndMontYearFailure) {
            return BudgetMonthYearNotFound(
                widget: buildMonthUsageSelectionRow(context),
                onDateSelected: onMonthYearPicked,
                errorMessage: state.error.errorMessage,
                monthYear: monthPickerBloc.monthYear);
          } else {
            return const BudgetLimitLabelfailure();
          }
        }),
      );
    }

    Padding buildPlanningHeader(BuildContext context) {
      String planningLabel = "My Planing";
      String creatingTitle = "+ Create Planning";

      return Padding(
        padding: AppPaddingScheme.horizontalMedium,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextValue().withText(planningLabel).getFont16BoldBlack().build(),
            GenericTxtBTN(
              title: creatingTitle,
              handler: () => {showCreatePlanModal(context, 0, 0)},
            ),
          ],
        ),
      );
    }

    Padding buildPlanningSection() {
      return Padding(
        padding: AppPaddingScheme.horizontalMedium,
        child: BlocBuilder<PlansBloc, PlansState>(builder: (context, state) {
          if (state is SetPlanDataComplete) {
            return DisplayPlansSuccess(
              itemsTranfers: state.plansTranfer,
              itemsSaving: state.plansSaving,
            );
          } else if (state is PlanLoadingProcess) {
            return const DisplayPlansLoading();
          } else {
            return const DisplayPlansFaillure();
          }
        }),
      );
    }

    return SingleChildScrollView(
      clipBehavior: Clip.none,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          buildBudgetHeader(),
          buildPlanningHeader(context),
          buildPlanningSection()
        ],
      ),
    );
  }
}
