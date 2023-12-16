import 'dart:async';

import 'package:dependency_interfaces/dependency_interfaces.dart';
import 'package:dependency_interfaces/src/base/instantiable.dart';

abstract interface class SerialCommunication implements Instantiable {
  FutureOr<List<String>> get getAvailableDevices;

  FutureOr<SocketConnection?> connect(String address);

  FutureOr<void> disconnect();

  FutureOr<void> reloadDevices();

  FutureOr<List<Object>> getRemoteDevices([RegExp? filter]);
}
