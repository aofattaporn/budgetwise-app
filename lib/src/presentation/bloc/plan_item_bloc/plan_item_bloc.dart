import 'package:budget_wise/src/core/errors/bussiness_error.dart';
import 'package:budget_wise/src/domain/usecase/plan_item_usecase.dart';
import 'package:budget_wise/src/presentation/bloc/plan_item_bloc/plan_item_event.dart';
import 'package:budget_wise/src/presentation/bloc/plan_item_bloc/plan_item_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PlanItemBloc extends Bloc<PlanItemEvent, PlanItemState> {
  final PlanItemUsecase planItemUsecase;

  PlanItemBloc({required this.planItemUsecase}) : super(PlanItemInitial()) {
    on<FetchPlanItemEvent>(_onFetchPlanItem);
    on<AddPlanItemEvent>(_onAddPlanItemEvent);
    on<DeletePlanItemById>(_onDeletePlanIteById);
    on<UpdatePlanItemById>(_onEditPlanItemById);
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

  Future<void> _onAddPlanItemEvent(
      AddPlanItemEvent event, Emitter<PlanItemState> emit) async {
    emit(PlanItemLoading());

    try {
      final planItems =
          await planItemUsecase.createaNewPlanIte(event.planItemDto);

      emit(
        planItems.isEmpty ? PlanItemEmpty() : PlanItemLoaded(planItems),
      );
    } on BussinessError {
      emit(PlanItemIsOvering(
          "The budget exceeds the limit. Please reduce the amount."));
    } catch (error) {
      emit(PlanItemError(
          "An unexpected error occurred. Please try again later."));
    }
  }

  Future<void> _onDeletePlanIteById(
      DeletePlanItemById event, Emitter<PlanItemState> emit) async {
    emit(PlanItemLoading());

    try {
      final planItems = await planItemUsecase.deletePlanItemById(
          event.planItemId, event.planId);

      emit(
        planItems.isEmpty ? PlanItemEmpty() : PlanItemLoaded(planItems),
      );
    } catch (error) {
      emit(PlanItemError('Failed to fetch plan items: $error'));
    }
  }

  Future<void> _onEditPlanItemById(
      UpdatePlanItemById event, Emitter<PlanItemState> emit) async {
    emit(PlanItemLoading());

    try {
      final planItems = await planItemUsecase.updatePlanItemById(
          event.planItemId, event.planItemDto);

      emit(
        planItems.isEmpty ? PlanItemEmpty() : PlanItemLoaded(planItems),
      );
    } catch (error) {
      emit(PlanItemError('Failed to fetch plan items: $error'));
    }
  }
}
