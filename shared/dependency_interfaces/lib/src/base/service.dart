/*
 * Copyright © 2023 Gossen Metrawatt GmbH
 * All rights reserved.
 */

import 'package:dependency_interfaces/dependency_interfaces.dart';
import 'package:dependency_interfaces/src/base/disposable.dart';
import 'package:flutter/foundation.dart';

abstract base class Service implements Disposable {
  Service(this.services, BackgroundServiceCommand backgroundServiceCommand)
      : _backgroundServiceCommand = backgroundServiceCommand;

  final Map<BackgroundServiceCommand, Service> services;
  final BackgroundServiceCommand _backgroundServiceCommand;
  Logger? _logger;

  Logger? get logger => _logger ??= services[BackgroundServiceCommand.loggerBackground] as Logger?;

  final Map<String, RedirectionCancel> _redirections = {};

  void addRedirection(String commandId, RedirectionCancel redirection) {
    _redirections[commandId] = redirection;
  }

  Future<void> cancelRedirection(String commandId) async {
    await _redirections.remove(commandId)?.cancel();
  }

  Future<void> handleCommand(
    MessageWrapper<Object?, Object?> messageWrapper,
    void Function(WrappedResult<Object?> data) callback,
  );

  @override
  @mustCallSuper
  void dispose() => services.remove(_backgroundServiceCommand);
}
