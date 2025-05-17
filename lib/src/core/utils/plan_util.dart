import 'package:budget_wise/src/domain/entities/plan_entity.dart';
import 'package:budget_wise/src/core/constant/business_constant.dart';
import 'package:budget_wise/src/domain/models/transaction_segment.dart';
import 'package:budget_wise/src/presentation/theme/system/app_colors.dart';

class PlanUtil {
  static List<TransactionsSegment> generatePlannTransactionSegment(
      PlanEntity? plan) {
    return [
      TransactionsSegment(
        segmentName: BusinessConstant.tranfersType,
        usage: 44000,
        color: AppColors.primaryDark,
      ),
      TransactionsSegment(
        segmentName: BusinessConstant.savingType,
        usage: 44000,
        color: AppColors.primary,
      ),
      TransactionsSegment(
        segmentName: BusinessConstant.unplannedType,
        usage: 44000,
        color: AppColors.primarySubtle,
      ),
    ];
  }
}
