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
    final stackTrace = event.stackTrace;

    final timestamp = DateTime.now().toIso8601String();

    final buffer = StringBuffer()
      ..writeln('📁 [$className] $emoji [$timestamp] → Message: $message');

    if (error != null) {
      buffer.writeln('→ Error: $error');
    }

    if (stackTrace != null) {
      buffer.writeln('→ StackTrace: $stackTrace');
    }

    return [buffer.toString().trim()];
  }
}
