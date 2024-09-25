// events.dart
import 'package:budget_wise/src/data/models/account.dart';

sealed class AccountsEvent {}

// event: create account
final class CreateAccountEvent extends AccountsEvent {
  final Account account;
  CreateAccountEvent({required this.account});
}

// event: get all accounts
final class GetAllAccountsEvent extends AccountsEvent {}

// event: get all locals accounts
final class GetAllLocalAccountsEvent extends AccountsEvent {}

// event: delete accounts by id
final class DeleteAccountsByIdEvent extends AccountsEvent {
  final int accountId;
  DeleteAccountsByIdEvent({required this.accountId});
}

// event: update accounts by id
final class UpdateAccountByIdEvent extends AccountsEvent {
  final Account account;
  UpdateAccountByIdEvent({required this.account});
}
