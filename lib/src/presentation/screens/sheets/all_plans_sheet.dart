import 'package:budget_wise/src/common/theme/app_padding.dart';
import 'package:budget_wise/src/common/theme/app_shadow.dart';
import 'package:budget_wise/src/common/theme/app_text_style.dart';
import 'package:budget_wise/src/core/utils/datetime_util.dart';
import 'package:budget_wise/src/core/utils/plan_util.dart';
import 'package:budget_wise/src/presentation/bloc/plan_all_month_bloc/plan_all_month_bloc.dart';
import 'package:budget_wise/src/presentation/bloc/plan_all_month_bloc/plan_all_month_event.dart';
import 'package:budget_wise/src/presentation/bloc/plan_all_month_bloc/plan_all_month_state.dart';
import 'package:budget_wise/src/presentation/bloc/plan_bloc/plan_bloc.dart';
import 'package:budget_wise/src/presentation/bloc/plan_bloc/plan_event.dart';
import 'package:budget_wise/src/presentation/widgets/amount_compare.dart';
import 'package:budget_wise/src/presentation/widgets/segmented_circular_progress.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AllPlansSheet extends StatefulWidget {
  const AllPlansSheet({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AllPlansSheetState createState() => _AllPlansSheetState();
}

class _AllPlansSheetState extends State<AllPlansSheet> {
  @override
  void initState() {
    super.initState();
    context.read<PlanAllMonthBloc>().add(FetchAllPlans());
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 16),
        const Text(
          "All Plans",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 12),
        Expanded(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                _buildListItems(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildListItems() {
    return BlocBuilder<PlanAllMonthBloc, PlanAllMonthState>(
        builder: (context, state) {
      final isSuccess = state is AllPlanLoaded ? true : false;
      return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: isSuccess ? state.plans.length : 0,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => {
              context.read<PlanBloc>().add(FetchtPlanByMId(
                    id: isSuccess ? state.plans[index].id : 0,
                  )),
              Navigator.pop(context)
            },
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 6),
              padding: AppPadding.allxl,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: AppShadow.lg,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          '${UtilsDateTime.monthYearFormat(isSuccess ? state.plans[index].startDate : DateTime.now())} - ${UtilsDateTime.monthYearFormat(isSuccess ? state.plans[index].endDate : DateTime.now())}',
                          style: AppTextStyles.labelGraySmall),
                      AmountCompare(
                          isLarge: false,
                          usage: 500,
                          limitAmount:
                              isSuccess ? state.plans[index].totalBudget : 1),
                    ],
                  ),
                  const SizedBox(width: 16),
                  const Spacer(),
                  Expanded(
                    child: MultiSegmentCircularProgress(
                      size: 80,
                      strokeWidth: 6,
                      transactionsSegment:
                          PlanUtil.generatePlannTransactionSegment(
                              isSuccess ? state.plans[index] : null),
                      limitSalary:
                          isSuccess ? state.plans[index].totalBudget : 1,
                      isSuccess: true,
                      isNotfound: false,
                      isShowMessage: false,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    });
  }
}
