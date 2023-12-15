/*
 * Copyright © 2023 Gossen Metrawatt GmbH
 * All rights reserved.
 */

import 'package:dependency_interfaces/dependency_interfaces.dart' as dep
    show Logger, MessageWrapper, Service, WrappedResult;
import 'package:logger_pkg/src/helpers/constants.dart';
import 'package:logger_pkg/src/logger_provider.dart';

final class LoggerService extends dep.Service implements dep.Logger {
  LoggerService(super.services, super.backgroundService);

  dep.Logger? _instance;

  @override
  String get logDirectoryPath => _instance!.logDirectoryPath;

  @override
  void d(dynamic message, {DateTime? time, Object? error, StackTrace? stackTrace}) {
    _instance!.d(message, error: error, stackTrace: stackTrace);
  }

  @override
  void e(dynamic message, {DateTime? time, Object? error, StackTrace? stackTrace}) {
    _instance!.e(message, error: error, stackTrace: stackTrace);
  }

  @override
  void i(dynamic message, {DateTime? time, Object? error, StackTrace? stackTrace}) {
    _instance!.i(message, error: error, stackTrace: stackTrace);
  }

  @override
  void t(dynamic message, {DateTime? time, Object? error, StackTrace? stackTrace}) {
    _instance!.t(message, error: error, stackTrace: stackTrace);
  }

  @override
  void w(dynamic message, {DateTime? time, Object? error, StackTrace? stackTrace}) {
    _instance!.w(message, error: error, stackTrace: stackTrace);
  }

  @override
  void f(dynamic message, {DateTime? time, Object? error, StackTrace? stackTrace}) {
    _instance!.f(message, error: error, stackTrace: stackTrace);
  }

  @override
  Future<void> dispose() async {
    await _instance?.dispose();
    super.dispose();
  }

  @override
  Future<void> handleCommand(
    dep.MessageWrapper<Object?, Object?> messageWrapper,
    void Function(dep.WrappedResult<Object?> data) callback,
  ) async {
    if (messageWrapper.command == LoggerCommands.init) {
      _instance = await LoggerProvider.createAsync(messageWrapper.arg! as String, Constants.serviceSuffix);
    } else if (messageWrapper.command == LoggerCommands.dispose) {
      await dispose();
    }
    callback(messageWrapper.wrapEmpty());
  }
}
