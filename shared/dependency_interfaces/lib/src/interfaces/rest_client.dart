import 'dart:convert';

import 'package:dependency_interfaces/src/base/disposable.dart';

abstract interface class RestClient implements Disposable {
  Future<Object> get<T>(String uri, {T Function(dynamic json)? fromJson, Map<String, String>? headers});

  Future<Object> post<T>(
    String uri, {
    Object? data,
    T Function(dynamic json)? fromJson,
    Map<String, String>? headers,
    Encoding? encoding,
  });

  void put();

  void delete();
}
