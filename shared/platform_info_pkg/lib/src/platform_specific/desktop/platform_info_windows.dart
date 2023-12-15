/*
 * Copyright © 2023 Gossen Metrawatt GmbH
 * All rights reserved.
 */

import 'dart:async';

import 'package:dependency_interfaces/dependency_interfaces.dart' as dep show PlatformInfo;
import 'package:device_info_plus/device_info_plus.dart';

final class PlatformInfoWindows implements dep.PlatformInfo {
  final DeviceInfoPlugin _deviceInfo = DeviceInfoPlugin();

  @override
  Future<String?> get version => _deviceInfo.windowsInfo.then((value) => value.buildNumber.toString());
}
