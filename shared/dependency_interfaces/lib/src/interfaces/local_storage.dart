import 'package:dependency_interfaces/src/base/disposable.dart';

abstract interface class LocalStorage implements Disposable {
  Future<T?> loadData<T>(String key, T Function(dynamic json) fromJson);

  Future<bool> storeData(String key, Object object);

  Future<bool> replaceOnList<T>(
    String key,
    T toEdit,
    T Function(dynamic json) fromJson,
    bool Function(dynamic) predicate,
  );

  Future<bool> deleteData(String key);

  Future<bool> removeFromList<T>(String key, List<T> toRemove, T Function(dynamic json) fromJson);
}
