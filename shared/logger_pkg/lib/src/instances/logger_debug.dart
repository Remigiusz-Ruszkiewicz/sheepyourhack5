import 'package:logger_pkg/src/helpers/log_recorder.dart';
import 'package:logger_pkg/src/instances/logger_release.dart';

final class LoggerDebug extends LoggerRelease {
  LoggerDebug(super.logRecorder);

  static Future<LoggerDebug> createAsync(String applicationName, [String? suffix]) async {
    return LoggerDebug(await LogRecorder.createAsync(applicationName, suffix));
  }

  @override
  void d(dynamic message, {DateTime? time, Object? error, StackTrace? stackTrace}) {
    _printLog(message, error, stackTrace);
    // TODO(KD): włączyć warunkowo przy realizacji trybu diagnostycznego
    // logRecorder.recordLog(Level.debug, message, error, stackTrace);
  }

  void _printLog(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    final consoleLog = '\x1B[36m$message\x1B[0m'
        '${error == null ? '' : ' | \x1B[31m$error\x1B[0m'}'
        '${stackTrace == null ? '' : '\n\x1B[32m$stackTrace\x1B[0m'}';

    // ignore: avoid_print
    print(consoleLog);
  }
}
