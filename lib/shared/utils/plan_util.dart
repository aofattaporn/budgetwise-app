import 'package:budget_wise/shared/constant/business_constant.dart';
import 'package:budget_wise/data/models/plan_dto.dart';
import 'package:budget_wise/data/models/transaction_segment.dart';
import 'package:budget_wise/app_config/theme/system/app_colors.dart';

class PlanUtil {
  static List<TransactionsSegment> generatePlannTransactionSegment(
      PlanDto? plan) {
    return [
      TransactionsSegment(
        segmentName: BusinessConstant.tranfersType,
        usage: 0,
        color: AppColors.primaryDark,
      ),
      TransactionsSegment(
        segmentName: BusinessConstant.savingType,
        usage: 0,
        color: AppColors.primary,
      ),
      TransactionsSegment(
        segmentName: BusinessConstant.unplannedType,
        usage: 0,
        color: AppColors.primarySubtle,
      ),
    ];
  }
}
