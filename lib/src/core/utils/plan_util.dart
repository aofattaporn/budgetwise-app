import 'package:budget_wise/src/common/theme/app_colors.dart';
import 'package:budget_wise/src/core/constant/business_constant.dart';
import 'package:budget_wise/src/domain/entities/plan_entity.dart';
import 'package:budget_wise/src/domain/models/transaction_segment.dart';

class PlanUtil {
  static List<TransactionsSegment> generatePlannTransactionSegment(
      PlanEntity? plan) {
    return [
      TransactionsSegment(
        segmentName: BusinessConstant.tranfersType,
        usage: plan?.summaryTranfer ?? 0,
        color: AppColors.priamryDark,
      ),
      TransactionsSegment(
        segmentName: BusinessConstant.savingType,
        usage: plan?.summarySaving ?? 0,
        color: AppColors.primary,
      ),
      TransactionsSegment(
        segmentName: BusinessConstant.unplannedType,
        usage: plan?.summaryOther ?? 0,
        color: AppColors.primarySubtle,
      ),
    ];
  }
}
