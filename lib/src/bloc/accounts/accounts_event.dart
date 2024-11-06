// events.dart
import 'package:budget_wise/src/models/entity/budget_account_entity.dart';

sealed class AccountsEvent {}

// event: create account
final class CreateAccountEvent extends AccountsEvent {
  final BudgetAccountEntity account;
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
  final BudgetAccountEntity account;
  UpdateAccountByIdEvent({required this.account});
}
