/*
 * Copyright © 2023 Gossen Metrawatt GmbH
 * All rights reserved.
 */

import 'dart:async';

typedef Permission = Object;

abstract interface class PermissionHandler {
  Future<bool> requestPermissions(Iterable<Permission> permissions);

  Future<bool> retryRequests();

  void clear();
}

abstract interface class PermissionCheckDTO {
  abstract final List<Permission> permissions;
  abstract final FutureOr<PermissionHandler> permissionHandler;
}
