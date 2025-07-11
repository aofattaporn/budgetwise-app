import 'package:budget_wise/core/common/common_usecase.dart';
import 'package:budget_wise/data/models/plan_item_dto.dart';
import 'package:budget_wise/data/repositories/plan_item_repository_imp.dart';

class GetAllPlanItemByPlanid extends CommonUseCase<List<PlanItemDto>, String> {
  final PlanItemRepository planRepository;

  GetAllPlanItemByPlanid({required this.planRepository});

  @override
  Future<List<PlanItemDto>> call(String? planId) async {
    return await planRepository.getItemsByPlanId(planId!);
  }
}
