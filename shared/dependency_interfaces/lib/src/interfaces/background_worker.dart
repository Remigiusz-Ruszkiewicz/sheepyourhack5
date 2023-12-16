import 'dart:async';

import 'package:dependency_interfaces/dependency_interfaces.dart' show BackgroundServiceCommand, ServiceInitializer;
import 'package:dependency_interfaces/src/base/disposable.dart';

abstract interface class BackgroundWorker implements Disposable {
  void runCommand<S>(BackgroundServiceCommand serviceName, Enum command, [S param]);

  Future<void> runVoid<S>(BackgroundServiceCommand serviceName, Enum command, [S param]);

  Future<T> runForResult<T extends Object?, S>(BackgroundServiceCommand serviceName, Enum command, [S? param]);

  Future<void> registerService(BackgroundServiceCommand serviceName, ServiceInitializer initializer);

  Stream<T> runForStream<T extends Object?, S>(BackgroundServiceCommand serviceName, Enum command, [S? param]);
}
