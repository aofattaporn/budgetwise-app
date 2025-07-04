import 'package:budget_wise/domain/entities/account_enntity.dart';
import 'package:budget_wise/data/models/account_dto.dart';
import 'package:budget_wise/core/common/common_response.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:logger/logger.dart';
import '../../shared/utils/logger_util.dart';
import '../../shared/utils/response_util.dart';
import '../../shared/utils/error_util.dart';
import '../../shared/constant/response_constant.dart';

abstract class AccountDataSource {
  Future<CommonResponse<List<AccountEntity>>> fetchAllAccounts();
  Future<CommonResponse<AccountEntity?>> fetchAccountById(String id);
  Future<CommonResponse<void>> createAccount(AccountDto dto);
  Future<CommonResponse<void>> updateAccount(AccountDto dto);
  Future<CommonResponse<void>> deleteAccount(String id);
}

class AccountRemoteDataSourceImpl implements AccountDataSource {
  final SupabaseClient client;
  final Logger _logger = LoggerUtil.datasourceLogger("AccountRemote");

  AccountRemoteDataSourceImpl(this.client);

  @override
  Future<CommonResponse<List<AccountEntity>>> fetchAllAccounts() async {
    try {
      final response = await client.from('accounts').select();
      final accounts = response
          .map<AccountEntity>((e) => AccountEntity.fromJson(e))
          .toList();
      return ResponseUtil.commonResponse(ResponseConstant.code1000, accounts);
    } catch (e, s) {
      _logger.e("fetchAllAccounts", error: e, stackTrace: s);
      throw ErrorUtil.mapTechnicalError();
    }
  }

  @override
  Future<CommonResponse<AccountEntity?>> fetchAccountById(String id) async {
    try {
      final json =
          await client.from('accounts').select().eq('id', id).maybeSingle();
      if (json == null) {
        return ResponseUtil.commonError(
          code: ResponseConstant.code1799,
          data: null,
          desc: "No account found for id: $id",
        );
      }
      return ResponseUtil.commonResponse(
        ResponseConstant.code1000,
        AccountEntity.fromJson(json),
      );
    } catch (e, s) {
      _logger.e("fetchAccountById", error: e, stackTrace: s);
      throw ErrorUtil.mapTechnicalError();
    }
  }

  @override
  Future<CommonResponse<void>> createAccount(AccountDto dto) async {
    try {
      await client.from('accounts').insert(dto.toInsertJson());
      return ResponseUtil.commonResponse(ResponseConstant.code1000, null);
    } catch (e, s) {
      _logger.e("createAccount", error: e, stackTrace: s);
      throw ErrorUtil.mapTechnicalError();
    }
  }

  @override
  Future<CommonResponse<void>> updateAccount(AccountDto dto) async {
    try {
      await client
          .from('accounts')
          .update(dto.toUpdateJson())
          .eq('id', dto.id!);
      return ResponseUtil.commonResponse(ResponseConstant.code1000, null);
    } catch (e, s) {
      _logger.e("updateAccount", error: e, stackTrace: s);
      throw ErrorUtil.mapTechnicalError();
    }
  }

  @override
  Future<CommonResponse<void>> deleteAccount(String id) async {
    try {
      await client.from('accounts').delete().eq('id', id);
      return ResponseUtil.commonResponse(ResponseConstant.code1000, null);
    } catch (e, s) {
      _logger.e("deleteAccount", error: e, stackTrace: s);
      throw ErrorUtil.mapTechnicalError();
    }
  }
}
