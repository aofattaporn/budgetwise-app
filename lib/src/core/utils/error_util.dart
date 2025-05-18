import 'package:budget_wise/src/core/errors/bussiness_error.dart';
import 'package:budget_wise/src/core/errors/technical_error.dart';

class ErrorUtil {
  ErrorUtil._();

  static const String defaultBusinessErrorMessage =
      "An unexpected business error occurred.";
  static const String defaultBusinessErrorDescription =
      "Something went wrong while processing the business logic.";
  static const String defaultErrorDescription =
      "An unknown error has occurred.";
  static const String defaultErrorMessage = "An unexpected error occurred.";

  static BussinessError mapBusinessError({
    String? message,
    String? desc,
  }) {
    return BussinessError(
      head: message ?? defaultBusinessErrorMessage,
      desc: desc ?? defaultBusinessErrorDescription,
      timestamp: DateTime.now(),
    );
  }

  static TechnicalError mapTechnicalError({
    String? message,
  }) {
    return TechnicalError(
        message: defaultErrorDescription, timestamp: DateTime.now());
  }
}
