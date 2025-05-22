import 'package:budget_wise/src/domain/usecase/plan_item_usecase.dart';
import 'package:budget_wise/src/presentation/bloc/plan_item_bloc/plan_item_event.dart';
import 'package:budget_wise/src/presentation/bloc/plan_item_bloc/plan_item_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PlanItemBloc extends Bloc<PlanItemEvent, PlanItemState> {
  final PlanItemUsecase planItemUsecase;

  PlanItemBloc(this.planItemUsecase) : super(PlanItemInitial()) {
    on<FetchPlanItems>((event, emit) async {
      emit(PlanItemLoading());
      try {
        final items = await planItemUsecase.getItemsByPlanId(event.planId);
        emit(PlanItemLoaded(items));
      } catch (e) {
        emit(PlanItemError("Failed to load plan items"));
      }
    });
  }
}
