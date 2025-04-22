import 'package:budget_wise/src/core/log/logger_config.dart';
import 'package:logger/logger.dart';

class LoggerUtil {
  Logger datasourceLogger(String className) {
    return Logger(printer: LoggerConfig(className));
  }

  Logger usecaseLogger(String className) {
    return Logger(printer: LoggerConfig(className));
  }

  Logger presentationLogger(String className) {
    return Logger(printer: LoggerConfig(className));
  }

  Logger normalLogger(String className) {
    return Logger(printer: LoggerConfig(className));
  }
}
