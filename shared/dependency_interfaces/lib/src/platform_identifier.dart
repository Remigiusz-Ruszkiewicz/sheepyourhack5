/*
 * Copyright © 2023 Gossen Metrawatt GmbH
 * All rights reserved.
 */

import 'package:flutter/foundation.dart' show TargetPlatform, defaultTargetPlatform, kIsWeb;

sealed class PlatformIdentifier {
  PlatformIdentifier._();

  static RuntimePlatform get currentPlatform => _platform;

  static final bool isWeb = RuntimePlatform.web == _platform;

  static final bool isWindows = RuntimePlatform.windows == _platform;

  static final bool isMacOS = RuntimePlatform.macOS == _platform;

  static final bool isLinux = RuntimePlatform.linux == _platform;

  static final bool isAndroid = RuntimePlatform.android == _platform;

  static final bool isIOS = RuntimePlatform.iOS == _platform;

  static final bool isFuchsia = RuntimePlatform.fuchsia == _platform;

  static final RuntimePlatform _platform = () {
    if (kIsWeb) {
      return RuntimePlatform.web;
    }
    return switch (defaultTargetPlatform) {
      TargetPlatform.windows => RuntimePlatform.windows,
      TargetPlatform.macOS => RuntimePlatform.macOS,
      TargetPlatform.linux => RuntimePlatform.linux,
      TargetPlatform.android => RuntimePlatform.android,
      TargetPlatform.iOS => RuntimePlatform.iOS,
      TargetPlatform.fuchsia => RuntimePlatform.fuchsia
    };
  }.call();
}

enum RuntimePlatform {
  android,
  fuchsia,
  iOS,
  linux,
  macOS,
  windows,
  web,
}
