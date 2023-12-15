import 'dart:async';

import 'package:dependency_interfaces/dependency_interfaces.dart' as dep
    show PlatformIdentifier, PlatformInfo, RuntimePlatform;
import 'package:platform_info_pkg/src/platform_specific/desktop/platform_info_windows.dart';
import 'package:platform_info_pkg/src/platform_specific/mobile/platform_info_android.dart';
import 'package:platform_info_pkg/src/platform_specific/platform_info_stub.dart' as stub;

final class PlatformInfoImpl implements dep.PlatformInfo {
  PlatformInfoImpl() : _platformInfo = _platformImpl();

  final dep.PlatformInfo _platformInfo;

  @override
  Future<String?> get version => _platformInfo.version;
}

dep.PlatformInfo _platformImpl() => switch (dep.PlatformIdentifier.currentPlatform) {
      dep.RuntimePlatform.windows => PlatformInfoWindows(),
      dep.RuntimePlatform.android => PlatformInfoAndroid(),
      _ => stub.PlatformInfoImpl()
    };
