/*
 * Copyright © 2023 Gossen Metrawatt GmbH
 * All rights reserved.
 */

import 'dart:async';
import 'package:dependency_interfaces/dependency_interfaces.dart' as dep
    show BackgroundServiceCommand, BackgroundWorker, BackgroundWrapper, LocalStorage, Logger, createAsync;
import 'package:local_storage_pkg/src/enums/local_storage_commands.dart';
import 'package:local_storage_pkg/src/instances/local_storage_service.dart';
import 'package:local_storage_pkg/src/models/local_storage_parameters.dart';

final class LocalStorageProvider implements dep.LocalStorage {
  LocalStorageProvider._(this._backgroundService);

  final dep.BackgroundWrapper _backgroundService;

  static Future<LocalStorageProvider> createAsync(dep.BackgroundWorker backgroundWorker, {dep.Logger? logger}) =>
      dep.createAsync<LocalStorageProvider, LocalStorageService>(
        LocalStorageProvider._,
        LocalStorageService.new,
        dep.BackgroundWrapper(backgroundWorker, dep.BackgroundServiceCommand.localStorage),
        logger: logger,
      );

  @override
  Future<T?> loadData<T>(String key, T Function(dynamic json) fromJson) {
    return _backgroundService.runForResult<T?, LocalStorageParameters<T>>(
      LocalStorageCommand.loadData,
      LocalStorageParameters<T>(key: key, fromJson: fromJson),
    );
  }

  @override
  Future<bool> storeData(String key, Object data) {
    return _backgroundService.runForResult<bool, LocalStorageParameters<void>>(
      LocalStorageCommand.storeData,
      LocalStorageParameters<void>(key: key, data: data),
    );
  }

  @override
  Future<bool> replaceOnList<T>(
    String key,
    T toEdit,
    T Function(dynamic json) fromJson,
    bool Function(dynamic) predicate,
  ) {
    return _backgroundService.runForResult<bool, LocalStorageParameters<T>>(
      LocalStorageCommand.replaceOnList,
      LocalStorageParameters<T>(key: key, data: toEdit, fromJson: fromJson, predicate: predicate),
    );
  }

  @override
  Future<bool> deleteData(String key) {
    return _backgroundService.runForResult<bool, LocalStorageParameters<void>>(
      LocalStorageCommand.deleteData,
      LocalStorageParameters<void>(key: key),
    );
  }

  @override
  Future<bool> removeFromList<T>(String key, List<T> toRemove, T Function(dynamic json) fromJson) {
    return _backgroundService.runForResult<bool, LocalStorageParameters<T>>(
      LocalStorageCommand.removeFromList,
      LocalStorageParameters<T>(key: key, data: toRemove, fromJson: fromJson),
    );
  }

  @override
  Future<void> dispose() async {
    await _backgroundService.runVoid<void>(LocalStorageCommand.dispose);
  }
}
