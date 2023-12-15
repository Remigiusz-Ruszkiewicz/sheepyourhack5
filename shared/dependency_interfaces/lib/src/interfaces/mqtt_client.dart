/*
 * Copyright © 2023 Gossen Metrawatt GmbH
 * All rights reserved.
 */

import 'dart:async';

import 'package:dependency_interfaces/src/base/disposable.dart';

abstract interface class MqttClient implements Disposable {
  Future<bool> connect({
    required String server,
    required String clientId,
    int port,
    int maxConnectionAttempts,
    int keepAlivePeriod,
    String? username,
    String? password,
    Enum qos,
    bool mqttLogging,
    Enum version,
    Object? testament,
  });

  void disconnect();

  Stream<T> subscribe<T>(String topic, T Function(dynamic json) fromJson);

  FutureOr<int?> publish<T>(String topic, T message);
}
