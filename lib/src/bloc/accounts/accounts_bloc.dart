import 'package:bloc/bloc.dart';
import 'package:budget_wise/src/bloc/accounts/accounts_state.dart';
import 'package:budget_wise/src/bloc/accounts/accounts_event.dart';
import 'package:budget_wise/src/models/entity/budget_account_entity.dart';
import 'package:budget_wise/src/repositories/accoutns_repository.dart';

class AccountBloc extends Bloc<AccountsEvent, AccountState> {
  final AccountsRepository repository = AccountsRepository();
  List<BudgetAccountEntity>? accounts;

  // Constructor to initialize the AccountBloc with a repository
  AccountBloc() : super(InitialState()) {
    // Event handler for fetching all accounts
    on<GetAllAccountsEvent>((event, emit) async {
      emit(GetAllAccountsLoading());
      try {
        final data = await repository.fetchAllAccounts();
        accounts = data;
        emit(GetAllAccountsSuccess(data));
      } catch (error) {
        emit(GetAllAccountsFailure(error.toString()));
      }
    });

    // Event handler for creating a new account
    on<CreateAccountEvent>((event, emit) async {
      emit(GetAllAccountsLoading());
      try {
        // Call your repository to create the account
        await repository.createAccount(event.account);
        emit(CreateAccountSuccess());
      } catch (error) {
        emit(CreateAccountFailure(error.toString()));
      }
    });

    // Event handler for deleting a new account
    on<UpdateAccountByIdEvent>((event, emit) async {
      emit(GetAllAccountsLoading());
      try {
        await repository.updateAccountById(event.account);
        emit(UpdateAccountSuccess());
      } catch (error) {
        emit(UpdateAccountFailure(error.toString()));
      }
    });

    // Event handler for deleting a new account
    on<DeleteAccountsByIdEvent>((event, emit) async {
      emit(GetAllAccountsLoading());
      try {
        await repository.deleteAccountById(event.accountId);
        emit(DeleteAccountSuccess());
      } catch (error) {
        emit(DeleteAccountFailure(error.toString()));
      }
    });

    on<GetAllLocalAccountsEvent>((event, emit) async {
      if (accounts != null) {
        emit(GetAllLocalAccountsSuccess(this.accounts!));
        emit(GetAllAccountsSuccess(this.accounts!));
      }
    });
  }
}
