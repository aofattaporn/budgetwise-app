import 'package:budget_wise/src/core/constant/response_constant.dart';
import 'package:budget_wise/src/core/utils/error_util.dart';
import 'package:budget_wise/src/core/utils/logger_util.dart';
import 'package:budget_wise/src/core/utils/response_util.dart';
import 'package:budget_wise/src/domain/entities/transaction_entity.dart';
import 'package:budget_wise/src/domain/models/common/common_response.dart';
import 'package:logger/logger.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class TransactionDatasource {
  Future<CommonResponse<List<TransactionEntity>?>> fetchTransactionByPlanId(
      String planId);
}

class TransactionDatasourceImpl implements TransactionDatasource {
  final SupabaseClient client;
  final Logger _logger = LoggerUtil.datasourceLogger("PlanRemote");

  TransactionDatasourceImpl({required this.client});

  @override
  Future<CommonResponse<List<TransactionEntity>?>> fetchTransactionByPlanId(
      String planId) async {
    try {
      return ResponseUtil.commonResponse(ResponseConstant.code1000, []);
    } catch (e, s) {
      _logger.e("fetchTransactionByPlanId", error: e, stackTrace: s);
      throw ErrorUtil.mapTechnicalError();
    }
  }
}
