import 'package:budget_wise/src/domain/models/common/common_response.dart';
import 'package:budget_wise/src/core/constant/response_constant.dart';

class ResponseUtil {
  ResponseUtil._();

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

  static CommonResponse<T> commonError<T>(int code, T data) {
    switch (code) {
      case ResponseConstant.code1999:
        return CommonResponse<T>(
          code: ResponseConstant.code1999,
          head: 'Success',
          desc: 'Request completed successfully',
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

  static T handleResponse<T>(dynamic response) {
    if (response.code == ResponseConstant.code1000) {
      return response.data;
    } else {
      throw Exception("Unexpected response code: ${response.code}");
    }
  }
}
