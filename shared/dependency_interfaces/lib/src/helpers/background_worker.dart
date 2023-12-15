import 'package:dependency_interfaces/dependency_interfaces.dart';

final class BackgroundWrapper {
  BackgroundWrapper(this._worker, this._serviceName);

  final BackgroundWorker _worker;
  final BackgroundServiceCommand _serviceName;

  void runCommand<S>(Enum command, [S? param]) => _worker.runCommand(_serviceName, command, param);

  Future<void> runVoid<S>(Enum command, [S? param]) => _worker.runVoid(_serviceName, command, param);

  Future<T> runForResult<T extends Object?, S>(Enum command, [S? param]) {
    return _worker.runForResult<T, S>(_serviceName, command, param);
  }

  Future<void> registerService(ServiceInitializer initializer) => _worker.registerService(_serviceName, initializer);

  Stream<T> runForStream<T extends Object?, S>(Enum command, [S? param]) {
    return _worker.runForStream<T, S>(_serviceName, command, param);
  }
}
