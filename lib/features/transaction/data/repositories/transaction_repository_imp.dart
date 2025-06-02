import 'package:budget_wise/features/transaction/data/datasources/transaction_datasource.dart';
import 'package:budget_wise/src/domain/entities/transaction_entity.dart';
import 'package:budget_wise/src/domain/models/transaction_dto.dart';

abstract class TransactionRepository {
  Future<List<TransactionDto>> getAllTransactions();
  Future<TransactionDto?> getTransactionById(String id);
  Future<void> createTransaction(TransactionDto dto);
  Future<void> updateTransaction(TransactionDto dto);
  Future<void> deleteTransaction(String id);
}

class TransactionRepositoryImp implements TransactionRepository {
  final TransactionDataSource dataSource;
  TransactionRepositoryImp({required this.dataSource});

  @override
  Future<List<TransactionDto>> getAllTransactions() async {
    final response = await dataSource.fetchAllTransactions();
    final List<TransactionEntity> rawList = response.data;
    return rawList.map(TransactionDto.fromEntity).toList();
  }

  @override
  Future<TransactionDto?> getTransactionById(String id) async {
    final response = await dataSource.fetchTransactionById(id);
    final entity = response.data;
    return entity != null ? TransactionDto.fromEntity(entity) : null;
  }

  @override
  Future<void> createTransaction(TransactionDto dto) async {
    await dataSource.createTransaction(dto);
  }

  @override
  Future<void> updateTransaction(TransactionDto dto) async {
    await dataSource.updateTransaction(dto);
  }

  @override
  Future<void> deleteTransaction(String id) async {
    await dataSource.deleteTransaction(id);
  }
}
