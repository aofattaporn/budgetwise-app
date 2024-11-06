// ignore: file_names
import 'dart:convert' show jsonDecode;

import 'package:budget_wise/src/models/internal/general_error.dart';
import 'package:budget_wise/src/models/internal/general_response.dart';
import 'package:http/http.dart' as http;

class ResponseUtil {
  static const Map<String, String> CONTENT_TYPE_JSON = {
    'Content-Type': 'application/json',
  };

  static GeneralResponse decodeResponse(http.Response response) {
    final responseBody = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return GeneralResponse.fromJson(responseBody);
    } else {
      final generalError = GeneralError.fromJson(responseBody);
      throw GeneralError(
          code: generalError.code,
          timestamp: generalError.timestamp,
          errorMessage: generalError.errorMessage);
    }
  }
}
