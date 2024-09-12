// events.dart
import 'package:budget_wise/src/data/models/account.dart';

sealed class AccountsEvent {}

// Define your specific event(s)
final class CreateAccountEvent extends AccountsEvent {
  final Account account;

  CreateAccountEvent({required this.account});
}

final class GetAllAccountsEvent extends AccountsEvent {}

final class DeleteAccountsByIdEvent extends AccountsEvent {
  final int accountId;
  DeleteAccountsByIdEvent({required this.accountId});
}
