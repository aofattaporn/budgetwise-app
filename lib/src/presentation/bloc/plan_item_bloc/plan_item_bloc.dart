import 'package:budget_wise/src/domain/usecase/plan_item_usecase.dart';
import 'package:budget_wise/src/presentation/bloc/plan_item_bloc/plan_item_event.dart';
import 'package:budget_wise/src/presentation/bloc/plan_item_bloc/plan_item_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PlanItemBloc extends Bloc<PlanItemEvent, PlanItemState> {
  final PlanItemUsecase planItemUsecase;

  PlanItemBloc({required this.planItemUsecase}) : super(PlanItemInitial()) {
    on<FetchPlanItemEvent>(_onFetchPlanItem);
  }

  Future<void> _onFetchPlanItem(
      FetchPlanItemEvent event, Emitter<PlanItemState> emit) async {
    emit(PlanItemLoading());

    try {
      final planItems =
          await planItemUsecase.getPlanByCurrentMonth(event.planId);

      emit(
        planItems.isEmpty ? PlanItemEmpty() : PlanItemLoaded(planItems),
      );
    } catch (error) {
      emit(PlanItemError('Failed to fetch plan items: $error'));
    }
  }
}
