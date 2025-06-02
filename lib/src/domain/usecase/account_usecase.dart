import 'package:budget_wise/src/domain/models/account_dto.dart';
import 'package:budget_wise/features/account/data/repositories/account_repository_imp.dart';

class AccountUsecase {
  final AccountRepository accountRepository;
  AccountUsecase({required this.accountRepository});

  Future<List<AccountDto>> getAllAccounts() async {
    return await accountRepository.getAllAccounts();
  }

  Future<AccountDto?> getAccountById(String id) async {
    return await accountRepository.getAccountById(id);
  }

  Future<void> createAccount(AccountDto dto) async {
    await accountRepository.createAccount(dto);
  }

  Future<void> updateAccount(AccountDto dto) async {
    await accountRepository.updateAccount(dto);
  }

  Future<void> deleteAccount(String id) async {
    await accountRepository.deleteAccount(id);
  }
}
