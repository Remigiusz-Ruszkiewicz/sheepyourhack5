/*
 * Copyright © 2023 Gossen Metrawatt GmbH
 * All rights reserved.
 */

import 'package:dependency_interfaces/dependency_interfaces.dart';

abstract interface class SerialSocket {
  SocketConnection? get connection;
}
