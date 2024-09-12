// states.dart
import 'package:budget_wise/src/data/models/account.dart';

sealed class AccountState {}

// Initial state when nothing has happened yet
final class InitialState extends AccountState {}

// state : get all accounts
final class GetAllAccountsSuccess extends AccountState {
  final List<Account> data;
  GetAllAccountsSuccess(this.data);
}

final class GetAllAccountsLoading extends AccountState {
  GetAllAccountsLoading();
}

final class GetAllAccountsFailure extends AccountState {
  final String error;
  GetAllAccountsFailure(this.error);
}

// state : create a account
final class CreateAccountSuccess extends AccountState {
  CreateAccountSuccess();
}

final class CreateAccountLoading extends AccountState {
  CreateAccountLoading();
}

final class CreateAccountFailure extends AccountState {
  final String error;
  CreateAccountFailure(this.error);
}

final class DeleteAccountSuccess extends AccountState {
  DeleteAccountSuccess();
}

final class DeleteAccountFailure extends AccountState {
  final String error;
  DeleteAccountFailure(this.error);
}
