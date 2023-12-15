final class LocalStorageParameters<T> {
  const LocalStorageParameters({required this.key, this.data, this.fromJson, this.predicate});

  final String key;
  final Object? data;
  final T Function(dynamic json)? fromJson;
  final bool Function(T)? predicate;
}
