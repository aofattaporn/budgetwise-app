import 'package:budget_wise/src/domain/entities/transaction_entity.dart';
import 'package:budget_wise/src/domain/models/transaction_dto.dart';
import 'package:budget_wise/src/domain/models/common/common_response.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:logger/logger.dart';
import '../../../../core/utils/logger_util.dart';
import '../../../../core/utils/response_util.dart';
import '../../../../core/utils/error_util.dart';
import '../../../../core/constant/response_constant.dart';

abstract class TransactionDataSource {
  Future<CommonResponse<List<TransactionEntity>>> fetchAllTransactions();
  Future<CommonResponse<TransactionEntity?>> fetchTransactionById(String id);
  Future<CommonResponse<void>> createTransaction(TransactionDto dto);
  Future<CommonResponse<void>> updateTransaction(TransactionDto dto);
  Future<CommonResponse<void>> deleteTransaction(String id);
}

class TransactionRemoteDataSourceImpl implements TransactionDataSource {
  final SupabaseClient client;
  final Logger _logger = LoggerUtil.datasourceLogger("TransactionRemote");

  TransactionRemoteDataSourceImpl(this.client);

  @override
  Future<CommonResponse<List<TransactionEntity>>> fetchAllTransactions() async {
    try {
      final response = await client.from('transactions').select();
      final transactions = response
          .map<TransactionEntity>((e) => TransactionEntity.fromJson(e))
          .toList();
      return ResponseUtil.commonResponse(
          ResponseConstant.code1000, transactions);
    } catch (e, s) {
      _logger.e("fetchAllTransactions", error: e, stackTrace: s);
      throw ErrorUtil.mapTechnicalError();
    }
  }

  @override
  Future<CommonResponse<TransactionEntity?>> fetchTransactionById(
      String id) async {
    try {
      final json =
          await client.from('transactions').select().eq('id', id).maybeSingle();
      if (json == null) {
        return ResponseUtil.commonError(
          code: ResponseConstant.code1799,
          data: null,
          desc: "No transaction found for id: $id",
        );
      }
      return ResponseUtil.commonResponse(
        ResponseConstant.code1000,
        TransactionEntity.fromJson(json),
      );
    } catch (e, s) {
      _logger.e("fetchTransactionById", error: e, stackTrace: s);
      throw ErrorUtil.mapTechnicalError();
    }
  }

  @override
  Future<CommonResponse<void>> createTransaction(TransactionDto dto) async {
    try {
      await client.from('transactions').insert(dto.toInsertJson());
      return ResponseUtil.commonResponse(ResponseConstant.code1000, null);
    } catch (e, s) {
      _logger.e("createTransaction", error: e, stackTrace: s);
      throw ErrorUtil.mapTechnicalError();
    }
  }

  @override
  Future<CommonResponse<void>> updateTransaction(TransactionDto dto) async {
    try {
      await client.from('transactions').update(dto.toJson()).eq('id', dto.id!);
      return ResponseUtil.commonResponse(ResponseConstant.code1000, null);
    } catch (e, s) {
      _logger.e("updateTransaction", error: e, stackTrace: s);
      throw ErrorUtil.mapTechnicalError();
    }
  }

  @override
  Future<CommonResponse<void>> deleteTransaction(String id) async {
    try {
      await client.from('transactions').delete().eq('id', id);
      return ResponseUtil.commonResponse(ResponseConstant.code1000, null);
    } catch (e, s) {
      _logger.e("deleteTransaction", error: e, stackTrace: s);
      throw ErrorUtil.mapTechnicalError();
    }
  }
}
