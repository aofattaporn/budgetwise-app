import 'package:bloc/bloc.dart';
import 'package:budget_wise/src/bloc/accounts/accounts_event.dart';
import 'package:budget_wise/src/bloc/accounts/accounts_state.dart';
import 'package:budget_wise/src/data/repositories/accoutns_repository.dart';

class AccountBloc extends Bloc<AccountsEvent, AccountState> {
  AccountsRepository repository = AccountsRepository();

  // Constructor to initialize the AccountBloc with a repository
  AccountBloc() : super(InitialState()) {
    // Event handler for fetching all accounts
    on<GetAllAccountsEvent>((event, emit) async {
      emit(GetAllAccountsLoading());
      try {
        final data = await repository.fetchAllAccounts();
        print(data);
        print("==============");
        emit(GetAllAccountsSuccess(data));
      } catch (error) {
        emit(GetAllAccountsFailure(error.toString()));
      }
    });

    // Event handler for creating a new account
    on<CreateAccountEvent>((event, emit) async {
      emit(CreateAccountLoading());
      try {
        // Call your repository to create the account
        // List<Account> accounts = await repository.createAccount(event.account);
        emit(CreateAccountSuccess());
      } catch (error) {
        emit(CreateAccountFailure(error.toString()));
      }
    });
  }
}
