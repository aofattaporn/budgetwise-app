import 'package:budget_wise/src/common/theme/app_colors.dart';
import 'package:budget_wise/src/common/theme/app_padding.dart';
import 'package:budget_wise/src/common/theme/app_shadow.dart';
import 'package:budget_wise/src/common/theme/app_text_style.dart';
import 'package:budget_wise/src/core/constant/business_constant.dart';
import 'package:budget_wise/src/domain/entities/plan_entity.dart';
import 'package:budget_wise/src/domain/models/transaction_segment.dart';
import 'package:budget_wise/src/presentation/bloc/plan_bloc/plan_bloc.dart';
import 'package:budget_wise/src/presentation/bloc/plan_bloc/plan_event.dart';
import 'package:budget_wise/src/presentation/bloc/plan_bloc/plan_state.dart';
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
    context.read<PlanBloc>().add(FetchAllPlans());
  }

  List<TransactionsSegment> generateSacment(PlanEntity plan) {
    return [
      TransactionsSegment(
        segmentName: BusinessConstant.tranfersType,
        usage: plan.summaryTranfer,
        color: AppColors.priamryDark,
      ),
      TransactionsSegment(
        segmentName: BusinessConstant.savingType,
        usage: plan.summarySaving,
        color: AppColors.primary,
      ),
      TransactionsSegment(
        segmentName: BusinessConstant.notPlanType,
        usage: plan.summaryOther,
        color: AppColors.primarySubtle,
      ),
    ];
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
    return BlocBuilder<PlanBloc, PlanState>(builder: (context, state) {
      final isSuccess = state is AllPlanLoaded ? true : false;
      return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: isSuccess ? state.plans.length : 0,
        itemBuilder: (context, index) {
          return Container(
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
                    const Text("12 May - 14 Jun",
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
                    transactionsSegment: generateSacment(isSuccess
                        ? state.plans[index]
                        : PlanEntity(
                            id: 0,
                            startDate: DateTime.now(),
                            endDate: DateTime.now(),
                            totalBudget: 0,
                            createAt: DateTime.now(),
                            summaryTranfer: 0,
                            summarySaving: 0,
                            summaryOther: 0)),
                    limitSalary: isSuccess ? state.plans[index].totalBudget : 1,
                    isSuccess: true,
                    isNotfound: false,
                    isShowMessage: false,
                  ),
                ),
              ],
            ),
          );
        },
      );
    });
  }
}
