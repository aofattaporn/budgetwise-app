import 'package:budget_wise/domain/entities/transaction_entity.dart';
import 'package:budget_wise/data/models/transaction_dto.dart';
import 'package:budget_wise/core/common/common_response.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:logger/logger.dart';
import '../../shared/utils/logger_util.dart';
import '../../shared/utils/response_util.dart';
import '../../shared/utils/error_util.dart';
import '../../shared/constant/response_constant.dart';

abstract class TransactionDataSource {
  Future<CommonResponse<TransactionEntity?>> fetchTransactionByPlanId(
      String planId);

  Future<CommonResponse<List<TransactionEntity>>> fetchAllTransactions();
  Future<CommonResponse<TransactionEntity?>> fetchTransactionById(String id);
  Future<CommonResponse<void>> createTransaction(TransactionDto dto);
  Future<CommonResponse<void>> updateTransaction(TransactionDto dto);
  Future<CommonResponse<void>> deleteTransaction(String id);
}

class TransactionRemoteDataSourceImpl implements TransactionDataSource {
  final SupabaseClient client;
  final Logger _logger = LoggerUtil.datasourceLogger("TransactionRemote");

  TransactionRemoteDataSourceImpl({required this.client});

  @override
  Future<CommonResponse<TransactionEntity?>> fetchTransactionByPlanId(
      String planId) async {
    try {
      final json = await client
          .from('transactions')
          .select()
          .eq('plan_id', planId)
          .maybeSingle();
      if (json == null) {
        return ResponseUtil.commonError(
          code: ResponseConstant.code1799,
          data: null,
          desc: "No transaction found for id: $planId",
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
