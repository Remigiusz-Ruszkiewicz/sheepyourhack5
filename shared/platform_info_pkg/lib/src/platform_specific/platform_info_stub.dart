/*
 * Copyright © 2023 Gossen Metrawatt GmbH
 * All rights reserved.
 */

import 'dart:async';

import 'package:dependency_interfaces/dependency_interfaces.dart' as dep show PlatformInfo;

final class PlatformInfoImpl implements dep.PlatformInfo {
  @override
  Future<String?> get version => throw UnimplementedError();
}
