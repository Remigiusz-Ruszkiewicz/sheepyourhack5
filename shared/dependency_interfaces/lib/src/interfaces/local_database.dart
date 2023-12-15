import 'dart:async';

import 'package:dependency_interfaces/src/base/disposable.dart';

abstract interface class LocalDatabase implements Disposable {
  Future<LocalDatabaseInstance> openInstance(
    List<CollectionSchema<dynamic>> schemas, {
    required String path,
    required String dbName,
    int maxSizeMiB,
    bool relaxedDurability = true,
    CompactCondition? compactOnLaunch,
    bool inspector = true,
  });
}

abstract interface class LocalDatabaseInstance implements Disposable {
  Future<List<T?>> getAll<T>({List<int> ids = const []});

  Future<int> getCount<T>();

  FutureOr<R> getByQuery<T, R>(FutureOr<R> Function(IsarCollection<T> collection) query);

  Future<int> delete<T>(List<int> ids);

  Stream<R> observeCollection<T, R>(FutureOr<R> Function(IsarCollection<T> collection) select, {Duration? sampleTime});

  Stream<void> observeCollections(DbCollectionsObserveRequest observer);
}

abstract interface class DbCollectionsObserveRequest {
  abstract final Duration sampleTime;
}

typedef IsarCollection<T> = Object;
typedef CollectionSchema<T> = Object;
typedef CompactCondition = Object;
