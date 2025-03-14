import 'package:logger/logger.dart';

class LoggerConfig extends LogPrinter {
  final String className;

  LoggerConfig(this.className);

  static final Map<Level, String> levelEmojis = {
    Level.verbose: '🔍',
    Level.debug: '🐛',
    Level.info: 'ℹ️',
    Level.warning: '⚠️',
    Level.error: '❌',
    Level.wtf: '💀',
  };

  @override
  List<String> log(LogEvent event) {
    final emoji = levelEmojis[event.level] ?? '🔹';
    final message = event.message;
    final error = event.error;

    final logMessage = '$emoji [$className] - $message';

    if (error != null) {
      return ['$logMessage\n❗ ERROR: $error'];
    }

    return [logMessage];
  }
}

// Global function to create a logger instance
Logger getLogger(String className) {
  return Logger(printer: LoggerConfig(className));
}
