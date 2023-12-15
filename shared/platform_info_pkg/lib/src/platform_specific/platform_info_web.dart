import 'dart:async';

import 'package:dependency_interfaces/dependency_interfaces.dart' as dep show PlatformInfo;
import 'package:device_info_plus/device_info_plus.dart';

final class PlatformInfoImpl implements dep.PlatformInfo {
  final DeviceInfoPlugin _deviceInfo = DeviceInfoPlugin();

  @override
  Future<String?> get version => _deviceInfo.webBrowserInfo.then((value) => value.appVersion);
}
