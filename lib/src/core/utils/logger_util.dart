import 'package:budget_wise/src/core/log/logger_config.dart';
import 'package:budget_wise/src/core/log/logger_datasource_config.dart';
import 'package:logger/logger.dart' as pretty_logger;

class LoggerUtil {
  LoggerUtil._();

  static pretty_logger.Logger datasourceLogger(String className) {
    return pretty_logger.Logger(printer: LoggerDatasourceConfig(className));
  }

  static pretty_logger.Logger usecaseLogger(String className) {
    return pretty_logger.Logger(printer: LoggerConfig(className));
  }

  static pretty_logger.Logger presentationLogger(String className) {
    return pretty_logger.Logger(printer: LoggerConfig(className));
  }

  static pretty_logger.Logger normalLogger(String className) {
    return pretty_logger.Logger(
        printer: LoggerConfig(className),
        output: pretty_logger.ConsoleOutput());
  }
}
