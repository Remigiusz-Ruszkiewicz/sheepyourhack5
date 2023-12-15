/*
 * Copyright © 2023 Gossen Metrawatt GmbH
 * All rights reserved.
 */

import 'package:dependency_interfaces/dependency_interfaces.dart' as dep
    show BackgroundServiceCommand, BackgroundWorker, BackgroundWrapper;
import 'package:logger_pkg/src/helpers/constants.dart';
import 'package:logger_pkg/src/instances/logger_service.dart';

final class LoggerServiceProvider {
  LoggerServiceProvider._(this._backgroundService);

  final dep.BackgroundWrapper _backgroundService;

  static Future<LoggerServiceProvider> createAsync(
    dep.BackgroundWorker backgroundWorker,
    String applicationName,
  ) async {
    final backgroundService = dep.BackgroundWrapper(backgroundWorker, dep.BackgroundServiceCommand.loggerBackground);
    await backgroundService.registerService(LoggerService.new);
    await backgroundService.runVoid<String>(LoggerCommands.init, applicationName);
    return LoggerServiceProvider._(backgroundService);
  }

  Future<void> dispose() async {
    await _backgroundService.runVoid<void>(LoggerCommands.dispose);
  }
}
