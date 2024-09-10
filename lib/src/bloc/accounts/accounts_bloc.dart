import 'package:bloc/bloc.dart';
import 'package:budget_wise/src/bloc/accounts/accounts_event.dart';
import 'package:budget_wise/src/bloc/accounts/accounts_state.dart';
import 'package:budget_wise/src/data/repositories/accoutns_repository.dart';

class AccountBloc extends Bloc<AccountsEvent, AccountState> {
  final AccountsRepository repository;

  // Constructor to initialize the AccountBloc with a repository
  AccountBloc(this.repository) : super(InitialState()) {
    // Event handler for fetching all accounts
    on<GetAllAccountsEvent>((event, emit) async {
      emit(GetAllAccountsLoading());
      try {
        final data = await repository.getAllDataThatMeetsRequirements();
        emit(GetAllAccountsSuccess(data));
      } catch (error) {
        emit(GetAllAccountsFailure(error.toString()));
      }
    });

    // Event handler for creating a new account
    on<CreateAccountEvent>((event, emit) async {
      emit(CreateAccountLoading());
    });
  }
}
