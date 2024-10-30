import 'package:budget_wise/src/bloc/plans/plans_bloc.dart';
import 'package:budget_wise/src/bloc/plans/plans_state.dart';
import 'package:budget_wise/src/bloc/usersFin/usersfin_evenet.dart';
import 'package:budget_wise/src/bloc/usersFin/usersfin_state.dart';
import 'package:budget_wise/src/bloc/usersFin/usersfin_bloc.dart';
import 'package:budget_wise/src/presentation/screens/create_plan_sheet/create_plan_sheet.dart';
import 'package:budget_wise/src/presentation/screens/plan_screen/budget_monthyear/budget_monthyear_not_found.dart';
import 'package:budget_wise/src/presentation/screens/plan_screen/budget_monthyear/budget_monthyear_success.dart';
import 'package:budget_wise/src/presentation/screens/plan_screen/budget_monthyear/budget_monthyear_failure.dart';
import 'package:budget_wise/src/presentation/screens/plan_screen/budget_monthyear/budget_monthyear_loading.dart';
import 'package:budget_wise/src/presentation/ui/generic_txt_btn.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class PlanScreen extends StatefulWidget {
  const PlanScreen({super.key});

  @override
  State<PlanScreen> createState() => _PlanScreenState();
}

class _PlanScreenState extends State<PlanScreen> {
  DateTime? monthYear = DateTime.now();
  double currentTotalUsage = 0;
  double limitAmount = 0;

  @override
  void initState() {
    super.initState();
    monthYear = DateTime.now();
    const String format = 'yyyy-MM';
    context.read<UsersFinBloc>().add(
        GetSalaryEvent(monthYear: DateFormat(format).format(DateTime.now())));
  }

  void _popUpShowCreatePlan(
      BuildContext context, double currentTotalUsage, limitAmount) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return CreatePlanSheet(isEdit: false);
      },
    );
  }

  void _onDateSelected(DateTime newDate) {
    setState(() {
      monthYear = newDate;
    });
    String month = DateFormat('yyyy-MM').format(newDate);
    context.read<UsersFinBloc>().add(GetSalaryEvent(monthYear: month));
  }

  BlocListener _listenerUserfinState() {
    return BlocListener<UsersFinBloc, UsersFinState>(
      listener: (context, state) {
        if (state is GetSalaryAndMontYearSuccess) {
          setState(() {
            limitAmount = state.data.salary;
          });
        }
      },
    );
  }

  BlocListener _listenerPlanState() {
    return BlocListener<PlansBloc, PlansState>(
      listener: (context, state) {
        if (state is GetPlanSuccess) {
          setState(() {
            currentTotalUsage = state.totalPlanUsage;
          });
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        _listenerUserfinState(),
        _listenerPlanState(),
      ],
      child: SingleChildScrollView(
        clipBehavior: Clip.none,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _displayBudgetHeader(),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  /// Displays the budget header within a padded container.
  ///
  /// This method returns a [Padding] widget that contains the budget header
  /// for the plan screen. The padding ensures that the header is properly
  /// spaced within the layout.
  Padding _displayBudgetHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child:
          BlocBuilder<UsersFinBloc, UsersFinState>(builder: (context, state) {
        if (state is GetSalaryAndMontYearLoading) {
          return const BudgetLimitLabelLoading();
        } else if (state is GetSalaryAndMontYearSuccess) {
          return BudgetLimitLabel(
              onDateSelected: _onDateSelected,
              currentUsage: currentTotalUsage,
              limitBudgetPlan: state.data.salary,
              monthYear: monthYear!);
        } else if (state is GetSalaryAndMontYearFailure) {
          return BudgetMonthYearNotFound(
              errorMessage: state.error.errorMessage,
              onDateSelected: _onDateSelected,
              monthYear: monthYear!);
        } else {
          return const BudgetLimitLabelfailure();
        }
      }),
    );
  }

  /// Displays planning labels within a padded container.
  ///
  /// This widget method returns a [Padding] widget that contains
  /// the planning labels to be shown on the screen.
  ///
  /// The [context] parameter is used to access the current
  /// [BuildContext] for theming and other contextual information.
  ///
  /// - Parameters:
  ///   - context: The [BuildContext] in which the widget is built.
  Padding _displayPlanningHeader(BuildContext context) {
    String planningLabel = "My Planing";
    String creatingTitle = "+ Create Planning";

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            planningLabel,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          GenericTxtBTN(
            title: creatingTitle,
            handler: () =>
                {_popUpShowCreatePlan(context, currentTotalUsage, limitAmount)},
          ),
        ],
      ),
    );
  }
}
