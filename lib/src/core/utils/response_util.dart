import 'package:budget_wise/src/common/model/common_response.dart';
import 'package:budget_wise/src/core/constant/response_constant.dart';

class ResponseUtil {
  static CommonResponse<T> commonResponse<T>(int code, T data) {
    switch (code) {
      case ResponseConstant.code1000:
        return CommonResponse<T>(
          code: ResponseConstant.code1000,
          head: 'Success',
          desc: 'Request completed successfully',
          data: data,
        );
      // Add more cases as needed
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
}
