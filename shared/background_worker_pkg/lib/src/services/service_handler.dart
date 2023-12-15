/*
 * Copyright © 2023 Gossen Metrawatt GmbH
 * All rights reserved.
 */

import 'dart:async';
import 'dart:collection';
import 'package:background_worker_pkg/src/exceptions/handle_command_exception.dart';
import 'package:dependency_interfaces/dependency_interfaces.dart' as dep
    show BackgroundServiceCommand, Logger, MessageWrapper, Service, ServiceInitializer, WrappedResult;
import 'package:flutter/foundation.dart';

final class ServiceHandler {
  ServiceHandler() : _services = HashMap<dep.BackgroundServiceCommand, dep.Service>();

  final HashMap<dep.BackgroundServiceCommand, dep.Service> _services;

  Future<void> onCommand(
    dep.MessageWrapper<Object?, Object?> messageWrapper,
    void Function(dep.WrappedResult<Object?>) callback,
  ) async {
    if (messageWrapper.command == dep.BackgroundServiceCommand.registerService) {
      if (_services.containsKey(messageWrapper.serviceName)) {
        _reportError(HandleCommandException('Service ${messageWrapper.serviceName} is already registered'));
      } else if (messageWrapper.arg case final dep.ServiceInitializer initializer) {
        _services[messageWrapper.serviceName] = initializer(_services, messageWrapper.serviceName);
      } else {
        _reportError(HandleCommandException('Incorrect ${messageWrapper.serviceName.name} service initializer'));
      }
    } else {
      final service = _services[messageWrapper.serviceName];
      if (service != null) {
        await service.handleCommand(messageWrapper, callback);
        return;
      }
      _reportError(HandleCommandException('Service ${messageWrapper.serviceName.name} not found'));
    }
    callback(messageWrapper.wrapEmpty());
  }

  void _reportError(HandleCommandException exception) {
    final logger = _services[dep.BackgroundServiceCommand.loggerBackground] as dep.Logger?;
    logger?.w('ServiceHandler.onCommand error', error: exception);
    if (kDebugMode) {
      throw exception;
    }
  }
}
