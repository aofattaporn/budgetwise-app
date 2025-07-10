import 'package:budget_wise/core/common/common_usecase.dart';
import 'package:budget_wise/data/models/plan_dto.dart';
import 'package:budget_wise/data/repositories/plan_repository_imp.dart';

class GetAllPlanUsecase extends CommonUseCase<List<PlanDto>, String> {
  final PlanRepository planRepository;

  GetAllPlanUsecase({required this.planRepository});

  @override
  Future<List<PlanDto>> call(String? params) {
    return planRepository.getAllPlans();
  }
}
