// ignore: file_names
import 'dart:convert' show jsonDecode;

import 'package:budget_wise/src/data/models/GeneralError.dart';
import 'package:budget_wise/src/data/models/GeneralResponse.dart';
import 'package:http/http.dart' as http;

class ResponseUtil {
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
