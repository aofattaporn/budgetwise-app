import 'package:budget_wise/core/errors/bussiness_error.dart';
import 'package:budget_wise/core/errors/not_found_error.dart';
import 'package:budget_wise/core/errors/technical_error.dart';
import 'package:budget_wise/core/utils/logger_util.dart';
import 'package:budget_wise/src/domain/models/common/common_response.dart';
import 'package:budget_wise/core/constant/response_constant.dart';
import 'package:logger/logger.dart';

class ResponseUtil {
  ResponseUtil._();

  static final Logger _logger = LoggerUtil.normalLogger("ResponseUtil");

  static CommonResponse<T> commonResponse<T>(int code, T data) {
    switch (code) {
      case ResponseConstant.code1000:
        return CommonResponse<T>(
          code: ResponseConstant.code1000,
          head: 'Success',
          desc: 'Request completed successfully',
          data: data,
        );
      case ResponseConstant.code1899:
        return CommonResponse<T>(
          code: ResponseConstant.code1899,
          head: 'Business Error',
          desc: 'Unhandled response code',
          data: data,
        );
      case ResponseConstant.code1999:
        return CommonResponse<T>(
          code: ResponseConstant.code1999,
          head: 'Technical Error',
          desc: 'Unhandled response code',
          data: data,
        );
      default:
        return CommonResponse<T>(
          code: code,
          head: 'Unknown',
          desc: 'Unhandled response code',
          data: data,
        );
    }
  }

  static CommonResponse<T> commonError<T>({
    required int code,
    required T data,
    String? desc,
  }) {
    switch (code) {
      case ResponseConstant.code1999:
        return CommonResponse<T>(
          code: ResponseConstant.code1999,
          head: 'Technical Error',
          desc: desc ?? 'An unexpected technical issue occurred.',
          data: data,
        );
      case ResponseConstant.code1899:
        return CommonResponse<T>(
          code: ResponseConstant.code1899,
          head: 'Business Error',
          desc: desc ?? 'A business rule validation failed.',
          data: data,
        );
      case ResponseConstant.code1799:
        return CommonResponse<T>(
          code: ResponseConstant.code1799,
          head: 'Not Found Data',
          desc: desc ?? 'A not founde validation failed.',
          data: data,
        );
      default:
        return CommonResponse<T>(
          code: code,
          head: 'Unknown Error',
          desc: desc ?? 'Unhandled response code: $code',
          data: data,
        );
    }
  }

  static T handleResponse<T>(CommonResponse response) {
    //  not trown just map data sync on bloc
    if (response.code == ResponseConstant.code1000) {
      return response.data;
    }
    //  not trown just map data sync on bloc
    else if (response.code == ResponseConstant.code1799) {
      _logger.d('[Not Found Error]: ${response.desc}');
      throw NotfoundError(
          head: response.head, desc: response.desc, timestamp: DateTime.now());
    }
    // represent error by dialog
    else if (response.code == ResponseConstant.code1899) {
      _logger.e('[Business Error]: ${response.desc}');
      throw BussinessError(
          head: response.head, desc: response.desc, timestamp: DateTime.now());
    }
    // represent error by dialog
    else if (response.code == ResponseConstant.code1999) {
      _logger.e('[Technical Error]: ${response.desc}');
      throw TechnicalError(message: '', timestamp: DateTime.now());
    }
    // represent error by dialog
    else {
      throw Exception('Unexpected response code: ${response.code}');
    }
  }
}
