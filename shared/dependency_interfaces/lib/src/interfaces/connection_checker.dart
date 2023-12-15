import 'package:dependency_interfaces/src/base/disposable.dart';

abstract interface class ConnectionChecker implements Disposable {
  bool get isNetworkConnected;

  Future<Enum> checkInternetAccess({String? host});

  Stream<Enum> get connectionStatusStream;

  Enum? get connectionStatus;
}
