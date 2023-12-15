/*
 * Copyright © 2023 Gossen Metrawatt GmbH
 * All rights reserved.
 */

import 'dart:async';
import 'dart:collection';
import 'dart:math';
import 'package:background_worker_pkg/src/background_stream_controller.dart';
import 'package:dependency_interfaces/dependency_interfaces.dart' as dep
    show
        BackgroundServiceCommand,
        BackgroundWorker,
        MessageWrapper,
        ServiceInitializer,
        WrappedEmptyResult,
        WrappedResult;
import 'package:flutter/foundation.dart';

const int _intMaxValue = 1 << 32; // max allowed by Random.nextInt

abstract base class WorkerBase implements dep.BackgroundWorker {
  WorkerBase(this._sendCallback, Stream<Object?> resultStream)
      : _resultCallbacks = HashMap<String, ValueChanged<dep.WrappedResult<Object?>>>() {
    _resultSubscription ??= resultStream.listen(
      (event) {
        if (event is dep.WrappedResult<Object?>) {
          _resultCallbacks[event.commandId]?.call(event);
        }
      },
      onDone: () async {
        await _resultSubscription?.cancel();
        _resultSubscription = null;
      },
    );
  }

  final ValueChanged<Object?> _sendCallback;
  final HashMap<String, ValueChanged<dep.WrappedResult<Object?>>> _resultCallbacks;
  StreamSubscription<Object?>? _resultSubscription;
  final Random _random = Random();

  @override
  void runCommand<S>(dep.BackgroundServiceCommand serviceName, Enum command, [S? param]) {
    _sendMessage<void, S?>(_getIdentifier(serviceName, command), serviceName, command, param);
  }

  @override
  Future<void> runVoid<S>(dep.BackgroundServiceCommand serviceName, Enum command, [S? param]) {
    return _runForFuture<void, S?>(_getIdentifier(serviceName, command), serviceName, command, param);
  }

  @override
  Future<T> runForResult<T extends Object?, S>(dep.BackgroundServiceCommand serviceName, Enum command, [S? param]) {
    return _runForFuture<T, S?>(_getIdentifier(serviceName, command), serviceName, command, param);
  }

  @override
  Future<void> registerService(dep.BackgroundServiceCommand serviceName, dep.ServiceInitializer initializer) {
    return _runForFuture<void, dep.ServiceInitializer>(
      '${dep.BackgroundServiceCommand.registerService.name}_$serviceName',
      serviceName,
      dep.BackgroundServiceCommand.registerService,
      initializer,
    );
  }

  Future<T> _runForFuture<T, S>(String commandId, dep.BackgroundServiceCommand serviceName, Enum command, S param) {
    final completer = Completer<T>();
    _resultCallbacks[commandId] = (dep.WrappedResult<Object?> result) {
      _resultCallbacks.remove(result.commandId);
      completer.complete(result.unwrap<T>());
    };
    _sendMessage<T, S>(commandId, serviceName, command, param);
    return completer.future;
  }

  @override
  Stream<T> runForStream<T extends Object?, S>(dep.BackgroundServiceCommand serviceName, Enum command, [S? param]) {
    final commandId = _getIdentifier(serviceName, command);
    final handler = BackgroundStreamController<T>();
    handler.onCancel = () {
      _resultCallbacks.remove(commandId);
      _sendMessage<void, String>(commandId, serviceName, dep.BackgroundServiceCommand.cancelRedirection, commandId);
      handler.close();
    };
    _resultCallbacks[commandId] = (dep.WrappedResult<Object?> result) {
      if (result is dep.WrappedEmptyResult) {
        _resultCallbacks.remove(result.commandId);
        handler.close();
      } else {
        handler.add(result.unwrap<T>());
      }
    };
    _sendMessage<T, S?>(commandId, serviceName, command, param);
    return handler.stream;
  }

  void _sendMessage<T, S>(String commandId, dep.BackgroundServiceCommand serviceName, Enum command, S arg) {
    _sendCallback(dep.MessageWrapper<T, S>(commandId, serviceName, command, arg));
  }

  String _getIdentifier(dep.BackgroundServiceCommand serviceName, Enum command) {
    return '${serviceName.name}_${command.name}_${_random.nextInt(_intMaxValue)}';
  }

  @override
  @mustCallSuper
  Future<void> dispose() async {
    await _resultSubscription?.cancel();
    _resultSubscription = null;
    _resultCallbacks.clear();
  }
}
