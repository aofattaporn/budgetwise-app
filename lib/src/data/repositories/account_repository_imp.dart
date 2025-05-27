import 'package:budget_wise/src/data/datasources/account_datasource.dart';
import 'package:budget_wise/src/domain/entities/account_enntity.dart';
import 'package:budget_wise/src/domain/models/account_dto.dart';

abstract class AccountRepository {
  Future<List<AccountDto>> getAllAccounts();
  Future<AccountDto?> getAccountById(String id);
  Future<void> createAccount(AccountDto dto);
  Future<void> updateAccount(AccountDto dto);
  Future<void> deleteAccount(String id);
}

class AccountRepositoryImp implements AccountRepository {
  final AccountDataSource dataSource;
  AccountRepositoryImp({required this.dataSource});

  @override
  Future<List<AccountDto>> getAllAccounts() async {
    final response = await dataSource.fetchAllAccounts();
    final List<AccountEntity> rawList = response.data ?? [];
    return rawList.map(AccountDto.fromEntity).toList();
  }

  @override
  Future<AccountDto?> getAccountById(String id) async {
    final response = await dataSource.fetchAccountById(id);
    final entity = response.data;
    return entity != null ? AccountDto.fromEntity(entity) : null;
  }

  @override
  Future<void> createAccount(AccountDto dto) async {
    await dataSource.createAccount(dto);
  }

  @override
  Future<void> updateAccount(AccountDto dto) async {
    await dataSource.updateAccount(dto);
  }

  @override
  Future<void> deleteAccount(String id) async {
    await dataSource.deleteAccount(id);
  }
}
