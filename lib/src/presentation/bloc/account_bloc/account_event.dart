import 'package:budget_wise/features/account/data/models/account_dto.dart';

abstract class AccountEvent {}

class FetchAllAccounts extends AccountEvent {}

class CreateAccount extends AccountEvent {
  final AccountDto dto;
  CreateAccount(this.dto);
}

class UpdateAccount extends AccountEvent {
  final AccountDto dto;
  UpdateAccount(this.dto);
}

class DeleteAccount extends AccountEvent {
  final String id;
  DeleteAccount(this.id);
}
