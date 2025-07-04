import 'package:budget_wise/shared/constant/common_constant.dart';
import 'package:budget_wise/shared/utils/datetime_util.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:logger/logger.dart';

class LoggerConfig extends LogPrinter {
  final String className;

  LoggerConfig(this.className);

  static final bool _isLoggingEnabled =
      dotenv.env['LOGGING_ENABLED']?.toLowerCase() == 'true';
  static final bool _isDebugMode =
      dotenv.env['LOGGING_DEBBUD_MODE']?.toLowerCase() == 'true';

  final Map<Level, AnsiColor> levelColors = {
    Level.verbose: AnsiColor.fg(AnsiColor.grey(0.5)),
    Level.debug: const AnsiColor.fg(8), // Gray
    Level.info: const AnsiColor.fg(12), // Blue
    Level.warning: const AnsiColor.fg(208), // Orange
    Level.error: const AnsiColor.fg(196), // Red
    Level.wtf: const AnsiColor.fg(199), // Pink/Red
  };

  @override
  List<String> log(LogEvent event) {
    if (!_isLoggingEnabled) return [];
    if (event.level == Level.debug && !_isDebugMode) return [];

    final emoji = CommonConstant.levelEmojis[event.level] ?? '';
    final timestamp = UtilsDateTime.dateTimeSecondFormat(DateTime.now());
    final message = event.message;
    final error = event.error;
    final stackTrace = event.stackTrace;
    final separator = '─' * 100;

    final buffer = StringBuffer()
      ..writeln('')
      ..writeln(separator);

    if (_isDebugMode) {
      buffer.writeln("*** LOG DEBUG ***");
    }

    buffer
      ..writeln('📦 Source    : [$className]')
      ..writeln('$emoji Timestamp : $timestamp')
      ..writeln('🔷 Message   : $message');

    if (error != null) {
      buffer.writeln('❌ Error     : $error');
    }

    if (stackTrace != null) {
      buffer.writeln('📌 StackTrace:\n$stackTrace');
    }

    buffer.writeln(separator);

    return [buffer.toString().trim()];
  }
}
