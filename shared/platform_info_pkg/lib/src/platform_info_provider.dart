import 'dart:async';
import 'package:dependency_interfaces/dependency_interfaces.dart' as dep show PlatformInfo;

import 'package:platform_info_pkg/src/platform_specific/platform_info_stub.dart'
    if (dart.library.html) 'platform_specific/platform_info_web.dart'
    if (dart.library.io) 'platform_specific/platform_info_other.dart';

final class PlatformInfoProvider implements dep.PlatformInfo {
  PlatformInfoProvider();

  final dep.PlatformInfo _platformInfo = PlatformInfoImpl();

  @override
  Future<String?> get version => _platformInfo.version;
}
