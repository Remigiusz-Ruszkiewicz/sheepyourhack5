/*
 * Copyright © 2023 Gossen Metrawatt GmbH
 * All rights reserved.
 */

abstract interface class PlatformInfo {
  Future<String?> get version;
}
