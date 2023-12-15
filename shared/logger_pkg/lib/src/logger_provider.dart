import 'package:dependency_interfaces/dependency_interfaces.dart' as dep show Logger;
import 'package:flutter/foundation.dart';
import 'package:logger_pkg/src/instances/logger_debug.dart';
import 'package:logger_pkg/src/instances/logger_release.dart';

final class LoggerProvider implements dep.Logger {
  LoggerProvider._(this._instance);

  static Future<LoggerProvider> createAsync(String applicationName, [String? suffix]) async {
    const instanceInitializer = kDebugMode ? LoggerDebug.createAsync : LoggerRelease.createAsync;
    return LoggerProvider._(await instanceInitializer(applicationName, suffix));
  }

  final dep.Logger _instance;

  @override
  String get logDirectoryPath => _instance.logDirectoryPath;

  @override
  void d(dynamic message, {DateTime? time, Object? error, StackTrace? stackTrace}) {
    _instance.d(message, error: error, stackTrace: stackTrace);
  }

  @override
  void e(dynamic message, {DateTime? time, Object? error, StackTrace? stackTrace}) {
    _instance.e(message, error: error, stackTrace: stackTrace);
  }

  @override
  void i(dynamic message, {DateTime? time, Object? error, StackTrace? stackTrace}) {
    _instance.i(message, error: error, stackTrace: stackTrace);
  }

  @override
  void t(dynamic message, {DateTime? time, Object? error, StackTrace? stackTrace}) {
    _instance.t(message, error: error, stackTrace: stackTrace);
  }

  @override
  void w(dynamic message, {DateTime? time, Object? error, StackTrace? stackTrace}) {
    _instance.w(message, error: error, stackTrace: stackTrace);
  }

  @override
  void f(dynamic message, {DateTime? time, Object? error, StackTrace? stackTrace}) {
    _instance.f(message, error: error, stackTrace: stackTrace);
  }

  @override
  Future<void> dispose() async {
    await _instance.dispose();
  }
}
