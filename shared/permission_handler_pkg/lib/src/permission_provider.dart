import 'package:dependency_interfaces/dependency_interfaces.dart' as dep
    show Logger, PermissionHandler, PlatformIdentifier;

import 'package:permission_handler/permission_handler.dart';

final class PermissionProvider implements dep.PermissionHandler {
  PermissionProvider(this._platformVersion, {dep.Logger? logger}) : _logger = logger;

  static Future<PermissionProvider> createAsync(Future<String?> version, {dep.Logger? logger}) async {
    final value = int.tryParse((await version) ?? '0');
    return PermissionProvider(value ?? 0, logger: logger);
  }

  final int _platformVersion;
  final dep.Logger? _logger;
  final Map<Permission, PermissionStatus> _deniedPermissions = {};

  @override
  Future<bool> requestPermissions(Iterable<Object> permissions) async {
    _deniedPermissions.clear();
    final List<Permission> filtered = _filterPermissions(permissions);

    if (filtered.isNotEmpty) {
      final results = await filtered.request();

      final denied = {
        for (final entry in results.entries)
          if (entry.value.isDenied || entry.value.isPermanentlyDenied) entry.key: entry.value,
      };

      if (denied.isNotEmpty) {
        _logDeniedPerms(denied);
        _deniedPermissions.addAll(denied);
        return false;
      }
    }
    return true;
  }

  @override
  Future<bool> retryRequests() async {
    final toRequest = Map<Permission, PermissionStatus>.from(_deniedPermissions);
    _deniedPermissions.clear();

    for (final MapEntry<Permission, PermissionStatus> entry in toRequest.entries) {
      if (entry.value.isPermanentlyDenied) {
        await openAppSettings();
      }
      final result = await entry.key.request();
      if (result.isDenied || result.isPermanentlyDenied) {
        _deniedPermissions[entry.key] = result;
      }
    }

    if (_deniedPermissions.isNotEmpty) {
      _logDeniedPerms(_deniedPermissions);
      return false;
    }
    return true;
  }

  @override
  void clear() => _deniedPermissions.clear();

  void _logDeniedPerms(Map<Permission, PermissionStatus> denied) {
    _logger?.w('Denied permissions: ${denied.keys.join(', ')}');
  }

  List<Permission> _filterPermissions(Iterable<Object> perms) {
    final permissions = perms.whereType<Permission>();
    if (dep.PlatformIdentifier.isAndroid) {
      return [
        for (final permission in permissions)
          if (_androidFilters[permission]?.call(_platformVersion) ?? true) permission,
      ];
    }
    return permissions.toList(growable: false);
  }

  final Map<Permission, bool Function(int sdkVersion)> _androidFilters = {
    Permission.bluetooth: (version) => version <= 30,
    // TODO(KD): change location handling
    Permission.location: (version) => version <= 30,
  };
}
