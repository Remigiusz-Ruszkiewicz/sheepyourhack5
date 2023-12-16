import 'package:dependency_interfaces/dependency_interfaces.dart' as dep show Logger;
import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

import 'package:logger_pkg/src/helpers/log_recorder.dart';

base class LoggerRelease implements dep.Logger {
  LoggerRelease(this.logRecorder) : instance = Logger();

  static Future<LoggerRelease> createAsync(String applicationName, [String? suffix]) async {
    return LoggerRelease(await LogRecorder.createAsync(applicationName, suffix));
  }

  final Logger instance;
  final LogRecorder logRecorder;
  @override
  String get logDirectoryPath => logRecorder.logDirectoryPath;

  @override
  void d(dynamic message, {DateTime? time, Object? error, StackTrace? stackTrace}) {}

  @override
  void e(dynamic message, {DateTime? time, Object? error, StackTrace? stackTrace}) {
    instance.e(message, error: error, stackTrace: stackTrace);
    logRecorder.recordLog(Level.error, message, error, stackTrace);
  }

  @override
  void i(dynamic message, {DateTime? time, Object? error, StackTrace? stackTrace}) {
    instance.i(message, error: error, stackTrace: stackTrace);
    logRecorder.recordLog(Level.info, message, error, stackTrace);
  }

  @override
  void t(dynamic message, {DateTime? time, Object? error, StackTrace? stackTrace}) {
    instance.t(message, error: error, stackTrace: stackTrace);
    logRecorder.recordLog(Level.trace, message, error, stackTrace);
  }

  @override
  void w(dynamic message, {DateTime? time, Object? error, StackTrace? stackTrace}) {
    instance.w(message, error: error, stackTrace: stackTrace);
    logRecorder.recordLog(Level.warning, message, error, stackTrace);
  }

  @override
  void f(dynamic message, {DateTime? time, Object? error, StackTrace? stackTrace}) {
    instance.f(message, error: error, stackTrace: stackTrace);
    logRecorder.recordLog(Level.fatal, message, error, stackTrace);
  }

  @override
  @mustCallSuper
  Future<void> dispose() async {
    await logRecorder.dispose();
  }
}
