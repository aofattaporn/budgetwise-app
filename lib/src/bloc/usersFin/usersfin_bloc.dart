import 'package:budget_wise/src/bloc/usersFin/usersfin_state.dart';
import 'package:budget_wise/src/bloc/usersFin/usersfin_evenet.dart';
import 'package:budget_wise/src/models/internal/general_error.dart';
import 'package:budget_wise/src/models/entity/user_budget_info_entity.dart';
import 'package:budget_wise/src/repositories/users_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UsersFinBloc extends Bloc<UsersEvent, UsersFinState> {
  final UsersRepository usersRepository = UsersRepository();
  final double limitAmount = 0;

  // Global variables to hold shared data
  UserBudgetInfoEntity? userInfo;

  // Constructor to initialize the UsersBloc
  UsersFinBloc() : super(InitialState()) {
    /// Event handler for the `GetSalaryEvent`.
    ///
    /// This function listens for the `GetSalaryEvent` and performs the following actions:
    /// - Emits a `GetSalaryAndMontYearLoading` state to indicate that the salary and month-year data is being loaded.
    ///
    /// The function is asynchronous and uses the `emit` function to update the state.
    on<GetSalaryEvent>(_getSalaryEvent);

    /// Event handler for the `GetSalaryEvent`.
    ///
    /// This function listens for the `GetSalaryEvent` and performs the following actions:
    /// - Emits a `GetSalaryAndMontYearLoading` state to indicate that the salary and month-year data is being loaded.
    ///
    /// The function is asynchronous and uses the `emit` function to update the state.
    on<AddSalaryByMonthEvent>((event, emit) async {
      emit(GetSalaryAndMontYearLoading());
      try {
        final userReq = UserBudgetInfoEntity(
            salary: event.balance, month: event.monthYear, usages: 0);
        final data = await usersRepository.addNewSalaryByMonth(userReq);
        userInfo = data;
        emit(GetSalaryAndMontYearSuccess(data));
      } catch (error) {
        if (error is GeneralError) {
          emit(GetSalaryAndMontYearFailure(error));
        }
      }
    });

    // Example of accessing global data in another event
    /// Event handler for the `GetData` event.
    ///
    /// This method listens for the `GetData` event and triggers the corresponding
    /// actions to handle the event. It uses the `emit` function to update the state
    /// based on the event.
    ///
    /// Parameters:
    /// - `event`: The `GetData` event that was triggered.
    /// - `emit`: A function to emit new states.
    on<GetData>((event, emit) {
      if (userInfo != null) {
        emit(GetSalaryAndMontYearSuccess(userInfo!));
      }
    });
  }

  void _getSalaryEvent(
    GetSalaryEvent event,
    Emitter<UsersFinState> emit,
  ) async {
    emit(GetSalaryAndMontYearLoading());
    try {
      final data = await usersRepository.fetchAllAccounts(event.monthYear);
      userInfo = data;
      emit(GetSalaryAndMontYearSuccess(data));
    } catch (error) {
      if (error is GeneralError) {
        if (error.code == 1699) {
          emit(GetSalaryAndMontYearFailure(error));
        } else {
          emit(GetSalaryAndMontYearFailure(error));
        }
      }
    }
  }
}
