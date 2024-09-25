import 'package:budget_wise/src/bloc/users/users_evenet.dart';
import 'package:budget_wise/src/bloc/users/users_state.dart';
import 'package:budget_wise/src/data/models/userInfo.dart';
import 'package:budget_wise/src/data/repositories/users_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UsersBloc extends Bloc<UsersEvent, UsersState> {
  final UsersRepository usersRepository = UsersRepository();

  // Global variables to hold shared data
  UserInfo? userInfo;

  // Constructor to initialize the UsersBloc
  UsersBloc() : super(InitialState()) {
    // Event handler for fetching salary and date reset
    on<GetSalaryEvent>((event, emit) async {
      emit(GetSalaryAndDateResetLoading());
      try {
        final data = await usersRepository.fetchAllAccounts();
        userInfo = data;

        emit(GetSalaryAndDateResetSuccess(data));
      } catch (error) {
        emit(GetSalaryAndDateResetFailure(error.toString()));
      }
    });

    // Example of accessing global data in another event
    on<GetData>((event, emit) {
      if (userInfo != null) {
        emit(GetSalaryAndDateResetSuccess(userInfo!));
      }
    });
  }
}
