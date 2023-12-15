/*
 * Copyright © 2023 Gossen Metrawatt GmbH
 * All rights reserved.
 */

import 'dart:async';
import 'dart:convert';
import 'package:dependency_interfaces/dependency_interfaces.dart' as dep
    show LocalStorage, MessageWrapper, Service, WrappedResult;
import 'package:local_storage_pkg/src/enums/local_storage_commands.dart';
import 'package:local_storage_pkg/src/models/local_storage_parameters.dart';
import 'package:shared_preferences/shared_preferences.dart';

final class LocalStorageService extends dep.Service implements dep.LocalStorage {
  LocalStorageService(super.services, super.backgroundService);

  /// Load
  @override
  Future<T?> loadData<T>(String key, T Function(dynamic json) fromJson) async {
    final String? data = await SharedPreferences.getInstance().then((value) => value.getString(key));
    if (data?.isEmpty ?? true) {
      return null;
    }
    return fromJson(jsonDecode(data!));
  }

  /// Add
  @override
  Future<bool> storeData(String key, Object data) {
    return SharedPreferences.getInstance().then((value) => value.setString(key, jsonEncode(data)));
  }

  /// Edit
  @override
  Future<bool> replaceOnList<T>(
    String key,
    T toEdit,
    T Function(dynamic json) fromJson,
    bool Function(T) predicate,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    final object = prefs.getString(key);
    if (object?.isEmpty ?? true) {
      return false;
    }
    final list = (jsonDecode(object!) as Iterable).map(fromJson).toList(growable: false);
    final index = list.indexWhere(predicate);
    if (index > -1) {
      list[index] = toEdit;
      return prefs.setString(key, jsonEncode(list));
    }
    return false;
  }

  /// Delete
  @override
  Future<bool> deleteData(String key) => SharedPreferences.getInstance().then((value) => value.remove(key));

  @override
  Future<bool> removeFromList<T>(String key, List<T> toRemove, T Function(dynamic json) fromJson) async {
    final prefs = await SharedPreferences.getInstance();
    final String? data = prefs.getString(key);
    if (data?.isEmpty ?? true) {
      return false;
    }
    final storedList = (jsonDecode(data!) as Iterable)
        .map((e) => fromJson(e as Map<String, Object?>))
        .skipWhile((item) => toRemove.contains(item))
        .toList(growable: false);
    return prefs.setString(key, jsonEncode(storedList));
  }

  @override
  Future<void> handleCommand(
    dep.MessageWrapper<Object?, Object?> messageWrapper,
    void Function(dep.WrappedResult<Object?> data) callback,
  ) async {
    switch (messageWrapper.command) {
      case LocalStorageCommand.dispose:
        super.dispose();
        break;
      case LocalStorageCommand.loadData:
        final params = messageWrapper.arg! as LocalStorageParameters;
        final result = await loadData(params.key, params.fromJson!);
        callback(messageWrapper(result));
        return;
      case LocalStorageCommand.storeData:
        final params = messageWrapper.arg! as LocalStorageParameters;
        final result = await storeData(params.key, params.data!);
        callback(messageWrapper(result));
        break;
      case LocalStorageCommand.replaceOnList:
        final params = messageWrapper.arg! as LocalStorageParameters;
        final result = await replaceOnList(params.key, params.data, params.fromJson!, params.predicate!);
        callback(messageWrapper(result));
        return;
      case LocalStorageCommand.deleteData:
        final params = messageWrapper.arg! as LocalStorageParameters;
        final result = await deleteData(params.key);
        callback(messageWrapper(result));
        break;
      case LocalStorageCommand.removeFromList:
        final params = messageWrapper.arg! as LocalStorageParameters;
        final result = await removeFromList(params.key, params.data! as List, params.fromJson!);
        callback(messageWrapper(result));
        return;
    }
    callback(messageWrapper.wrapEmpty());
  }
}
