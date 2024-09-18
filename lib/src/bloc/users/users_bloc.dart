import 'package:budget_wise/src/bloc/users/users_evenet.dart';
import 'package:budget_wise/src/bloc/users/users_state.dart';
import 'package:budget_wise/src/data/repositories/users_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UsersBloc extends Bloc<UsersEvent, UsersState> {
  final UsersRepository usersRepository = UsersRepository();

  // Constructor to initialize the AccountBloc with a repository
  UsersBloc() : super(InitialState()) {
    // Event handler for fetching all accounts
    on<GetSalaryEvent>((event, emit) async {
      emit(GetSalaryAndDateResetLoading());
      try {
        final data = await usersRepository.fetchAllAccounts();
        emit(GetSalaryAndDateResetSuccess(data));
      } catch (error) {
        emit(GetSalaryAndDateResetFailure(error.toString()));
      }
    });
  }
}
