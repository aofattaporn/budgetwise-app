import 'package:budget_wise/src/core/constant/common_constant.dart';
import 'package:logger/logger.dart';

class LoggerConfig extends LogPrinter {
  final String className;

  LoggerConfig(this.className);

  @override
  List<String> log(LogEvent event) {
    final emoji = CommonConstant.levelEmojis[event.level];
    final message = event.message;
    final error = event.error;

    final logMessage = '$emoji [$className] - $message';

    if (error != null) {
      return ['$logMessage\n❗ ERROR: $error'];
    }

    return [logMessage];
  }
}
