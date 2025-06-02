import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:budget_wise/features/account/domain/usecases/account_usecase.dart';
import 'account_event.dart';
import 'account_state.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  final AccountUsecase accountUsecase;
  AccountBloc(this.accountUsecase) : super(AccountInitial()) {
    on<FetchAllAccounts>((event, emit) async {
      emit(AccountLoading());
      try {
        final accounts = await accountUsecase.getAllAccounts();
        emit(AccountLoaded(accounts));
      } catch (e) {
        emit(AccountError("Failed to load accounts"));
      }
    });

    on<CreateAccount>((event, emit) async {
      emit(AccountLoading());
      try {
        await accountUsecase.createAccount(event.dto);
        final accounts = await accountUsecase.getAllAccounts();
        emit(AccountLoaded(accounts));
      } catch (e) {
        emit(AccountError("Failed to create account"));
      }
    });

    on<UpdateAccount>((event, emit) async {
      emit(AccountLoading());
      try {
        await accountUsecase.updateAccount(event.dto);
        final accounts = await accountUsecase.getAllAccounts();
        emit(AccountLoaded(accounts));
      } catch (e) {
        emit(AccountError("Failed to update account"));
      }
    });

    on<DeleteAccount>((event, emit) async {
      emit(AccountLoading());
      try {
        await accountUsecase.deleteAccount(event.id);
        final accounts = await accountUsecase.getAllAccounts();
        emit(AccountLoaded(accounts));
      } catch (e) {
        emit(AccountError("Failed to delete account"));
      }
    });
  }
}
