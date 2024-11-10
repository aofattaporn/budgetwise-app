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
import 'package:budget_wise/src/presentation/ui/generic_txt_btn.dart';
import 'package:budget_wise/src/utils/datetime_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class PlanScreen extends StatefulWidget {
  const PlanScreen({super.key});

  @override
  State<PlanScreen> createState() => _PlanScreenState();
}

class _PlanScreenState extends State<PlanScreen> {
  final MonthPickerBloc _monthPickerBloc = MonthPickerBloc();

  @override
  void initState() {
    super.initState();
    String monthYear = UtilsDateTime.yearMonthFormat(DateTime.now());
    context.read<UsersFinBloc>().add(GetSalaryEvent(monthYear: monthYear));
    context.read<PlansBloc>().add(GetPlansEvent(monthYear: monthYear));
    _monthPickerBloc.add(SetMonthPickerEvent(monthYear: DateTime.now()));
  }

  void _onDateSelected(DateTime newDate) {
    String month = UtilsDateTime.yearMonthFormat(newDate);
    context.read<UsersFinBloc>().add(GetSalaryEvent(monthYear: month));
    context.read<PlansBloc>().add(GetPlansEvent(monthYear: month));
    _monthPickerBloc.add(SetMonthPickerEvent(monthYear: newDate));
  }

  void _popUpShowCreatePlan(
      BuildContext context, double currentTotalUsage, limitAmount) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return CreatePlanSheet(
            isEdit: false, monthYear: _monthPickerBloc.monthYear);
      },
    ).whenComplete(
        () => context.read<PlansBloc>().add(GetCurrentSpendingEvent()));
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      clipBehavior: Clip.none,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _displayBudgetHeader(),
          _displayPlanningHeader(context),
          _displayPllanning()
        ],
      ),
    );
  }

  Row _displayMonthUsageAndSelectMonth(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextValue()
            .withText('Month for Budget plan:  ')
            .getFont12Black()
            .build(),
        GestureDetector(
          onTap: () => MonthYearPickerBuilder()
              .setInitialDate(_monthPickerBloc.monthYear)
              .setOnDateSelected(_onDateSelected)
              .build()
              .chooseDate(context),
          child: TextValue()
              .withText(
                  UtilsDateTime.monthYearFormat(_monthPickerBloc.monthYear))
              .getFont14BoldBlack()
              .build(),
        ),
      ],
    );
  }

  /// Displays the budget header within a padded container.
  Padding _displayBudgetHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child:
          BlocBuilder<UsersFinBloc, UsersFinState>(builder: (context, state) {
        if (state is GetSalaryAndMontYearLoading) {
          return const BudgetLimitLabelLoading();
        } else if (state is GetSalaryAndMontYearSuccess) {
          return BudgetLimitLabel(
              widget: _displayMonthUsageAndSelectMonth(context),
              onDateSelected: _onDateSelected,
              currentUsage: state.data.usages,
              limitBudgetPlan: state.data.salary,
              monthYear: _monthPickerBloc.monthYear);
        } else if (state is GetSalaryAndMontYearFailure) {
          return BudgetMonthYearNotFound(
              widget: _displayMonthUsageAndSelectMonth(context),
              onDateSelected: _onDateSelected,
              errorMessage: state.error.errorMessage,
              monthYear: _monthPickerBloc.monthYear);
        } else {
          return const BudgetLimitLabelfailure();
        }
      }),
    );
  }

  /// Displays planning labels within a padded container.
  Padding _displayPlanningHeader(BuildContext context) {
    String planningLabel = "My Planing";
    String creatingTitle = "+ Create Planning";

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextValue().withText(planningLabel).getFont16BoldBlack().build(),
          GenericTxtBTN(
            title: creatingTitle,
            handler: () => {_popUpShowCreatePlan(context, 0, 0)},
          ),
        ],
      ),
    );
  }

  /// Displays the budget header within a padded container.
  Padding _displayPllanning() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
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
}
