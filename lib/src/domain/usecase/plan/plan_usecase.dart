import 'package:budget_wise/src/domain/entities/plan_entity.dart';
import 'package:budget_wise/src/domain/repositories/plan_repository.dart';

/// The main screen tab for displaying a plan-related view.
///
/// This widget displays various components, including:
/// - A segmented circular progress bar showing the usage of different segments.
/// - A summary container showing the details of transaction segments like "Transfers", "Savings", etc.
/// - A placeholder for a list of items related to the plan.
class PlanUsecase {
  final PlanRepository planRepository;
  PlanUsecase({required this.planRepository});

  Future<PlanEntity?> getPlanByCurrentMonth() async {
    return await planRepository.getPlanByIntervalTime(
        DateTime.now(), DateTime.now());
  }

  Future<List<PlanEntity>> getAllPlans() async {
    return await planRepository.getAllPlans();
  }
}
