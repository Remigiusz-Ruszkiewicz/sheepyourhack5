/*
 * Copyright © 2023 Gossen Metrawatt GmbH
 * All rights reserved.
 */

import 'dart:async';

import 'package:dependency_interfaces/dependency_interfaces.dart' as dep show PermissionCheckDTO, PermissionHandler;
import 'package:permission_handler/permission_handler.dart';

class PermissionCheck implements dep.PermissionCheckDTO {
  const PermissionCheck({
    required this.permissions,
    required this.permissionHandler,
  });

  @override
  final List<Permission> permissions;
  @override
  final FutureOr<dep.PermissionHandler> permissionHandler;
}
