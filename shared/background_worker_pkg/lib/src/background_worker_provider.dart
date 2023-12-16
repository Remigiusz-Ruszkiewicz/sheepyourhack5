import 'dart:async';
import 'package:background_worker_pkg/src/workers/combine_worker_instance.dart';
import 'package:background_worker_pkg/src/workers/worker_base.dart';
import 'package:dependency_interfaces/dependency_interfaces.dart' as dep
    show BackgroundServiceCommand, BackgroundWorker, ServiceInitializer;
import 'package:flutter/services.dart';

final class BackgroundWorkerProvider implements dep.BackgroundWorker {
  BackgroundWorkerProvider._(this._worker);

  final WorkerBase _worker;

  static Future<BackgroundWorkerProvider> createAsync(RootIsolateToken isolateToken) async {
    final worker = await CombineWorkerInstance.createAsync(isolateToken);
    return BackgroundWorkerProvider._(worker);
  }

  @override
  Future<void> registerService(dep.BackgroundServiceCommand serviceName, dep.ServiceInitializer initializer) {
    return _worker.registerService(serviceName, initializer);
  }

  @override
  void runCommand<S>(dep.BackgroundServiceCommand serviceName, Enum command, [S? param]) {
    _worker.runCommand(serviceName, command, param);
  }

  @override
  Future<void> runVoid<S>(dep.BackgroundServiceCommand serviceName, Enum command, [S? param]) {
    return _worker.runVoid(serviceName, command, param);
  }

  @override
  Future<T> runForResult<T extends Object?, S>(dep.BackgroundServiceCommand serviceName, Enum command, [S? param]) {
    return _worker.runForResult(serviceName, command, param);
  }

  @override
  Stream<T> runForStream<T extends Object?, S>(dep.BackgroundServiceCommand serviceName, Enum command, [S? param]) {
    return _worker.runForStream<T, S>(serviceName, command, param);
  }

  @override
  Future<void> dispose() => _worker.dispose();
}
