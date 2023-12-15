import 'dart:async';
import 'dart:isolate';

import 'package:background_worker_pkg/src/services/service_handler.dart';
import 'package:background_worker_pkg/src/workers/worker_base.dart';
import 'package:combine/combine.dart';
import 'package:dependency_interfaces/dependency_interfaces.dart' as dep show MessageWrapper;
import 'package:flutter/services.dart';

// ignore_for_file: unreachable_from_main

final class CombineWorkerInstance extends WorkerBase {
  CombineWorkerInstance._(this._combineIsolate, super.sendCallback, super.resultStream);

  final CombineIsolate _combineIsolate;

  static Future<CombineWorkerInstance> createAsync(RootIsolateToken isolateToken) {
    return Future.microtask(() async {
      final combineInfo = await Combine().spawn<void>(_computeIsolate, isolateToken: isolateToken);
      return CombineWorkerInstance._(combineInfo.isolate, combineInfo.messenger.send, combineInfo.messenger.messages);
    });
  }

  @override
  Future<void> dispose() async {
    _combineIsolate.kill(priority: Isolate.immediate);
    await super.dispose();
  }
}

@pragma('vm:entry-point')
void _computeIsolate(IsolateContext initData) {
  final ServiceHandler handler = ServiceHandler();
  final messenger = initData.messenger;
  messenger.messages.listen((command) async {
    if (command is dep.MessageWrapper) {
      unawaited(handler.onCommand(command, messenger.send));
    }
  });
}
