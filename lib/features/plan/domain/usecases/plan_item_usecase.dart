import 'package:budget_wise/core/errors/bussiness_error.dart';
import 'package:budget_wise/features/account/data/repositories/plan_repository_imp.dart';
import 'package:budget_wise/shared/constant/common_constant.dart';
import 'package:budget_wise/shared/utils/logger_util.dart';
import 'package:budget_wise/features/account/data/repositories/plan_item_repository_imp.dart';
import 'package:budget_wise/features/plan/data/models/plan_item_dto.dart';
import 'package:budget_wise/features/plan/data/models/plan_item_insert_dto.dart';
import 'package:logger/logger.dart';

class PlanItemUsecase {
  static final Logger _logger = LoggerUtil.normalLogger("PlanItemUsecase");

  final PlanItemRepository planItemRepository;
  final PlanRepository planRepository;
  PlanItemUsecase(
      {required this.planItemRepository, required this.planRepository});

  Future<List<PlanItemDto>> getItemsByPlanId(String planId) async {
    final result = await planItemRepository.getItemsByPlanId(planId);
    result.sort((a, b) => a.createdAt.compareTo(b.createdAt));
    _logger.d(
        "Fetched ${result.length} plan items: [${result.map((e) => e.name).join(", ")}]");
    return result;
  }

  Future<List<PlanItemDto>> getAllActivePlanItems() async {
    final result = await planItemRepository.getAllActivePlanItems();
    result.sort((a, b) => a.createdAt.compareTo(b.createdAt));
    _logger.d(
        "Fetched ${result.length} active plan items: [${result.map((e) => e.name).join(", ")}]");
    return result;
  }

  Future<void> createPlanItem(PlanItemInsertDto planItemDto) async {
    _logger.d("Create plan_item name: ${planItemDto.name}");

    final planId = planItemDto.planId;

    // check if plan is archived
    final planDto = await planRepository.getPlanByMonthId(planId);

    if (planDto == null) {
      _logger.e("Plan not found");
      throw Exception("Plan not found");
    }
    if (planDto.isArchived) {
      _logger.e("Plan is archived");
      throw Exception("Plan is archived");
    }

    // check limit of plan item
    final planItems = await planItemRepository.getItemsByPlanId(planId);
    final totalAmount =
        planItems.fold<double>(0, (sum, item) => sum + item.amountLimit);

    if (totalAmount + planItemDto.amountLimit > planDto.amountLimit) {
      _logger.e(
          "Plan item amount limit reached: $totalAmount + ${planItemDto.amountLimit} > ${planDto.amountLimit}");
      throw BussinessError(
        head: "Bussiness Error",
        desc: "Plan item amount limit reached",
        timestamp: DateTime.now(),
      );
    }

    await planItemRepository.createPlanItem(planItemDto);
  }

  Future<void> updatePlanItem(PlanItemDto planItemDto) async {
    _logger.d("Update plan_item name: ${planItemDto.name}");
    await planItemRepository.updatePlanItem(planItemDto);
  }

  Future<void> deletePlanItem(String planItemId) async {
    _logger.d("Delete plan_item id: $planItemId");
    await planItemRepository.deletePlanItem(planItemId);
  }
}
