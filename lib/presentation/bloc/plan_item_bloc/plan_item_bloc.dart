import 'package:budget_wise/core/errors/bussiness_error.dart';
import 'package:budget_wise/domain/usecases/plan_item_usecase.dart';
import 'package:budget_wise/presentation/bloc/plan_item_bloc/plan_item_event.dart';
import 'package:budget_wise/presentation/bloc/plan_item_bloc/plan_item_state.dart';
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

    on<FetchAllActivePlanItems>((event, emit) async {
      // emit(PlanItemLoading());
      try {
        final items = await planItemUsecase.getAllActivePlanItems();
        emit(PlanItemLoaded(items));
      } catch (e) {
        emit(PlanItemError("Failed to load all active plan items"));
      }
    });

    on<ResetPlanItemEmpty>((event, emit) async {
      emit(PlanItemResetAlreadyEmpty([]));
    });

    on<CreatePlanItem>((event, emit) async {
      final currentState = state;
      emit(PlanItemLoading());
      try {
        await planItemUsecase.createPlanItem(event.item);
        final items = await planItemUsecase.getItemsByPlanId(event.item.planId);
        emit(PlanItemLoaded(items));
      } on BussinessError catch (e) {
        emit(PlanItemError(e.desc));
        _onEmitOriginalState(emit, currentState, event.item.planId);
      } catch (e) {
        emit(PlanItemError("Failed to create plan item"));
        _onEmitOriginalState(emit, currentState, event.item.planId);
      }
    });

    on<UpdatePlanItem>((event, emit) async {
      final currentState = state;
      emit(PlanItemLoading());
      try {
        await planItemUsecase.updatePlanItem(event.item);

        final items = await planItemUsecase.getItemsByPlanId(event.item.planId);
        emit(PlanItemLoaded(items));
      } catch (e) {
        emit(PlanItemError("Failed to load plan items"));
        _onEmitOriginalState(emit, currentState, event.item.planId);
      }
    });

    on<DeletePlanItem>((event, emit) async {
      final currentState = state;
      emit(PlanItemLoading());
      try {
        await planItemUsecase.deletePlanItem(event.itemId);

        final items = await planItemUsecase.getItemsByPlanId(event.planId);
        emit(PlanItemLoaded(items));
      } catch (e) {
        emit(PlanItemError("Failed to load plan items"));
        _onEmitOriginalState(emit, currentState, event.planId);
      }
    });
  }

  void _onEmitOriginalState(
      Emitter<PlanItemState> emit, PlanItemState state, String planId) async {
    if (state is PlanItemLoaded) {
      emit(state);
    } else {
      final items = await planItemUsecase.getItemsByPlanId(planId);
      emit(PlanItemLoaded(items));
    }
  }
}
